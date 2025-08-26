<?php
class JuegoArchivo {
    private $conn;
    private $table = "Juego_Archivo";

    public $id_juego;
    public $id_archivo;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Obtener todos (con JOIN opcional para ver nombres)
    public function getAll() {
        $query = "SELECT ja.id_juego, ja.id_archivo, 
                         j.titulo AS juego, 
                         a.nombre_archivo AS archivo
                  FROM " . $this->table . " ja
                  INNER JOIN Juego j ON ja.id_juego = j.id_juego
                  INNER JOIN ArchivoBiblioteca a ON ja.id_archivo = a.id_archivo";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Obtener por juego
    public function getByJuego($id_juego) {
        $query = "SELECT ja.id_juego, ja.id_archivo, 
                         j.titulo AS juego, 
                         a.nombre_archivo AS archivo
                  FROM " . $this->table . " ja
                  INNER JOIN Juego j ON ja.id_juego = j.id_juego
                  INNER JOIN ArchivoBiblioteca a ON ja.id_archivo = a.id_archivo
                  WHERE ja.id_juego = :id_juego";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id_juego", $id_juego);
        $stmt->execute();
        return $stmt;
    }

    // Crear relación
    public function create() {
        $query = "INSERT INTO " . $this->table . " (id_juego, id_archivo) 
                  VALUES (:id_juego, :id_archivo)";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id_juego", $this->id_juego);
        $stmt->bindParam(":id_archivo", $this->id_archivo);

        return $stmt->execute();
    }

    // Eliminar relación
    public function delete() {
        $query = "DELETE FROM " . $this->table . " 
                  WHERE id_juego = :id_juego AND id_archivo = :id_archivo";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id_juego", $this->id_juego);
        $stmt->bindParam(":id_archivo", $this->id_archivo);

        return $stmt->execute();
    }
}
