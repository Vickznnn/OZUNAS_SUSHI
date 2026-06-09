package com.ozunas.servlet;

import com.ozunas.dao.UserDAO;
import com.ozunas.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = limpar(request.getParameter("email"));
        String senha = limpar(request.getParameter("senha"));
        User user;

        request.setAttribute("emailDigitado", email);

        try {
            user = userDAO.login(email, senha);
        } catch (SQLException exception) {
            request.setAttribute("erro", "Erro no MySQL: " + exception.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (user == null) {
            request.setAttribute("erro", "E-mail ou senha incorretos. Use admin@ozunas.com / admin123 ou cliente@ozunas.com / cliente123.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        request.getSession().setAttribute("usuarioLogado", user);

        if (user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admin/cardapio");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    private String limpar(String valor) {
        return valor == null ? "" : valor.trim();
    }
}
