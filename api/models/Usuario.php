<?php
class Usuario {
    private $conn;
    private $table = "Usuario";

    public $id_usuario;
    public $username;
    public $email;
    public $password_hash;
    public $fecha_registro;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Obtener todos
    public function getAll() {
        $query = "SELECT id_usuario, username, email, fecha_registro FROM " . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Crear
    public function create() {
        $query = "INSERT INTO " . $this->table . " (username, email, password_hash) 
                  VALUES (:username, :email, :password_hash)";
        $stmt = $this->conn->prepare($query);

        $this->username = htmlspecialchars(strip_tags($this->username));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->password_hash = password_hash($this->password_hash, PASSWORD_BCRYPT);

        $stmt->bindParam(":username", $this->username);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":password_hash", $this->password_hash);

        return $stmt->execute();
    }

    // Obtener uno
    public function getById($id) {
        $query = "SELECT id_usuario, username, email, fecha_registro FROM " . $this->table . " WHERE id_usuario = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        $stmt->execute();
        return $stmt;
    }

    // Actualizar
    public function update($id) {
        $query = "UPDATE " . $this->table . " SET username = :username, email = :email WHERE id_usuario = :id";
        $stmt = $this->conn->prepare($query);

        $this->username = htmlspecialchars(strip_tags($this->username));
        $this->email = htmlspecialchars(strip_tags($this->email));

        $stmt->bindParam(":username", $this->username);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":id", $id);

        return $stmt->execute();
    }

    // Eliminar
    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id_usuario = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        return $stmt->execute();
    }
}

