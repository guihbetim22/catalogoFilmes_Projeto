<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Acesso ao Sistema</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #fdfbf7; display: flex; justify-content: center; padding: 60px 20px; }
        .container { background: #fff; padding: 20px 40px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 320px; margin: 0 15px; height: fit-content; }
        h2 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 5px; font-size: 22px; }
        input[type="text"], input[type="email"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0 16px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { width: 100%; background-color: #3498db; color: white; padding: 12px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-top: 10px; font-weight: bold; }
        button:hover { background-color: #2980b9; }
        .msg-erro { color: red; font-weight: bold; text-align: center; position: absolute; top: 15px; width: 100%; }
        .msg-sucesso { color: green; font-weight: bold; text-align: center; position: absolute; top: 15px; width: 100%; }
    </style>
</head>
<body>

    <!-- Avisos de erro ou sucesso dinâmicos -->
    <% if (request.getParameter("erro") != null) { %>
        <div class="msg-erro"><%= request.getParameter("erro") %></div>
    <% } %>
    <% if (request.getParameter("msg") != null) { %>
        <div class="msg-sucesso"><%= request.getParameter("msg") %></div>
    <% } %>

    <!-- Bloco 1: ÚNICO FORMULÁRIO DE LOGIN -->
    <div class="container">
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
    <div class="container">
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