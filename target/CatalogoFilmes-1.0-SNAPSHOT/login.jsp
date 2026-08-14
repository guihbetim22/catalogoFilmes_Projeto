<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Acesso ao Sistema</title>
    <!-- Link para o CSS centralizado -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
</head>
<body class="wrapper-login">

    <!-- Avisos de erro ou sucesso dinâmicos -->
    <% if (request.getParameter("erro") != null) { %>
        <div class="msg-erro"><%= request.getParameter("erro") %></div>
    <% } %>
    <% if (request.getParameter("msg") != null) { %>
        <div class="msg-sucesso"><%= request.getParameter("msg") %></div>
    <% } %>

    <!-- Bloco 1: ÚNICO FORMULÁRIO DE LOGIN -->
    <div class="container-login">
        <h2>Já tenho conta (Login)</h2>
        <form action="login?acao=entrar" method="post">
            <label>E-mail:</label>
            <input type="email" name="email" required>
            
            <label>Senha:</label>
            <input type="password" name="senha" required>
            
            <button type="submit">Entrar</button>
        </form>
    </div>

    <!-- Bloco 2: ÚNICO FORMULÁRIO DE CADASTRO -->
    <div class="container-login">
        <h2>Criar uma conta</h2>
        <form action="login?acao=cadastrar" method="post">
            <label>Nome:</label>
            <input type="text" name="nome" required>
            
            <label>E-mail:</label>
            <input type="email" name="email" required>
            
            <label>Senha:</label>
            <input type="password" name="senha" required>
            
            <button type="submit" style="background-color: #27ae60;">Cadastrar</button>
        </form>
    </div>

</body>
</html>