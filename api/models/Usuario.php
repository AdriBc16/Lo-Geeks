<?php
class Usuario {
    private $conn;
    private $table = "Usuario";

    public $id_usuario;
    public $username;
    public $email;
    public $password;
    public $fecha_registro;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function getAll() {
        $query = "SELECT id_usuario, username, email, fecha_registro FROM " . $this->table;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function create() {
    $query = "INSERT INTO " . $this->table . " (username, email, password) 
              VALUES (:username, :email, :password)";
    $stmt = $this->conn->prepare($query);

    $this->username = htmlspecialchars(strip_tags($this->username));
    $this->email = htmlspecialchars(strip_tags($this->email));
    
    // Hash de la contraseña
    $hashedPassword = password_hash($this->password, PASSWORD_DEFAULT);

    $stmt->bindParam(":username", $this->username);
    $stmt->bindParam(":email", $this->email);
    $stmt->bindParam(":password", $hashedPassword);

    return $stmt->execute();
    }

    public function getById($id) {
        $query = "SELECT id_usuario, username, email, fecha_registro FROM " . $this->table . " WHERE id_usuario = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        $stmt->execute();
        return $stmt;
    }


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


    public function delete($id) {
        $query = "DELETE FROM " . $this->table . " WHERE id_usuario = :id";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":id", $id);
        return $stmt->execute();
    }


    public function findByUsername($username) {
        $query = "SELECT id_usuario, username, email, password FROM " . $this->table . " WHERE username = :username LIMIT 0,1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":username", $username);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function userExists($username, $email) {
        $query = "SELECT id_usuario FROM " . $this->table . " WHERE username = :username OR email = :email LIMIT 1";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":username", $username);
        $stmt->bindParam(":email", $email);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            return true;
        }
        return false;
    }
}
