Zadanie 6.1
    1. INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, orzechy, nadzienie, opis, koszt, masa) VALUES('W98', 'Biały kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 0.45, 20);
    2. INSERT INTO klienci(idklienta, nazwa, ulica, miejscowosc, kod, telefon) VALUES 
       (90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'), 
       (91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38'),
       (92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');
    3. INSERT INTO klienci SELECT 93, 'Matusiak Iza', ulica, miejscowosc, kod, telefon FROM klienci WHERE nazwa='Matusiak Edward'; 

Zadanie 6.2
    1.  INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, opis, koszt, masa) VALUES
    ('X91', 'Nieznana Nieznajoma', NULL,'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0), 
    ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36);

Zadanie 6.3
    1. DELETE FROM czekoladki WHERE idczekoladki IN('W98', 'M98');
    2. +
    3. INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, opis, koszt, masa) VALUES
       ('X91', 'Nieznana Nieznajoma', NULL,'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0), 
       ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36);

Zadanie 6.4 
    1. UPDATE klienci SET nazwa='Nowak Iza' WHERE nazwa='Matusiak Iza';
    2. UPDATE czekoladki SET koszt=koszt*0.9 WHERE idczekoladki IN ('X91', 'M98');
    3. UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki='M98') WHERE nazwa='Nieznana Nieznajoma';
    4. UPDATE klienci SET miejscowosc='Piotrograd' WHERE miejscowosc='Leningrad';
    5. UPDATE czekoladki SET koszt=koszt+0.15 WHERE substr(idczekoladki, 2,2)::int>90;

Zadanie 6.5
    1. DELETE FROM klienci WHERE nazwa SIMILAR TO 'Matusiak %';
    2. DELETE FROM klienci WHERE idklienta>91;
    3. DELETE FROM czekoladki WHERE koszt>=0.45 OR masa>=36 OR masa=0;

Zadanie 6.6
    INSERT INTO pudelka(idpudelka, nazwa, opis, cena, stan) VALUES ('aaaa', 'Sweet Apple', 'jablki', 21, 100), ('bbbb', 'Sweet Oranges', 'oranges', 20, 120);
    INSERT INTO zawartosc(idpudelka, idczekoladki, sztuk) VALUES('aaaa', 'b02', 2), ('aaaa', 'm05', 2), ('aaaa', 'd06', 2), ('aaaa', 'm15', 2), ('bbbb', 'm08', 2), ('bbbb', 'b05', 2), ('bbbb', 'm10', 2), ('bbbb', 'm13', 2);

Zadanie 6.7 
    +

Zadanie 6.8 
    1. UPDATE zawartosc SET sztuk=sztuk+1 WHERE idpudelka IN ('aaaa', 'bbbb');
    2. UPDATE czekoladki SET orzechy='brak' WHERE orzechy IS NULL;
    3. UPDATE czekoladki SET orzechy=NULL WHERE orzechy='brak';
