package com.ozunas.dao;

import com.ozunas.config.DatabaseConnection;
import com.ozunas.model.MenuItem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuItemDAO {
    public List<MenuItem> listarAtivos() {
        String sql = "SELECT id, nome, descricao, preco, categoria, imagem_url, destaque FROM cardapio WHERE ativo = TRUE ORDER BY destaque DESC, categoria, nome";
        List<MenuItem> itens = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                itens.add(criarMenuItem(resultSet));
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        return itens;
    }

    public List<MenuItem> listarTodos() {
        String sql = "SELECT id, nome, descricao, preco, categoria, imagem_url, destaque FROM cardapio ORDER BY criado_em DESC";
        List<MenuItem> itens = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                itens.add(criarMenuItem(resultSet));
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        return itens;
    }

    public boolean adicionar(String nome, String descricao, BigDecimal preco, String categoria, String imagemUrl, boolean destaque) {
        String sql = "INSERT INTO cardapio (nome, descricao, preco, categoria, imagem_url, destaque, ativo) VALUES (?, ?, ?, ?, ?, ?, TRUE)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, nome);
            statement.setString(2, descricao);
            statement.setBigDecimal(3, preco);
            statement.setString(4, categoria);
            statement.setString(5, imagemUrl);
            statement.setBoolean(6, destaque);

            return statement.executeUpdate() > 0;
        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        return false;
    }

    private MenuItem criarMenuItem(ResultSet resultSet) throws SQLException {
        return new MenuItem(
                resultSet.getInt("id"),
                resultSet.getString("nome"),
                resultSet.getString("descricao"),
                resultSet.getBigDecimal("preco"),
                resultSet.getString("categoria"),
                resultSet.getString("imagem_url"),
                resultSet.getBoolean("destaque")
        );
    }
}
