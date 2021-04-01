Zadanie 1. 
    CREATE OR REPLACE FUNCTION kwiaciarnia.fn_poZamowieniu()
RETURNS TRIGGER AS 
$$
DECLARE rabat INTEGER;
DECLARE stanRoznica INTEGER;
BEGIN 
    rabat := kwiaciarnia.rabat(new.idklienta);

    IF rabat > 0 THEN
        new.cena := new.cena - (new.cena * (rabat::decimal / 100::decimal));
    END IF;

    UPDATE kwiaciarnia.kompozycje 
    SET stan = stan - 1
    WHERE idkompozycji = new.idkompozycji;

    SELECT (stan - minimum) INTO staRoznica
    FROM kwiaciarnia.kompozycje
    WHERE idkompozycji = new.idkompozycji;

    IF (stanRoznica < 0) THEN 
        INSERT INTO kwiaciarnia.zapotrzebowanie
        (idkompozycji, data)
        VALUES
        (new.idkompozycji, CURRENT_DATE)
        ON CONFLICT (idkompozycji) DO UPDATE SET data = CURRENT_DATE;
    END IF;
    RETURN new;

END;
$$ LANGUAGE PLpgSQL;
CREATE TRIGGER tr_poZamowieniu
BEFORE INSERT ON kwiaciarnia.zamowienia
FOR EACH ROW 
EXECUTE PROCEDURE kwiaciarnia.fn_poZamowieniu();
