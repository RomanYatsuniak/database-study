begin; 

CREATE SCHEMA kwiaciarnia;

CREATE TABLE kwiaciarnia.klienci(
    idklienta varchar(10) PRIMARY KEY,
    haslo varchar(10)  NOT NULL, 
    nazwa varchar(40) NOT NULL , 
    miasto varchar(40) NOT NULL,
    kod char(6) NOT NULL,
    adres varchar(40) NOT NULL,
    email varchar(40), 
    telefon varchar(16) NOT NULL,
    fax varchar(16),
    nip varchar(13),
    regon char(9),
    CONSTRAINT cena_min check((length(haslo)::integer)>=4)
);

CREATE TABLE kwiaciarnia.kompozycje(
    idkompozycji char(5) PRIMARY KEY,
    nazwa varchar(40) NOT NULL,
    opis varchar(100),
    cena numeric(10,2),
    minimum integer,
    stan integer,
    CONSTRAINT cena_min_ko check(cena>=40.00)
);

CREATE TABLE kwiaciarnia.odbiorcy(
    idodbiorcy SERIAL PRIMARY KEY,
    nazwa varchar(40) NOT NULL,
    miasto varchar(40) NOT NULL,
    kod char(6) NOT NULL,
    adres varchar(40) NOT NULL
);

CREATE TABLE kwiaciarnia.zamowienia(
    idzamowienia integer PRIMARY KEY,
    idklienta varchar(10) NOT NULL,
    idodbiorcy integer NOT NULL,
    idkompozycji char(5) NOT NULL,
    termin date NOT NULL,
    cena numeric(7,2),
    zaplacone boolean, 
    uwagi varchar(200),
    CONSTRAINT FK_idklienta FOREIGN KEY(idklienta) references kwiaciarnia.klienci(idklienta),
    CONSTRAINT FK_idodbiorcy FOREIGN KEY(idodbiorcy) references kwiaciarnia.odbiorcy(idodbiorcy),
    CONSTRAINT FK_idkompozycji FOREIGN KEY(idkompozycji) references kwiaciarnia.kompozycje(idkompozycji)
);

CREATE TABLE kwiaciarnia.historia(
    idzamowienia integer PRIMARY KEY,
    idklienta varchar(10),
    idkompozycji char(5),
    cena numeric(7,2),
    termin date
);

CREATE TABLE kwiaciarnia.zapotrzebowanie(
    idkompozycji char(5) PRIMARY KEY,
    data date,
    CONSTRAINT FK_kompozycji FOREIGN KEY(idkompozycji) references kwiaciarnia.kompozycje(idkompozycji)
);


commit;