<%--
    Interface de visualização (View) - Autenticação.
    Tela de acesso contendo o formulário seguro para login de usuários no sistema.
    Autor: Guilherme Mendes Betim - 2026
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎬</text></svg>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acesso - Catálogo de Filmes</title>
</head>
<body class="dark-mode" style="background-color: #14181c; margin: 0;">

    <div class="auth-wrapper">
        <div class="auth-floating-box">
            
            <!-- LOGO CENTRALIZADO -->
            <div style="text-align: center; margin-bottom: 25px;">
                <a href="${pageContext.request.contextPath}/filmes" class="navbar-logo" style="justify-content: center;">
                    <span class="logo-icone">🎬</span>
                    <span class="logo-texto">Catálogo<span class="logo-de">de</span><span class="logo-destaque">Filmes</span></span>
                </a>
            </div>

            <!-- === MENU INTERATIVO FLUTUANTE === -->
            <div class="auth-toggle-menu">
                <div class="toggle-slider" id="toggle-slider"></div>
                <button class="toggle-btn active" id="btn-login" onclick="switchMenu('login')">Entrar</button>
                <button class="toggle-btn" id="btn-cadastro" onclick="switchMenu('cadastro')">Criar Conta</button>
            </div>
            <!-- ================================= -->

            <!-- MENSAGENS DE SISTEMA -->
            <c:if test="${not empty mensagemErro}">
                <div class="msg-box msg-erro">⚠️ ${mensagemErro}</div>
            </c:if>
            <c:if test="${not empty mensagemSucesso}">
                <div class="msg-box msg-sucesso">✅ ${mensagemSucesso}</div>
            </c:if>

            <!-- =============================== -->
            <!-- FORMULÁRIO DE LOGIN (Visível)   -->
            <!-- =============================== -->
            <div id="form-login" class="form-section active">
                <form action="login" method="POST">
                    
                    <!-- === CORREÇÃO 1: Ação de Entrar oculta === -->
                    <input type="hidden" name="acao" value="entrar">
                    <!-- ========================================= -->

                    <div class="auth-input-group">
                        <label>E-mail</label>
                        <input type="email" name="email" required placeholder="seu@email.com">
                    </div>
                    <div class="auth-input-group">
                        <label>Senha</label>
                        <input type="password" name="senha" required placeholder="••••••••">
                    </div>
                    <button type="submit" class="auth-btn">Acessar Catálogo</button>
                </form>
            </div>

            <!-- =============================== -->
            <!-- FORMULÁRIO DE CADASTRO (Oculto) -->
            <!-- =============================== -->
            <div id="form-cadastro" class="form-section">
                <!-- === CORREÇÃO 2: Action apontando para login === -->
                <form action="login" method="POST">
                    
                    <!-- === CORREÇÃO 3: Ação de Cadastrar oculta === -->
                    <input type="hidden" name="acao" value="cadastrar">
                    <!-- ============================================ -->

                    <div class="auth-input-group">
                        <label>Nome Completo</label>
                        <input type="text" name="nome" required placeholder="Ex: João Silva">
                    </div>
                    <div class="auth-input-group">
                        <label>E-mail</label>
                        <input type="email" name="email" required placeholder="seu@email.com">
                    </div>
                    <div class="auth-input-group">
                        <label>Senha Segura</label>
                        <input type="password" name="senha" required placeholder="Crie sua senha">
                    </div>
                    <button type="submit" class="auth-btn btn-green">Finalizar Cadastro</button>
                </form>
            </div>

        </div>
    </div>

    <!-- SCRIPT DA ANIMAÇÃO DO MENU FLUTUANTE -->
    <script>
        function switchMenu(menu) {
            const slider = document.getElementById('toggle-slider');
            const btnLogin = document.getElementById('btn-login');
            const btnCadastro = document.getElementById('btn-cadastro');
            
            const formLogin = document.getElementById('form-login');
            const formCadastro = document.getElementById('form-cadastro');

            // Esconde os dois formulários primeiro para reiniciar a animação
            formLogin.classList.remove('active');
            formCadastro.classList.remove('active');

            if (menu === 'login') {
                // Move o fundo azul para a esquerda
                slider.style.transform = 'translateX(0)';
                btnLogin.classList.add('active');
                btnCadastro.classList.remove('active');
                
                // Exibe o formulário de login com um micro delay para ficar suave
                setTimeout(() => formLogin.classList.add('active'), 50);
            } else {
                // Move o fundo azul para a direita (100% da largura do slider + o pequeno espaçamento)
                slider.style.transform = 'translateX(calc(100% + 4px))';
                btnCadastro.classList.add('active');
                btnLogin.classList.remove('active');
                
                // Exibe o formulário de cadastro com um micro delay
                setTimeout(() => formCadastro.classList.add('active'), 50);
            }
        }
    </script>
    <!-- Fim do conteúdo da sua página -->
    
    <jsp:include page="footer.jsp" />
</body>
</html>