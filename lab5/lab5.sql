Zadanie 5.1
    1. SELECT COUNT(*) FROM public.czekoladki;
    2. 
        a) SELECT count(nadzienie) FROM public.czekoladki;
        b) SELECT count(*) FROM public.czekoladki WHERE nadzienie IS NOT NULL;
    3. SELECT p.nazwa, SUM(z.sztuk) FROM public.pudelka p JOIN zawartosc z ON p.idpudelka=z.idpudelka JOIN czekoladki c ON c.idczekoladki = z.idczekoladki GROUP BY p.nazwa ORDER BY sum DESC LIMIT 1;
    4. SELECT SUM(sztuk) FROM public.zawartosc;
    5. SELECT SUM(z.sztuk) FROM public.zawartosc z JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki WHERE cz.orzechy is NULL;
    6. SELECT SUM(sztuk) FROM public.zawartosc z JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki WHERE czekolada ='mleczna';
Zadanie 5.2
    1. SELECT p.nazwa, SUM(c.masa*z.sztuk) AS masa FROM public.pudelka p JOIN zawartosc z ON p.idpudelka=z.idpudelka JOIN czekoladki c ON c.idczekoladki = z.idczekoladki GROUP BY p.nazwa;
    2. SELECT p.nazwa, SUM(c.masa*z.sztuk) AS masa FROM public.pudelka p JOIN zawartosc z ON p.idpudelka=z.idpudelka JOIN czekoladki c ON c.idczekoladki = z.idczekoladki GROUP BY p.nazwa ORDER BY masa DESC LIMIT 1;
    3. WITH av AS(SELECT p.nazwa, SUM(cz.masa*z.sztuk) FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki GROUP BY p.nazwa) SELECT SUM(av.sum)/COUNT(av.sum) FROM av;
    4. SELECT p.idpudelka, SUM(z.sztuk*cz.masa)/SUM(z.sztuk) FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki GROUP BY p.idpudelka;
Zadanie 5.3 
    1. SELECT datarealizacji, COUNT(idzamowienia) FROM public.zamowienia GROUP BY datarealizacji ORDER BY datarealizacji;
    2. SELECT SUM(a.count) FROM (SELECT datarealizacji, COUNT(idzamowienia) FROM public.zamowienia GROUP BY datarealizacji ORDER BY datarealizacji) AS a;
    3. WITH su AS(SELECT a.idzamowienia, SUM(a.sztuk*p.cena) AS sum FROM public.artykuly a JOIN pudelka p ON p.idpudelka=a.idpudelka GROUP BY a.idzamowienia) SELECT SUM(su.sum) FROM su;
    4. WITH kat as (SELECT a.idzamowienia, SUM(a.sztuk*p.cena) as cena FROM public.artykuly a JOIN pudelka p ON p.idpudelka=a.idpudelka GROUP BY a.idzamowienia) SELECT k.nazwa, k.idklienta, SUM(kat.cena), COUNT(z.idzamowienia) FROM klienci k JOIN zamowienia z ON k.idklienta=z.idklienta JOIN kat ON kat.idzamowienia=z.idzamowienia GROUP BY k.nazwa, k.idklienta;
Zadanie 5.4
   з ліміт, а не min max 1. SELECT z.idczekoladki, SUM(sztuk) FROM public.zawartosc z GROUP BY z.idczekoladki ORDER BY sum DESC LIMIT 1;
    2. SELECT p.nazwa, SUM(z.sztuk) FROM pudelka p JOIN zawartosc z ON p.idpudelka=z.idpudelka JOIN czekoladki c ON c.idczekoladki=z.idczekoladki WHERE c.orzechy IS NULL GROUP BY p.nazwa ORDER BY sum DESC LIMIT 4;
   з ліміт, а не min max 3. SELECT z.idczekoladki, SUM(sztuk) FROM public.zawartosc z GROUP BY z.idczekoladki ORDER BY sum LIMIT 6;
    4. SELECT p.idpudelka, p.nazwa, SUM(a.sztuk) FROM public.pudelka p JOIN artykuly a ON a.idpudelka=p.idpudelka GROUP BY p.idpudelka, p.nazwa ORDER BY sum DESC LIMIT 1;
Zadanie 5.5
    1. With newTable as (SELECT COUNT(idzamowienia) as count, z.datarealizacji FROM public.zamowienia z GROUP BY z.datarealizacji ORDER BY z.datarealizacji ASC) SELECT SUM(count), date_trunc('quarter', datarealizacji) FROM newTable GROUP BY date_trunc('quarter', datarealizacji) ORDER BY date_trunc;
    2. With newTable as (SELECT COUNT(idzamowienia) as count, z.datarealizacji FROM public.zamowienia z GROUP BY z.datarealizacji ORDER BY z.datarealizacji ASC) SELECT SUM(count), date_trunc('month', datarealizacji) FROM newTable GROUP BY date_trunc('month', datarealizacji) ORDER BY date_trunc;
    3. With newTable as (SELECT COUNT(idzamowienia) as count, z.datarealizacji FROM public.zamowienia z GROUP BY z.datarealizacji ORDER BY z.datarealizacji ASC) SELECT SUM(count), date_trunc('week', datarealizacji) FROM newTable GROUP BY date_trunc('week', datarealizacji) ORDER BY date_trunc;
    4. SELECT k.miejscowosc, COUNT(z.idzamowienia)FROM public.klienci k JOIN zamowienia z ON z.idklienta=k.idklienta GROUP BY k.miejscowosc;
Zadanie 5.6
    1. WITH sumPUD as (SELECT p.nazwa,p.idpudelka,p.stan, SUM(z.sztuk*cz.masa) as sum FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki GROUP BY p.nazwa, p.idpudelka,p.stan)SELECT SUM(sumPUD.sum*pi.stan) FROM sumPUD JOIN pudelka pi ON pi.idpudelka=sumPUD.idpudelka;
    2. SELECT SUM(cena*stan) FROM public.pudelka;
Zadanie 5.7
    1. WITH zysk AS(SELECT p.nazwa, p.idpudelka, p.cena, SUM(cz.koszt*z.sztuk) FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki GROUP BY p.nazwa,p.idpudelka, p.cena) SELECT zy.nazwa, zy.idpudelka, zy.cena-zy.sum AS zysk FROM zysk zy;
    2. WITH zysk AS(SELECT p.nazwa, p.idpudelka, p.cena, SUM(cz.koszt*z.sztuk) FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki GROUP BY p.nazwa,p.idpudelka, p.cena), zysk2 AS(SELECT zy.nazwa, zy.idpudelka, SUM((zy.cena-zy.sum)*a.sztuk) AS zysk FROM zysk zy JOIN artykuly a ON a.idpudelka=zy.idpudelka GROUP BY zy.nazwa, zy.idpudelka) SELECT SUM(zysk) FROM zysk2;
    3. WITH zysk AS (SELECT p.nazwa, p.idpudelka, p.cena, SUM(cz.koszt*z.sztuk) FROM public.pudelka p JOIN zawartosc z ON z.idpudelka=p.idpudelka JOIN czekoladki cz ON cz.idczekoladki=z.idczekoladki GROUP BY p.nazwa,p.idpudelka, p.cena), zysk2 AS(SELECT zy.nazwa, zy.idpudelka, (zy.cena-zy.sum)*py.stan AS zysk FROM zysk zy JOIN pudelka py ON py.idpudelka=zy.idpudelka) SELECT SUM(z.zysk) FROM zysk2 z;
Zadanie 5.8
    CREATE SEQUENCE lp START 1;

    SELECT nextval('lp') as lp, p.idpudelka FROM pudelka p ORDER BY p.idpudelka ASC;

    DROP SEQUENCE lp;