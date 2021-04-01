Zadanie 4.2
    1. SELECT z.datarealizacji, z.idzamowienia, z.idklienta FROM public.zamowienia z NATURAL JOIN klienci k WHERE k.nazwa SIMILAR TO '%(Antoni)%';
    2. SELECT z.datarealizacji, z.idzamowienia, z.idklienta, k.ulica FROM public.zamowienia z NATURAL JOIN klienci k WHERE k.ulica SIMILAR TO '%(/)%';
    3. SELECT z.datarealizacji, z.idzamowienia, z.idklienta, k.ulica, k.miejscowosc FROM public.zamowienia z JOIN klienci k ON z.idklienta = k.idklienta WHERE k.miejscowosc SIMILAR TO '%(Kraków)%' AND date_part('month', z.datarealizacji) = 11 AND date_part('year', z.datarealizacji)=2013;

Zadanie 4.3
    1. SELECT CURRENT_DATE-interval '5 year' AS date, k.nazwa, k.miejscowosc, k.ulica, z.datarealizacji FROM public.klienci k JOIN zamowienia z ON k.idklienta=z.idklienta WHERE CURRENT_DATE-interval '5year'<z.datarealizacji;
    2. SELECT k.nazwa, k.idklienta, k.ulica, p.nazwa AS nazwapudelka FROM public.klienci k JOIN zamowienia z ON k.idklienta=z.idklienta JOIN artykuly a ON z.idzamowienia=a.idzamowienia JOIN pudelka p ON a.idpudelka = p.idpudelka WHERE p.nazwa IN('Kolekcja jesienna', 'Kremowa fantazja');
    3. SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc FROM public.klienci k JOIN zamowienia z USING(idklienta);
    4. SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc FROM public.klienci k LEFT JOIN zamowienia z USING(idklienta) WHERE z.idzamowienia IS NULL;
    5. SELECT * FROM public.klienci k NATURAL JOIN zamowienia z WHERE date_part('month', z.datarealizacji)=11 AND date_part('year', z.datarealizacji)=2013;
    6. SELECT k.nazwa as klna FROM klienci k JOIN zamowienia z ON z.idklienta=k.idklienta JOIN artykuly a ON a.idzamowienia=z.idzamowienia JOIN pudelka p ON a.idpudelka=p.idpudelka JOIN zawartosc zz ON p.idpudelka=zz.idpudelka JOIN czekoladki c ON c.idczekoladki=zz.idczekoladki WHERE (p.nazwa='Kremowa fantazja' OR p.nazwa='Kolekcja jesienna') AND a.sztuk>=2 GROUP BY klna ORDER BY klna;
    7. SELECT k.nazwa, k.idklienta, k.ulica, p.nazwa AS nazwapudelka, c.orzechy, c.idczekoladki FROM public.klienci k JOIN zamowienia z ON k.idklienta=z.idklienta JOIN artykuly a ON z.idzamowienia=a.idzamowienia JOIN pudelka p ON a.idpudelka = p.idpudelka JOIN zawartosc za ON p.idpudelka=za.idpudelka JOIN czekoladki c ON c.idczekoladki = za.idczekoladki WHERE c.orzechy='migdały';
Zadanie 4.4
    1. SELECT p.idpudelka, p.nazwa, p.opis, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki ORDER BY idpudelka;
    2. SELECT p.idpudelka, p.nazwa, p.opis, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE p.idpudelka='heav';
    3. SELECT p.idpudelka, p.nazwa, p.opis, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE p.nazwa SIMILAR TO '%(Kolekcja)%';
Zadanie 4.5
    1.  SELECT p.idpudelka, p.nazwa, p.opis, p.cena, c.idczekoladki, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.idczekoladki ='d09';
    2.  SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.nazwa Like 'S%';
 ?  3. SELECT p.idpudelka, p.nazwa, p.opis, c.idczekoladki, z.sztuk, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE z.sztuk>=4;
    4. SELECT p.idpudelka, p.nazwa, p.opis, p.cena, c.nadzienie, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.nadzienie='truskawki';
 ?  5. SELECT p.idpudelka, p.nazwa, p.opis, c.idczekoladki, z.sztuk, c.nazwa AS nazwaczekoladki, c.czekolada AS czekolada  FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki EXCEPT SELECT p.idpudelka, p.nazwa, p.opis, c.idczekoladki, z.sztuk, c.nazwa AS nazwaczekoladki, c.czekolada AS czekolada FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.czekolada='gorzka' ORDER BY czekolada; 
    6. SELECT p.idpudelka, p.nazwa, p.opis, p.cena, z.sztuk, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.nazwa ='Gorzka truskawkowa' AND z.sztuk>=3;
    7. SELECT p.idpudelka, p.nazwa, p.opis, p.cena, c.orzechy, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.orzechy IS NULL;
    8. SELECT p.idpudelka, p.nazwa, p.opis, p.cena, c.nadzienie, c.nazwa AS nazwaczekoladki, c.opis AS opisczekoladki FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.nazwa ='Gorzka truskawkowa';
    9. SELECT DISTINCT p.idpudelka, p.nazwa, p.opis, p.cena FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki c ON z.idczekoladki=c.idczekoladki WHERE c.nadzienie IS NULL;
Zadanie 4.6
    1. SELECT idczekoladki, nazwa FROM public.czekoladki WHERE koszt > (SELECT koszt FROM czekoladki WHERE idczekoladki='d08');
    2. SELECT kk.nazwa FROM public.klienci kk JOIN zamowienia zz ON kk.idklienta = zz.idklienta JOIN artykuly aa ON zz.idzamowienia=aa.idzamowienia JOIN (SELECT a.idpudelka FROM klienci k JOIN zamowienia z ON k.idklienta=z.idklienta JOIN artykuly a ON z.idzamowienia=a.idzamowienia WHERE k.nazwa='Górka Alicja') gorka ON aa.idpudelka = gorka.idpudelka WHERE kk.nazwa<>'Górka Alicja' GROUP BY kk.nazwa;
    3. WITH kat AS (
        SELECT a.idpudelka
        FROM
            klienci k
            INNER JOIN zamowienia z ON k.idklienta = z.idklienta
            INNER JOIN artykuly a ON z.idzamowienia = a.idzamowienia
        WHERE k.miejscowosc = 'Katowice'
)
SELECT kk.nazwa
FROM
    klienci kk
    INNER JOIN zamowienia zz ON kk.idklienta = zz.idklienta
    INNER JOIN artykuly aa ON zz.idzamowienia = aa.idzamowienia
    INNER JOIN kat ON aa.idpudelka = kat.idpudelka
WHERE kk.miejscowosc <> 'Katowice' GROUP BY kk.nazwa;