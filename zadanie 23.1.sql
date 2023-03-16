-- 1. Tworzy tabelę pracownik
CREATE TABLE pracownik (
	id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(35) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    wypłata DECIMAL(10, 2),
    data_urodzenia DATE,
    stanowisko VARCHAR(30)
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO pracownik
	(imie, nazwisko, wypłata, data_urodzenia, stanowisko)
VALUES
	('Jan', 'Kowalski', 4800, '1986-04-23', 'Inżynier'),
	('Asia', 'Zawadzka', 4800, '1985-07-11', 'Inżynier'),
	('Marcin', 'Poloński', 7200, '1981-07-16', 'Starszy inżynier'),
	('Krzysztof', 'Pieroński', 7200, '1980-06-03', 'Starszy inżynier'),
	('Natalia', 'Szewc', 11540, '1970-03-05', 'Menedżer'),
	('Kamila', 'Słojowska', 4800, '1984-01-29', 'Inżynier');
    
-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku
SELECT * FROM pracownik ORDER BY nazwisko;

-- 4. Pobiera pracowników na wybranym stanowisku
SELECT * FROM pracownik WHERE stanowisko = 'Inżynier';

-- 5. Pobiera pracowników, którzy mają co najmniej 30 lat
SELECT * FROM pracownik WHERE YEAR(data_urodzenia) <= 1993;

-- 6. Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE pracownik SET wypłata = wypłata + (wypłata * 10/100);

-- 7. Pobiera najmłodszego pracowników
SELECT * FROM pracownik WHERE data_urodzenia = (SELECT MAX(data_urodzenia) FROM pracownik);

-- 8. Usuwa tabelę pracownik
DROP TABLE pracownik;

-- 9. Tworzy tabelę stanowisko
CREATE TABLE stanowisko (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nazwa_stanowiska VARCHAR(35) NOT NULL,
    opis VARCHAR(200),
    wypłata DECIMAL(10, 2) NOT NULL
);


-- 10. Tworzy tabelę adres
CREATE TABLE adres (
	id INT PRIMARY KEY AUTO_INCREMENT,
    ulica VARCHAR(40) NOT NULL,
    numer_domu VARCHAR(10) NOT NULL,
    kod_pocztowy VARCHAR(6) NOT NULL,
    miejscowość VARCHAR(50) NOT NULL
);

-- 11. Tworzy tabelę pracownik
CREATE TABLE pracownik (
	id INT PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(35) NOT NULL,
    nazwisko VARCHAR(45) NOT NULL,
    adres_id INT NOT NULL,
    stanowisko_id INT NOT NULL,
    FOREIGN KEY (adres_id) REFERENCES adres (id),
    FOREIGN KEY (stanowisko_id) REFERENCES stanowisko (id)
);

-- 12. Dodaje dane testowe
INSERT INTO stanowisko
	(nazwa_stanowiska, opis, wypłata)
VALUES
	('Inżynier', 'stosuje metody naukowe do rozwiązywania i analizowania problemów technicznych', 4800),
    ('Starszy inżynier', 'bierze na warsztat kompetencje pozatechniczne, dogłębnie się im przyglądając', 7200),
    ('Menedżer', 'realizacja procesu zarządzania – planowanie i podejmowanie decyzji, organizowanie, przewodzenie', 11540); 

INSERT INTO adres
	(ulica, numer_domu, kod_pocztowy, miejscowość)
VALUES
	('Dworcowa', '60', '90-210', 'Łódź'),
    ('Grzybowa', '50/8', '90-220', 'Łódź'),
    ('Dębowa', '17B', '90-210', 'Łódź'),
    ('Kostkowa', '107B/2', '90-333', 'Łódź'),
    ('Koczarowa', '112/6', '90-270', 'Łódź'),
    ('Holteja', '4A', '90-270', 'Łódź');

INSERT INTO pracownik
	(imie, nazwisko, adres_id, stanowisko_id)
VALUES
	('Jan', 'Kowalski', 1, 1),
	('Asia', 'Zawadzka', 4, 1),
	('Marcin', 'Poloński', 5, 2),
	('Krzysztof', 'Pieroński', 2, 2),
	('Natalia', 'Szewc', 6, 3),
	('Kamila', 'Słojowska', 3, 1);

SELECT * FROM pracownik;

-- 13. Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT * FROM pracownik
INNER JOIN adres ON pracownik.id = adres.id
INNER JOIN stanowisko ON pracownik.id = stanowisko.id;

-- 14. Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(wypłata) AS 'Suma wypłat:' FROM stanowisko;

-- 15. Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym 90210
SELECT * FROM pracownik
INNER JOIN adres ON pracownik.id = adres.id
WHERE kod_pocztowy = '90-210';

