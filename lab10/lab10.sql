10.2
    1. SELECT z.idzamowienia, z.datarealizacji FROM zamowienia z WHERE z.idklienta IN (SELECT idklienta FROM klienci WHERE nazwa ~ 'Antoni$');
    2. SELECT z.idzamowienia, z.datarealizacji FROM zamowienia z WHERE z.idklienta IN (SELECT idklienta FROM klienci WHERE ulica LIKE '%/%');
    3. SELECT z.idzamowienia, z.datarealizacji FROM zamowienia z WHERE z.idklienta IN (SELECT idklienta FROM klienci WHERE miejscowosc LIKE 'Kraków') AND date_part('month', datarealizacji)=11;
10.3
    1. SELECT z.idzamowienia, z.datarealizacji FROM zamowienia z WHERE z.idklienta IN (SELECT idklienta FROM klienci WHERE datarealizacji='2013-11-12');
    2. SELECT z.idzamowienia, z.datarealizacji FROM zamowienia z WHERE z.idklienta IN (SELECT idklienta FROM klienci WHERE date_part('month', datarealizacji)=11 AND date_part('year', datarealizacji)=2013);
    3. SELECT k.nazwa, k.ulica, k.miejscowosc FROM public.klienci k
            JOIN zamowienia z USING(idklienta) 
            JOIN artykuly a USING(idzamowienia) 
            JOIN pudelka p USING(idpudelka) 
       WHERE p.nazwa IN ('Kremowa fantazja', 'Kolekcja jesienna');
    4. SELECT k.nazwa, k.ulica, k.miejscowosc FROM public.klienci k WHERE idklienta IN (
            SELECT idklienta FROM zamowienia 
            JOIN artykuly a USING(idzamowienia) 
            JOIN pudelka p USING(idpudelka)
       WHERE a.sztuk>=2 AND p.nazwa IN ('Kolekcja jesienna', 'Kremowa fantazja'));
    5. SELECT k.nazwa, k.ulica, k.miejscowosc FROM public.klienci k WHERE idklienta IN (
            SELECT idklienta FROM zamowienia zz
            JOIN artykuly a ON a.idzamowienia=zz.idzamowienia 
            JOIN pudelka p ON p.idpudelka=a.idpudelka
            JOIN zawartosc z ON z.idpudelka=p.idpudelka
            JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki
        WHERE cz.orzechy='migdały');
    6. SELECT k.nazwa, k.miejscowosc, k.idklienta FROM klienci k WHERE EXISTS(SELECT z.idklienta FROM zamowienia z WHERE z.idklienta=k.idklienta);
    7. SELECT k.nazwa, k.miejscowosc, k.idklienta FROM klienci k WHERE NOT EXISTS(SELECT z.idklienta FROM zamowienia z WHERE z.idklienta=k.idklienta);
10.4
    1. SELECT p.nazwa FROM public.pudelka p WHERE p.idpudelka
       IN(SELECT z.idpudelka FROM zawartosc z WHERE z.idczekoladki='d09');
    2. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE cz.nazwa ='Gorzka truskawkowa') ;
    3. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE cz.nazwa ~ '^[sS]') ;
    4. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z WHERE z.sztuk>=4) ;
    5. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE z.sztuk>=3 AND cz.nazwa ~ 'Gorzka truskawkowa') ;
    6. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE cz.nadzienie ~ 'truskawki') ;
    7. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka NOT IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE cz.czekolada ~ 'gorzka') ;
    8. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE cz.orzechy IS NULL) ;
    9. SELECT p.nazwa, p.opis, p.cena FROM public.pudelka p WHERE p.idpudelka IN (SELECT z.idpudelka FROM zawartosc z JOIN czekoladki cz USING(idczekoladki) WHERE cz.nadzienie IS NULL) ;
10.5
    1. SELECT cz.idczekoladki, cz.nazwa FROM public.czekoladki cz WHERE EXISTS(SELECT cz2.idczekoladki FROM czekoladki cz2 WHERE cz2.idczekoladki ='D08' AND cz.koszt>cz2.koszt);
    2. SELECT k.nazwa FROM public.klienci k JOIN zamowienia z USING(idklienta) JOIN artykuly a USING(idzamowienia) WHERE a.idpudelka = ANY (SELECT a.idpudelka FROM artykuly a JOIN zamowienia z USING(idzamowienia) WHERE z.idklienta IN (SELECT k.idklienta FROM klienci k WHERE k.nazwa = 'Gorka Alicja'));

    3. SELECT DISTINCT k.nazwa, k.miejscowosc FROM klienci k JOIN zamowienia z USING(idklienta) JOIN artykuly a USING(idzamowienia) WHERE a.idpudelka = ANY (SELECT a.idpudelka FROM artykuly a JOIN zamowienia z USING(idzamowienia) WHERE z.idklienta IN (SELECT k.idklienta FROM klienci k WHERE k.miejscowosc = 'Katowice'));
10.6 
    1. WITH query AS (SELECT idpudelka, SUM(sztuk) as sum FROM zawartosc GROUP BY idpudelka)
SELECT p.nazwa, q.idpudelka, q.sum FROM pudelka p JOIN query q USING (idpudelka) WHERE q.sum >= ALL (SELECT sum FROM query);
    1. WITH query AS (SELECT idpudelka, SUM(sztuk) as sum FROM zawartosc GROUP BY idpudelka)
SELECT p.nazwa, q.idpudelka, q.sum FROM pudelka p JOIN query q USING (idpudelka) WHERE q.sum = (SELECT MAX(sum) FROM query);

    2. WITH query AS (SELECT idpudelka, SUM(sztuk) as sum FROM zawartosc GROUP BY idpudelka)
SELECT p.nazwa, q.idpudelka, q.sum FROM pudelka p JOIN query q USING (idpudelka) WHERE q.sum = (SELECT MIN(sum) FROM query);
    3. WITH query AS (SELECT idpudelka, SUM(sztuk) as sum FROM zawartosc GROUP BY idpudelka)
SELECT p.nazwa, q.idpudelka, q.sum FROM pudelka p JOIN query q USING (idpudelka) WHERE q.sum >= (SELECT AVG(sum) FROM query);
    4. WITH query AS (SELECT idpudelka, SUM(sztuk) as sum FROM zawartosc GROUP BY idpudelka)
SELECT p.nazwa, q.sum FROM pudelka p JOIN query q USING(idpudelka) WHERE q.sum IN (SELECT MAX(sum) FROM query) OR q.sum IN (SELECT MIN(sum) FROM query);
10.7
SELECT
(SELECT COUNT(*) FROM pudelka p2
WHERE p2.idpudelka <= p1.idpudelka) AS "L. p.",
p1.idpudelka
FROM pudelka p1
ORDER BY p1.idpudelka;
