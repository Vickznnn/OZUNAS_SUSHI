package com.ozunas.dao;

import com.ozunas.config.DatabaseConnection;
import com.ozunas.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public User login(String email, String senha) throws SQLException {
        String sql = "SELECT id, nome, email, perfil FROM usuarios WHERE LOWER(email) = LOWER(?) AND senha = ?";

        try (Connection connection = DatabaseConnection.getConnection()) {
            garantirTabelaUsuarios(connection);
            garantirUsuariosDeTeste(connection);

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email.trim());
                statement.setString(2, senha.trim());

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        return new User(
                                resultSet.getInt("id"),
                                resultSet.getString("nome"),
                                resultSet.getString("email"),
                                resultSet.getString("perfil")
                        );
                    }
                }
            }
        }

        return null;
    }

    private void garantirTabelaUsuarios(Connection connection) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS usuarios (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "nome VARCHAR(120) NOT NULL, " +
                "email VARCHAR(160) NOT NULL UNIQUE, " +
                "senha VARCHAR(120) NOT NULL, " +
                "perfil ENUM('USUARIO', 'ADMIN') NOT NULL DEFAULT 'USUARIO', " +
                "criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ")";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.executeUpdate();
        }
    }

    private void garantirUsuariosDeTeste(Connection connection) throws SQLException {
        String sql = "INSERT INTO usuarios (nome, email, senha, perfil) VALUES " +
                "('Administrador Ozunas', 'admin@ozunas.com', 'admin123', 'ADMIN'), " +
                "('Cliente Teste', 'cliente@ozunas.com', 'cliente123', 'USUARIO') " +
                "ON DUPLICATE KEY UPDATE nome = VALUES(nome), senha = VALUES(senha), perfil = VALUES(perfil)";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.executeUpdate();
        }
    }
}
