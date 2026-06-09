package com.ozunas.servlet;

import com.ozunas.dao.MenuItemDAO;
import com.ozunas.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/cardapio")
public class AdminMenuServlet extends HttpServlet {
    private final MenuItemDAO menuItemDAO = new MenuItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!usuarioEhAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("menuItems", menuItemDAO.listarTodos());
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!usuarioEhAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        BigDecimal preco = new BigDecimal(request.getParameter("preco").replace(",", "."));
        String categoria = request.getParameter("categoria");
        String imagemUrl = request.getParameter("imagemUrl");
        boolean destaque = "on".equals(request.getParameter("destaque"));

        if (imagemUrl == null || imagemUrl.isBlank()) {
            imagemUrl = "https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=900&q=80";
        }

        boolean salvou = menuItemDAO.adicionar(nome, descricao, preco, categoria, imagemUrl, destaque);

        if (salvou) {
            response.sendRedirect(request.getContextPath() + "/admin/cardapio?sucesso=1");
        } else {
            request.setAttribute("erro", "Não foi possível adicionar o item. Verifique o banco de dados.");
            doGet(request, response);
        }
    }

    private boolean usuarioEhAdmin(HttpServletRequest request) {
        Object usuario = request.getSession().getAttribute("usuarioLogado");
        return usuario instanceof User && ((User) usuario).isAdmin();
    }
}
