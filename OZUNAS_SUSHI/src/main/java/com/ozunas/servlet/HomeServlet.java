package com.ozunas.servlet;

import com.ozunas.dao.MenuItemDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/home", "/cardapio"})
public class HomeServlet extends HttpServlet {
    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("menuItems", menuItemDAO.listarAtivos());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
