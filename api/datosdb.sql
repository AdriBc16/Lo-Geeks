USE geek;

 INSERT INTO Usuario (username, email, password_hash) VALUES
 ('pepe', 'pepe@mail.com', MD5('1234')),
 ('lisa', 'lisa@mail.com', MD5('abcd')),
 ('pedro', 'pedro@mail.com', MD5('qwerty')),
 ('sarah', 'sarah@mail.com', MD5('pass123'));


 INSERT INTO ArchivoBiblioteca (nombre_archivo) VALUES
 ('manual_mario.pdf'),
 ('trailer_zelda.mp4'),
 ('guia_pokemon.docx'),
 ('mapa_final_fantasy.png');


 INSERT INTO Juego (titulo, descripcion, estado) VALUES
 ('Super Mario', 'Juego de plataformas clásico', 'publicado'),
 ('The Legend of Zelda', 'Aventura y acción', 'publicado'),
 ('Pokemon', 'Captura y entrena criaturas', 'borrador'),
 ('Final Fantasy', 'RPG épico', 'archivado');


 INSERT INTO Juego_Archivo (id_juego, id_archivo) VALUES
 (1, 1),
 (2, 2),
 (3, 3),
 (4, 4);


 INSERT INTO Partida (id_usuario, id_juego, fecha_inicio, fecha_fin, estado) VALUES
 (1, 1, NOW(), NOW() + INTERVAL 1 HOUR, 'finalizada'),
 (2, 2, NOW(), NOW() + INTERVAL 2 HOUR, 'finalizada'),
 (3, 3, NOW(), NULL, 'en curso'),
 (4, 4, NOW(), NOW() + INTERVAL 3 HOUR, 'finalizada');


 INSERT INTO Puntaje (id_partida, puntaje, tiempo_jugado) VALUES
 (1, 5000, 60),
 (2, 8000, 120),
 (3, 3000, 30),
 (4, 10000, 180);
