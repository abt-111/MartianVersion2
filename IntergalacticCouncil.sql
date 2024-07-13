-- Création de la base de données
CREATE DATABASE IntergalacticCouncil;
GO

USE IntergalacticCouncil;
GO

-- Création des tables

-- Table des continents terriens
CREATE TABLE Earth_continent (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL
);

-- Table des bases martiennes
CREATE TABLE Martian_Base (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL
);

-- Table des terriens
CREATE TABLE Earthling (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    earth_continent_id INT NOT NULL,
    CONSTRAINT fk_earth_continent FOREIGN KEY (earth_continent_id) REFERENCES Earth_continent(id)
);

-- Table des martiens
CREATE TABLE Martian (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50) NOT NULL,
    martian_base_id INT NOT NULL,
    earthling_id INT NULL,
    superior_id INT NOT NULL,
    CONSTRAINT fk_martian_base FOREIGN KEY (martian_base_id) REFERENCES Martian_Base(id),
    CONSTRAINT fk_earthling FOREIGN KEY (earthling_id) REFERENCES Earthling(id),
    CONSTRAINT fk_superior FOREIGN KEY (superior_id) REFERENCES Martian(id)
);

-- Insertion des données de test

-- Continent terrien
INSERT INTO Earth_continent (name) VALUES ('Afrique'), ('Europe'), ('Asie');

-- Terriens
INSERT INTO Earthling (name, earth_continent_id) VALUES ('Pascal', 1), ('Rachel', 2), ('Jean-Baptiste', 3);

-- Bases martiennes
INSERT INTO Martian_Base (name) VALUES ('Base Alpha'), ('Base Beta'), ('Base Gamma');

-- Martiens
-- Notez que nous devons insérer l'empereur des martiens en premier car il est son propre supérieur
INSERT INTO Martian (name, earthling_id, martian_base_id, superior_id) VALUES 
('Martien1', 1, 1, 1); -- L'empereur des martiens

-- Les autres martiens
INSERT INTO Martian (name, earthling_id, martian_base_id, superior_id) VALUES 
('Martien2', 2, 2, 1),
('Martien3', 3, 3, 1),
('Martien4', 1, 2, 2),
('Martien5', 2, 3, 2),
('Martien6', 3, 1, 3);

-- Affichage de l'affiliation de chaque martien à son terrien de référence.
SELECT 
    m.name AS martian_name, 
    e.name AS earthling_of_reference, 
    c.name AS continent_of_earthling, 
    b.name AS base_of_martian
FROM 
    Martian AS m
JOIN 
    Earthling AS e ON m.earthling_id = e.id
JOIN 
    Earth_continent AS c ON e.earth_continent_id = c.id
JOIN 
    Martian_Base AS b ON m.martian_base_id = b.id;
