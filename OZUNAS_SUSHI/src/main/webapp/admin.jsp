<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ozunas.model.MenuItem" %>
<%@ page import="com.ozunas.model.User" %>
<%@ page import="java.util.List" %>
<%
    String contextPath = request.getContextPath();
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    User usuarioLogado = (User) session.getAttribute("usuarioLogado");
    String erro = (String) request.getAttribute("erro");
    boolean sucesso = "1".equals(request.getParameter("sucesso"));
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Painel ADM | Ozunas Sushi</title>
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= contextPath %>/home">
        <span class="brand-mark">OZ</span>
        <span>
            <strong>Ozunas Sushi</strong>
            <small>painel administrativo</small>
        </span>
    </a>

    <nav class="nav-actions" aria-label="Menu administrativo">
        <a href="<%= contextPath %>/home">Ver site</a>
        <span class="logged-user"><%= usuarioLogado.getNome() %></span>
        <a class="button secondary" href="<%= contextPath %>/logout">Sair</a>
    </nav>
</header>

<main class="admin-layout">
    <section class="admin-heading">
        <p class="eyebrow">Administração</p>
        <h1>Cardápio do Ozunas Sushi</h1>
        <p>Cadastre novos pratos, categorias, preços e imagens para aparecerem no site.</p>
    </section>

    <section class="admin-form-panel">
        <div class="section-title">
            <p class="eyebrow">ADICIONE MAIS OPÇÕES DO CARDÁPIO AQUI</p>
            <h2>Novo item</h2>
        </div>

        <% if (sucesso) { %>
            <div class="success">Item adicionado com sucesso.</div>
        <% } %>

        <% if (erro != null) { %>
            <div class="alert"><%= erro %></div>
        <% } %>

        <form class="form admin-form" action="<%= contextPath %>/admin/cardapio" method="post">
            <label>
                Nome do prato
                <input type="text" name="nome" placeholder="Ex: Joe de salmão" required>
            </label>

            <label>
                Categoria
                <input type="text" name="categoria" placeholder="Ex: Sashimis, Bebidas, Sobremesas" required>
            </label>

            <label>
                Preço
                <input type="number" name="preco" min="0" step="0.01" placeholder="29.90" required>
            </label>

            <label>
                URL da imagem
                <input type="url" name="imagemUrl" placeholder="https://...">
            </label>

            <label class="full-column">
                Descrição
                <textarea name="descricao" rows="4" placeholder="Descreva os ingredientes do prato" required></textarea>
            </label>

            <label class="checkbox-line">
                <input type="checkbox" name="destaque">
                <span>Marcar como destaque no cardápio</span>
            </label>

            <button class="button primary full-column" type="submit">Adicionar ao cardápio</button>
        </form>
    </section>

    <section class="admin-table-panel">
        <div class="section-title">
            <p class="eyebrow">Itens cadastrados</p>
            <h2>Lista atual</h2>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>Prato</th>
                    <th>Categoria</th>
                    <th>Preço</th>
                    <th>Destaque</th>
                </tr>
                </thead>
                <tbody>
                <% if (menuItems != null) { %>
                    <% for (MenuItem item : menuItems) { %>
                        <tr>
                            <td><%= item.getNome() %></td>
                            <td><%= item.getCategoria() %></td>
                            <td>R$ <%= item.getPreco().toString().replace(".", ",") %></td>
                            <td><%= item.isDestaque() ? "Sim" : "Não" %></td>
                        </tr>
                    <% } %>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</main>
</body>
</html>
