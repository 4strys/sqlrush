-- Créer la base de données 'beluga_rh'
CREATE DATABASE IF NOT EXISTS beluga_rh;

-- Utiliser la base de données 'beluga_rh'
USE beluga_rh;

-- Créer la table 'employe'
CREATE TABLE IF NOT EXISTS employe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    address VARCHAR(255),
    postal_code VARCHAR(10),
    service_id INT,
    days_off INT,
    department_id INT,
    FOREIGN KEY (service_id) REFERENCES service(id)
);

-- Créer la table 'day_off'
CREATE TABLE IF NOT EXISTS day_off (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    date_start DATE,
    date_end DATE,
    duration INT,
    FOREIGN KEY (employee_id) REFERENCES employe(id)
);

-- Créer la table 'service'
CREATE TABLE IF NOT EXISTS service (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Créer la table 'restaurant_tickets'
CREATE TABLE IF NOT EXISTS restaurant_tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_tickets VARCHAR(255),
    amount DECIMAL(10, 2),
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employe(id)
);

-- Créer la table 'job_titles'
CREATE TABLE IF NOT EXISTS job_titles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255)
);

-- Créer la table 'departments'
CREATE TABLE IF NOT EXISTS departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Ajouter la colonne 'department_id' à la table 'employe' pour lier les employés aux départements
ALTER TABLE employe ADD COLUMN department_id INT;
UPDATE employe SET department_id = 1; -- Attribuez un ID de département par défaut si nécessaire


-- Créer la table 'job_assignments' pour lier les employés aux titres de poste et aux départements
CREATE TABLE IF NOT EXISTS job_assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    job_title_id INT,
    department_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employe(id),
    FOREIGN KEY (job_title_id) REFERENCES job_titles(id),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- On ajoute une clé étrangère 
ALTER TABLE employe 
ADD FOREIGN KEY (days_off) REFERENCES day_off(date_end);

-- On crée les tables nécessaires 

CREATE TABLE IF NOT EXISTS entity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT
);

CREATE TABLE IF NOT EXISTS items(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    dmg INT
);

CREATE TABLE IF NOT EXISTS users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    items_id INT,
    FOREIGN KEY(items_id) REFERENCES items(id)
);

CREATE TABLE IF NOT EXISTS gamesession(
    id INT AUTO_INCREMENT PRIMARY KEY,
    players_id INT,
    entity_id INT,
    FOREIGN KEY(players_id) REFERENCES users(id),
    FOREIGN KEY(entity_id) REFERENCES entity(id)
);

CREATE TABLE IF NOT EXISTS patch(
    id INT AUTO_INCREMENT PRIMARY KEY,
    day_off_id INT,
    FOREIGN KEY(day_off_id) REFERENCES day_off(id)
);
