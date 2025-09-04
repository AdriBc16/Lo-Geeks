CREATE DATABASE geek;
USE geek;
CREATE TABLE Usuario (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) NOT NULL UNIQUE,
email VARCHAR(100) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL,
fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ArchivoBiblioteca (
id_archivo INT AUTO_INCREMENT PRIMARY KEY,
nombre_archivo VARCHAR(100) NOT NULL,
fecha_subida DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Juego (
id_juego INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
descripcion TEXT,
estado ENUM('borrador','publicado','archivado') NOT NULL DEFAULT 'borrador'
);

CREATE TABLE Juego_Archivo (
id_juego INT NOT NULL,
id_archivo INT NOT NULL,
PRIMARY KEY (id_juego, id_archivo),
FOREIGN KEY (id_juego) REFERENCES Juego(id_juego),
FOREIGN KEY (id_archivo) REFERENCES ArchivoBiblioteca(id_archivo)
);

CREATE TABLE Partida (
id_partida INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT NOT NULL,
id_juego INT NOT NULL,
fecha_inicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
fecha_fin DATETIME,
estado ENUM('en curso','finalizada') NOT NULL DEFAULT 'en curso',
FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
FOREIGN KEY (id_juego) REFERENCES Juego(id_juego)
);

CREATE TABLE Puntaje (
id_puntaje INT AUTO_INCREMENT PRIMARY KEY,
id_partida INT NOT NULL UNIQUE,
puntaje INT NOT NULL,
tiempo_jugado INT NOT NULL,
FOREIGN KEY (id_partida) REFERENCES Partida(id_partida)
);

-- Tablas
CREATE TABLE logic_questions (
id INT AUTO_INCREMENT PRIMARY KEY,
prompt TEXT NOT NULL,
option1 VARCHAR(255) NOT NULL,
option2 VARCHAR(255) NOT NULL,
option3 VARCHAR(255) NOT NULL,
option4 VARCHAR(255) NOT NULL,
correctIndex TINYINT UNSIGNED NOT NULL,
CONSTRAINT chk_logic_correct_index CHECK (correctIndex BETWEEN 0 AND 3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE teoria_questions (
id INT AUTO_INCREMENT PRIMARY KEY,
prompt TEXT NOT NULL,
option1 VARCHAR(255) NOT NULL,
option2 VARCHAR(255) NOT NULL,
option3 VARCHAR(255) NOT NULL,
option4 VARCHAR(255) NOT NULL,
correctIndex TINYINT UNSIGNED NOT NULL,
CONSTRAINT chk_teoria_correct_index CHECK (correctIndex BETWEEN 0 AND 3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



