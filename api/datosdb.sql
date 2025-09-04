USE geek;

INSERT INTO Usuario (username, email, password) VALUES
('pepe', 'pepe@mail.com', '1234'),
('lisa', 'lisa@mail.com', 'abcd'),
('pedro', 'pedro@mail.com', 'qwerty'),
('sarah', 'sarah@mail.com', 'pass123');

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

INSERT INTO logic_questions (prompt, option1, option2, option3, option4, correctIndex)
VALUES
    ("Si 'p ∧ q' es verdadero, ¿qué se puede concluir?",
     "p y q son verdaderos",
     "p es falso y q es verdadero",
     "p es verdadero y q es falso",
     "p y q son falsos",
     0),

    ("¿Cuál es la negación de 'p ∧ q' según las leyes de De Morgan?",
     "¬p ∨ ¬q",
     "¬p ∧ ¬q",
     "p ∨ q",
     "p → q",
     0),

    ("La proposición 'p ↔ q' es verdadera si y solo si:",
     "p y q tienen el mismo valor de verdad",
     "p es verdadero y q falso",
     "p es falso y q verdadero",
     "al menos uno es verdadero",
     0),

    ("¿Cuál es la forma normal disyuntiva de 'p ∧ (q ∨ r)'?",
     "(p ∧ q) ∨ (p ∧ r)",
     "p ∨ (q ∧ r)",
     "(p ∨ q) ∧ (p ∨ r)",
     "¬p ∨ q ∨ r",
     0),

    ("Si 'p → q' es falso, entonces:",
     "p es verdadero y q es falso",
     "p es falso y q es verdadero",
     "p y q son verdaderos",
     "p y q son falsos",
     0),

    ("¿Qué representa '¬(p → q)'?",
     "p ∧ ¬q",
     "¬p ∨ q",
     "p ∨ q",
     "¬p ∧ q",
     0),

    ("La proposición 'p ∨ q' es falsa únicamente cuando:",
     "p y q son falsos",
     "p es falso y q verdadero",
     "p verdadero y q falso",
     "al menos uno verdadero",
     0),

    ("Si 'p ∧ (q ∨ r)' es falso, ¿qué podemos concluir?",
     "p es falso o (q ∨ r) es falso",
     "p es verdadero y (q ∨ r) es verdadero",
     "p es falso y (q ∨ r) es verdadero",
     "no se puede concluir nada",
     0),

    ("El contrarrecíproco de 'p → q' es:",
     "¬q → ¬p",
     "¬p → ¬q",
     "q → p",
     "p ↔ q",
     0),

    ("¿Cuál es la tabla de verdad de 'p ∨ ¬p'?",
     "Siempre verdadero",
     "Siempre falso",
     "Verdadero solo si p es verdadero",
     "Verdadero solo si p es falso",
     0),

    ("La proposición '¬(p ∧ q)' es equivalente a:",
     "¬p ∨ ¬q",
     "¬p ∧ ¬q",
     "p ∨ q",
     "¬p → q",
     0);

INSERT INTO teoria_questions (prompt, option1, option2, option3, option4, correctIndex)
VALUES

    ("En lógica, una tautología es:",
     "Una proposición siempre verdadera",
     "Una proposición siempre falsa",
     "Una proposición a veces verdadera",
     "Una contradicción",
     0),

    ("¿Cuál es la tabla de verdad de 'p ∨ ¬p'?",
     "Siempre verdadero",
     "Siempre falso",
     "Verdadero solo si p es verdadero",
     "Verdadero solo si p es falso",
     0),


    ("¿Qué significa que dos proposiciones sean lógicamente equivalentes?",
     "Tienen la misma tabla de verdad",
     "Se contradicen mutuamente",
     "Una es verdadera y la otra falsa",
     "Se cumplen solo a veces",
     0),

    ("Si 'p → q' y 'q → r' son verdaderos, entonces 'p → r' es:",
     "Verdadero (silogismo hipotético)",
     "Falso",
     "No necesariamente verdadero",
     "Indeterminado",
     0),

    ("¿Qué es una contradicción en lógica?",
     "Una proposición siempre falsa",
     "Una proposición siempre verdadera",
     "Una proposición a veces verdadera",
     "Una proposición contingente",
     0),

    ("En lógica, una tautología es:",
     "Una proposición siempre verdadera",
     "Una proposición siempre falsa",
     "Una proposición a veces verdadera",
     "Una contradicción",
     0);



