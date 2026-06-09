package com.ozunas.servlet;

import com.ozunas.config.DatabaseConnection;
import com.ozunas.dao.UserDAO;
import com.ozunas.model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

@WebServlet("/teste-login")
public class TesteLoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='pt-BR'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Teste de Login - Ozunas Sushi</title>");
            out.println("<style>");
            out.println("body{font-family:Arial,sans-serif;background:#fffaf1;color:#1d1c1a;padding:32px;line-height:1.5}");
            out.println(".box{max-width:900px;background:#fff;border:1px solid #e6ded0;border-radius:8px;padding:24px;margin:auto}");
            out.println(".ok{color:#0f6b4b;font-weight:700}.erro{color:#b8222f;font-weight:700}");
            out.println("table{border-collapse:collapse;width:100%;margin-top:12px}th,td{border:1px solid #e6ded0;padding:10px;text-align:left}");
            out.println("code{background:#f4eee3;padding:2px 5px;border-radius:4px}");
            out.println("</style>");
            out.println("</head>");
            out.println("<body><main class='box'>");
            out.println("<h1>Teste de Login - Ozunas Sushi</h1>");
            out.println("<p>Versao do teste: " + LocalDateTime.now() + "</p>");

            testarBanco(out);
            testarCredenciais(out);

            out.println("<p><a href='" + request.getContextPath() + "/login'>Voltar para o login</a></p>");
            out.println("</main></body></html>");
        }
    }

    private void testarBanco(PrintWriter out) {
        out.println("<h2>1. Conexao com MySQL</h2>");

        try (Connection connection = DatabaseConnection.getConnection()) {
            out.println("<p class='ok'>Conexao com MySQL OK.</p>");
            imprimirDadosDaConexao(out, connection);
            imprimirUsuarios(out, connection);
        } catch (SQLException exception) {
            out.println("<p class='erro'>Erro ao conectar ou consultar o MySQL.</p>");
            out.println("<p><strong>Mensagem:</strong> " + escape(exception.getMessage()) + "</p>");
        }
    }

    private void imprimirDadosDaConexao(PrintWriter out, Connection connection) throws SQLException {
        String sql = "SELECT DATABASE() AS banco_atual, CURRENT_USER() AS usuario_mysql";

        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                out.println("<p>Banco atual: <code>" + escape(resultSet.getString("banco_atual")) + "</code></p>");
                out.println("<p>Usuario MySQL: <code>" + escape(resultSet.getString("usuario_mysql")) + "</code></p>");
            }
        }
    }

    private void imprimirUsuarios(PrintWriter out, Connection connection) throws SQLException {
        String sql = "SELECT id, nome, email, senha, perfil FROM usuarios ORDER BY id";

        out.println("<h2>2. Usuarios cadastrados</h2>");

        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            out.println("<table>");
            out.println("<tr><th>ID</th><th>Nome</th><th>E-mail</th><th>Senha</th><th>Perfil</th></tr>");

            boolean encontrou = false;
            while (resultSet.next()) {
                encontrou = true;
                out.println("<tr>");
                out.println("<td>" + resultSet.getInt("id") + "</td>");
                out.println("<td>" + escape(resultSet.getString("nome")) + "</td>");
                out.println("<td>" + escape(resultSet.getString("email")) + "</td>");
                out.println("<td>" + escape(resultSet.getString("senha")) + "</td>");
                out.println("<td>" + escape(resultSet.getString("perfil")) + "</td>");
                out.println("</tr>");
            }

            if (!encontrou) {
                out.println("<tr><td colspan='5'>Nenhum usuario encontrado.</td></tr>");
            }

            out.println("</table>");
        }
    }

    private void testarCredenciais(PrintWriter out) {
        out.println("<h2>3. Teste automatico das credenciais</h2>");

        testarUmaCredencial(out, "admin@ozunas.com", "admin123");
        testarUmaCredencial(out, "cliente@ozunas.com", "cliente123");
    }

    private void testarUmaCredencial(PrintWriter out, String email, String senha) {
        try {
            User user = userDAO.login(email, senha);

            if (user == null) {
                out.println("<p class='erro'>Falhou: <code>" + email + "</code> / <code>" + senha + "</code></p>");
                return;
            }

            out.println("<p class='ok'>OK: <code>" + email + "</code> entrou como <code>" + user.getPerfil() + "</code>.</p>");
        } catch (SQLException exception) {
            out.println("<p class='erro'>Erro testando <code>" + email + "</code>: " + escape(exception.getMessage()) + "</p>");
        }
    }

    private String escape(String text) {
        if (text == null) {
            return "";
        }

        return text
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }
}
