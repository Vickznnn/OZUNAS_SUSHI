<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
    String erro = (String) request.getAttribute("erro");
    String emailDigitado = (String) request.getAttribute("emailDigitado");
    if (emailDigitado == null) {
        emailDigitado = "";
    }
    boolean tentativaRecebida = "POST".equalsIgnoreCase(request.getMethod());
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Ozunas Sushi</title>
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">
</head>
<body class="login-page">
<main class="login-shell">
    <section class="login-panel">
        <a class="brand" href="<%= contextPath %>/home">
            <span class="brand-mark">OZ</span>
            <span>
                <strong>Ozunas Sushi</strong>
                <small>acesso ao site</small>
            </span>
        </a>

        <h1>Entrar</h1>
        <p class="muted">Use o e-mail e a senha de cliente ou administrador.</p>

        <% if (erro != null) { %>
            <div class="alert login-alert"><strong>Login nao realizado.</strong><br><%= erro %></div>
        <% } else if (tentativaRecebida) { %>
            <div class="alert login-alert"><strong>POST recebido.</strong><br>O formulario chegou no servidor, mas nenhuma mensagem de erro foi enviada.</div>
        <% } %>

        <form class="form" action="<%= contextPath %>/login" method="post">
            <label>
                E-mail
                <input type="email" name="email" value="<%= emailDigitado %>" placeholder="cliente@ozunas.com" required>
            </label>

            <label>
                Senha
                <span class="password-field">
                    <input id="senha" type="password" name="senha" placeholder="Digite sua senha" required>
                    <button class="icon-button" type="button" data-toggle-password="senha" aria-label="Mostrar senha">👁</button>
                </span>
            </label>

            <button class="button primary full" type="submit">Acessar</button>
        </form>

        <div class="demo-access">
            <strong>Acessos para teste</strong>
            <span>Cliente: cliente@ozunas.com / cliente123</span>
            <span>ADM: admin@ozunas.com / admin123</span>
            <a href="<%= contextPath %>/teste-login">Abrir teste do banco e login</a>
        </div>
    </section>
</main>

<script src="<%= contextPath %>/assets/js/main.js"></script>
</body>
</html>
