Zadanie 1: 
    1. CREATE OR REPLACE FUNCTION masaPudelka(in arg1 CHARACTER(4)) 
       RETURNS INTEGER AS 
       $$ 
       DECLARE wynik INTEGER;
       BEGIN 
       SELECT SUM(c.masa*z.sztuk) INTO wynik
       FROM 
        pudelka p 
        JOIN zawartosc z USING(idpudelka)
        JOIN czekoladki c USING(idczekoladki)
       WHERE idpudelka = arg1;
       RETURN wynik;
       END; 
       $$
       LANGUAGE plpgsql;

SELECT masaPudelka('alls');
    
    2. CREATE OR REPLACE FUNCTION liczbaCzekoladek(in arg1 CHARACTER(4)) 
       RETURNS INTEGER AS 
        $$ 
        DECLARE wynik INTEGER;
        BEGIN 
        SELECT SUM(z.sztuk) INTO wynik
        FROM 
            pudelka p 
            JOIN zawartosc z USING(idpudelka)
        WHERE idpudelka = arg1;
        RETURN wynik;
        END;
        $$
        LANGUAGE plpgsql;

    SELECT liczbaCzekoladek('alls');

Zadanie 2: 
    CREATE OR REPLACE FUNCTION zysk(in arg1 CHARACTER(4))
RETURNS NUMERIC(10,2) AS 
$$
DECLARE
   wynik NUMERIC(10,2);
BEGIN
   SELECT p.cena - 0.9 - SUM(c.koszt*z.sztuk) INTO wynik
   FROM
      pudelka p
      JOIN zawartosc z USING(idpudelka)
      JOIN czekoladki c USING(idczekoladki) 
   WHERE p.idpudelka = arg1 GROUP BY idpudelka, cena; 
   RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT SUM(zysk(a.idpudelka)*a.sztuk)
    FROM 
        zamowienia z 
        JOIN artykuly a USING(idzamowienia)
    WHERE z.datarealizacji >= '2013-11-11'
    AND z.datarealizacji <= '2013-11-17';


Zadanie 3:
    1. CREATE OR REPLACE FUNCTION sumaZamowien(in arg1 INTEGER)
RETURNS INTEGER AS
$$
DECLARE
     wynik INTEGER;
BEGIN
    SELECT SUM(a.sztuk*p.cena) INTO wynik
    FROM 
        zamowienia z
        JOIN artykuly a USING(idzamowienia)
        JOIN pudelka p USING(idpudelka) 
    WHERE z.idklienta=arg1;
 
    RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT sumaZamowien(1);

2. CREATE OR REPLACE FUNCTION rabat(in arg1 INTEGER) 
RETURNS INTEGER AS
$$
DECLARE wynik INTEGER;
DECLARE wartoscZamowien INTEGER;
BEGIN
     SELECT SUM(a.sztuk*p.cena) INTO wartoscZamowien 
     FROM 
         zamowienia z 
         JOIN artykuly a USING(idzamowienia)
         JOIN pudelka p USING(idpudelka)
     WHERE z.idklienta = arg1;
     IF wartoscZamowien BETWEEN 101 AND 200 THEN
        wynik := 4;
     ELSIF wartoscZamowien BETWEEN 201 AND 400 THEN
        wynik := 7;
     ELSIF wartoscZamowien >= 401 THEN 
        wynik := 8;
     ELSE 
        wynik := 0;
     END IF;
     RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT rabat(1);

ZADANIE 4.

CREATE OR REPLACE FUNCTION podwyzka()
RETURNS VOID AS
$$
DECLARE zmiana NUMERIC(7,2);
DECLARE c1 RECORD;
DECLARE c2 RECORD;
BEGIN
   FOR c1 IN SELECT * FROM czekoladki LOOP
       zmiana := case
                 when c1.koszt < 20 then 0.03
                 when c1.koszt BETWEEN 20 AND 29 then 0.04
                 else 0.05 end;
       UPDATE czekoladki SET koszt=koszt+zmiana WHERE idczekoladki = c1.idczekoladki; 
       FOR c2 in SELECT * FROM zawartosc WHERE idczekoladki=c1.idczekoladki LOOP
            UPDATE pudelka SET cena = cena + (zmiana*c2.sztuk) WHERE idpudelka = c2.idpudelka;
       END LOOP;
   END LOOP;
END;
$$ LANGUAGE PLpgSQL;

SELECT podwyzka();

ZADANIE 5.
CREATE OR REPLACE FUNCTION obnizka()
RETURNS VOID AS
$$
DECLARE zmiana NUMERIC(7,2);
DECLARE c1 RECORD;
DECLARE c2 RECORD;
BEGIN
   FOR c1 IN SELECT * FROM czekoladki LOOP
       zmiana := case
                 when c1.koszt < 20 then 0.03
                 when c1.koszt BETWEEN 20 AND 29 then 0.04
                 else 0.05 end;
       UPDATE czekoladki SET koszt=koszt-zmiana WHERE idczekoladki = c1.idczekoladki; 
       FOR c2 in SELECT * FROM zawartosc WHERE idczekoladki=c1.idczekoladki LOOP
            UPDATE pudelka SET cena = cena - (zmiana*c2.sztuk) WHERE idpudelka = c2.idpudelka;
       END LOOP;
   END LOOP;
END;
$$ LANGUAGE PLpgSQL;

SELECT obnizka();

ZADANIE 6.
1.CREATE TEMPORARY TABLE wyniki(id_zamowienia INTEGER, datarealizacji DATE, idpudelka CHAR(4));
CREATE OR REPLACE FUNCTION getZamowienia(in arg1 INTEGER)
RETURNS setof wyniki AS 
$$
BEGIN
   return query
   SELECT z.idzamowienia, z.datarealizacji, a.idpudelka FROM zamowienia z JOIN artykuly a USING (idzamowienia) WHERE idklienta = arg1;
END;
$$ LANGUAGE PLpgSQL;

SELECT getZamowienia(4);


2.CREATE TEMPORARY TABLE wyniki(id_klienta INTEGER, adres_klienta VARCHAR(30));
CREATE OR REPLACE FUNCTION getKlients(in arg1 VARCHAR(10))
RETURNS setof wyniki AS 
$$
BEGIN
   return query
   SELECT k.idklienta, k.ulica FROM public.klienci k WHERE k.miejscowosc = arg1;
END;
$$ LANGUAGE PLpgSQL;

SELECT getKlients('Kraków');

ZADANIE 7.
CREATE OR REPLACE FUNCTION kwiaciarnia.rabat(in arg1 VARCHAR(10))
RETURNS INTEGER AS
$$
DECLARE wynik INTEGER;
DECLARE wartoscZamowien INTEGER;
DECLARE wartoscHistorii INTEGER;
DECLARE wartoscSuma INTEGER; 
BEGIN 
   SELECT SUM(cena) INTO wartoscZamowien FROM kwiaciarnia.zamowienia
         WHERE idklienta = arg1;
   SELECT SUM(cena) INTO wartoscHistorii FROM kwiaciarnia.historia
         WHERE idklienta = arg1 AND termin > CURRENT_DATE - interval '7 days';
   wartoscSuma = wartoscZamowien + wartoscHistorii;
   IF wartoscZamowien BETWEEN 1 AND 100 THEN
      wynik := 5;
   ELSIF wartoscZamowien BETWEEN 101 AND 400 THEN 
      wynik := 10;
   ELSIF wartoscZamowien BETWEEN 401 AND 700 THEN 
      wynik := 15;
   ELSIF wartoscZamowien > 700 THEN 
      wynik := 20;
   ELSE 
      wynik :=0;
   END IF;
   RETURN wynik;
END;
$$ LANGUAGE PLpgSQL;

SELECT kwiaciarnia.rabat('msowins');