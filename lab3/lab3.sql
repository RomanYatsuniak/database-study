Zadanie 3.1
    1. SELECT idzamowienia, datarealizacji FROM public.zamowienia WHERE datarealizacji BETWEEN '2013-11-12' AND '2013-11-20';
    2. SELECT idzamowienia, datarealizacji FROM public.zamowienia WHERE (datarealizacji BETWEEN '2013-12-01' AND '2013-12-6') OR (datarealizacji BETWEEN '2013-12-15' AND '2013-12-20');
    3. SELECT idzamowienia, datarealizacji FROM public.zamowienia WHERE datarealizacji::text LIKE '2013-12%';
    4. SELECT idzamowienia, datarealizacji FROM public.zamowienia where extract(month from datarealizacji)=11 AND extract(year from datarealizacji)=2013;
       SELECT idzamowienia, datarealizacji FROM public.zamowienia where date_part('month', datarealizacji)=11 AND date_part('year', datarealizacji)=2013;
    5. SELECT idzamowienia, datarealizacji FROM public.zamowienia where date_part('month', datarealizacji) IN (11,12) AND date_part('year', datarealizacji)=2013;
    6. SELECT idzamowienia, datarealizacji FROM public.zamowienia WHERE date_part('day', datarealizacji) IN (17,18,19);
    7. SELECT idzamowienia, datarealizacji FROM public.zamowienia WHERE date_part('week', datarealizacji) IN (46,47);

Zadanie 3.2
    1. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE 'S%';
    2. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE 'S% %i';
    3. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE 'S% m%';
    4. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa SIMILAR TO '[ABC]%';
    5. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa ilike 'orzech%' OR nazwa ilike '%orzech%';
    6. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE 'S%' AND nazwa LIKE '%m%';
    7. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE '%truskawki%' OR nazwa LIKE '%maliny%' ;
    8. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa NOT SIMILAR TO '([D-K]|S|T)%' Order by nazwa;
    9. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa LIKE 'Slod%' OR nazwa LIKE 'Słod%';
    10. SELECT idCzekoladki, nazwa, czekolada, orzechy, nadzienie FROM public.czekoladki WHERE nazwa NOT LIKE  '_% %_';

Zadanie 3.3
    1. SELECT miejscowosc FROM public.klienci WHERE miejscowosc LIKE '_% %_';
    2. SELECT *FROM public.klienci WHERE LENGTH(telefon)!=11;
    3. SELECT *FROM public.klienci WHERE LENGTH(telefon)=11;

Zadanie 3.4
    1. SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24 UNION 
       SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24;   
    2. SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35 EXCEPT 
       SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35;
    3. (SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24 
       INTERSECT 
       SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24) 
       UNION
       (SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35 
       EXCEPT 
       SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.25 AND 0.35);
    4. (SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 15 AND 24 
       INTERSECT 
       SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24);
    5. SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE masa BETWEEN 25 AND 35 
       EXCEPT 
       (SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.15 AND 0.24
       UNION
       SELECT idCzekoladki, nazwa, masa, koszt FROM public.czekoladki WHERE koszt BETWEEN 0.29 AND 0.35);

Zadanie 3.5
    1. SELECT idklienta FROM public.klienci EXCEPT SELECT idklienta FROM public.zamowienia;
    2. SELECT idpudelka FROM public.pudelka EXCEPT SELECT idpudelka FROM public.artykuly;
    3. SELECT nazwa FROM public.pudelka where nazwa similar to '%(rz|Rz)%' UNION
       SELECT nazwa FROM public.klienci where nazwa similar to '%(rz|Rz)%' UNION
       SELECT nazwa FROM public.czekoladki where nazwa similar to '%(rz|Rz)%';
    4. SELECT idczekoladki FROM public.czekoladki EXCEPT
       SELECT idczekoladki FROM public.zawartosc;

Zadanie 3.6
    1. SELECT idmeczu, 
    (case when (gospodarze[1] > goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] > goscie[5]) then 1 else 0 end)
    as "wygrane gospodarze", 
    (case when (gospodarze[1] < goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] < goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] < goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] < goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] < goscie[5]) then 1 else 0 end)
    as "wygrane goscie"
    FROM siatkowka.statystyki;
    2. SELECT idmeczu,
    (case when (gospodarze[1] > goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] > goscie[5]) then 1 else 0 end)
    as "wygrane gospodarze", 
    (case when (gospodarze[1] < goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] < goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] < goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] < goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] < goscie[5]) then 1 else 0 end)
    as "wygrane goscie"
    FROM siatkowka.statystyki WHERE gospodarze[5] is not null AND gospodarze[5]>15 OR goscie[5]>15;
    3. SELECT idmeczu, 
    (case when (gospodarze[1] > goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] > goscie[5]) then 1 else 0 end)
    || ':' ||
    (case when (gospodarze[1] < goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] < goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] < goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] < goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] < goscie[5]) then 1 else 0 end)
    as "wynik"
    FROM siatkowka.statystyki;
      
    SELECT
    idmeczu,
    CONCAT (
        CASE WHEN gospodarze[1] > goscie[1] THEN 1 ELSE 0 END
        + CASE WHEN gospodarze[2] > goscie[2] THEN 1 ELSE 0 END
        + CASE WHEN gospodarze[3] > goscie[3] THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(gospodarze[4], 0) > COALESCE(goscie[4], 0) THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(gospodarze[5], 0) > COALESCE(goscie[5], 0) THEN 1 ELSE 0 END
    , ':',
        CASE WHEN goscie[1] > gospodarze[1] THEN 1 ELSE 0 END
        + CASE WHEN goscie[2] > gospodarze[2] THEN 1 ELSE 0 END
        + CASE WHEN goscie[3] > gospodarze[3] THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(goscie[4], 0) > COALESCE(gospodarze[4], 0) THEN 1 ELSE 0 END
        + CASE WHEN COALESCE(goscie[5], 0) > COALESCE(gospodarze[5], 0) THEN 1 ELSE 0 END
    ) AS wynik
FROM siatkowka.statystyki

    4. SELECT *, 
    (case when (gospodarze[1] > goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] > goscie[5]) then 1 else 0 end)
    as "wygrane gospodarze", 
    (case when (gospodarze[1] < goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] < goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] < goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] < goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] < goscie[5]) then 1 else 0 end)
    as "wygrane goscie" FROM siatkowka.statystyki WHERE
    (case when (gospodarze[1] IS NOT NULL) then gospodarze[1] else 0 end +
    case when (gospodarze[2] IS NOT NULL) then gospodarze[2] else 0 end +
    case when (gospodarze[3] IS NOT NULL) then gospodarze[3] else 0 end +
    case when (gospodarze[4] IS NOT NULL) then gospodarze[4] else 0 end +
    case when (gospodarze[5] IS NOT NULL) then gospodarze[5] else 0 end)::int > 100;
    
    
    5. Не робить з логаритм 0 
    SELECT idmeczu, gospodarze[1], sqrt(goscie[1]),
   (case when (gospodarze[1] > goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] > goscie[5]) then 1 else 0 end) AS Suma
    FROM siatkowka.statystyki WHERE sqrt(goscie[1]) < log(2,(
    case when (gospodarze[1] > goscie[1]) then 1 else 0 end +
    case when (gospodarze[2] > goscie[2]) then 1 else 0 end +
    case when (gospodarze[3] > goscie[3]) then 1 else 0 end +
    case when (gospodarze[4] > goscie[4]) then 1 else 0 end +
    case when (gospodarze[5] > goscie[5]) then 1 else 0 end));





