<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ozunas.model.MenuItem" %>
<%@ page import="com.ozunas.model.User" %>
<%@ page import="java.util.LinkedHashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    User usuarioLogado = (User) session.getAttribute("usuarioLogado");
    String contextPath = request.getContextPath();
    Set<String> categorias = new LinkedHashSet<>();

    if (menuItems != null) {
        for (MenuItem item : menuItems) {
            categorias.add(item.getCategoria());
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ozunas Sushi | Cardápio</title>
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= contextPath %>/home">
        <span class="brand-mark">OZ</span>
        <span>
            <strong>Ozunas Sushi</strong>
            <small>culinária japonesa</small>
        </span>
    </a>

    <nav class="nav-actions" aria-label="Menu principal">
        <a href="#cardapio">Cardápio</a>
        <% if (usuarioLogado != null && usuarioLogado.isAdmin()) { %>
            <a href="<%= contextPath %>/admin/cardapio">Painel ADM</a>
        <% } %>
        <% if (usuarioLogado == null) { %>
            <a class="button secondary" href="<%= contextPath %>/login">Entrar</a>
        <% } else { %>
            <span class="logged-user">Olá, <%= usuarioLogado.getNome() %></span>
            <a class="button secondary" href="<%= contextPath %>/logout">Sair</a>
        <% } %>
    </nav>
</header>

<main>
    <section class="hero">
        <div class="hero-content">
            <p class="eyebrow">Sushi bar artesanal</p>
            <h1>Ozunas Sushi</h1>
            <p>Sashimis frescos, combinados caprichados e hot rolls crocantes para pedir sem enrolação.</p>
            <div class="hero-actions">
                <a class="button primary" href="#cardapio">Ver cardápio</a>
                <a class="button ghost" href="<%= contextPath %>/login">Login cliente/ADM</a>
            </div>
        </div>
    </section>

    <section class="section intro">
        <div>
            <p class="eyebrow">Escolha por categoria</p>
            <h2>Cardápio da casa</h2>
        </div>
        <div class="filters" aria-label="Filtros do cardápio">
            <button class="filter-button active" data-filter="todos" type="button">Todos</button>
            <% for (String categoria : categorias) { %>
                <button class="filter-button" data-filter="<%= categoria %>" type="button"><%= categoria %></button>
            <% } %>
        </div>
    </section>

    <section id="cardapio" class="menu-grid" aria-live="polite">
        <% if (menuItems == null || menuItems.isEmpty()) { %>
            <div class="empty-state">
                <h2>Nenhum item cadastrado ainda.</h2>
                <p>Entre como administrador para adicionar as primeiras opções do cardápio.</p>
            </div>
        <% } else { %>
            <% for (MenuItem item : menuItems) { %>
                <article class="menu-card" data-category="<%= item.getCategoria() %>">
                    <img src="<%= item.getImagemUrl() %>" alt="<%= item.getNome() %>">
                    <div class="menu-card-body">
                        <div class="menu-card-heading">
                            <span class="tag"><%= item.getCategoria() %></span>
                            <% if (item.isDestaque()) { %>
                                <span class="tag highlight">Destaque</span>
                            <% } %>
                        </div>
                        <h3><%= item.getNome() %></h3>
                        <p><%= item.getDescricao() %></p>
                        <div class="price-row">
                            <strong>R$ <%= item.getPreco().toString().replace(".", ",") %></strong>
                            <button class="small-button" type="button" data-item="<%= item.getNome() %>">Pedir</button>
                        </div>
                    </div>
                </article>
            <% } %>
        <% } %>
    </section>
</main>

<div class="toast" id="toast" role="status" aria-live="polite"></div>

<footer class="footer">
    <strong>Ozunas Sushi</strong>
    <span>Aberto de terça a domingo, das 18h às 23h.</span>
</footer>

<script src="<%= contextPath %>/assets/js/main.js"></script>
</body>
</html>
