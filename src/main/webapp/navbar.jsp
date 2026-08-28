<%--
    Fragmento de Interface (View) - Barra de Navegação.
    Componente global reutilizável que inclui a logo, os links do menu principal, 
    a barra de pesquisa e o botão de acionamento do Modo Escuro.
    Autor: Guilherme Mendes Betim - 2026
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="navbar">
    
    <!-- === LOGO CLICÁVEL === -->
    <a href="${pageContext.request.contextPath}/filmes" class="navbar-logo">
        <span class="logo-icone">🎬</span>
        <span class="logo-texto">Catálogo<span class="logo-de">de</span><span class="logo-destaque">Filmes</span></span>
    </a>
    <!-- ========================== -->
    
    <!-- === BARRA DE PESQUISA CENTRALIZADA === -->
    <div class="navbar-search-container">
        <!-- Adicionado o contextPath no action do form -->
        <form action="${pageContext.request.contextPath}/filmes" method="GET" class="navbar-search-form">
            <input type="text" name="busca" class="navbar-search-input" placeholder="Buscar filmes..." value="${param.busca}">
            <button type="submit" class="navbar-search-btn" title="Pesquisar">🔍</button>
        </form>
    </div>
    <!-- =========================================== -->

    <div class="nav-links">
        <c:choose>
            <c:when test="${not empty usuarioLogado}">
                <span style="margin-right: 15px;">Bem-vindo(a), <b>${usuarioLogado.nome}</b>!</span>
                
                <!-- 🔒 ÁREA EXCLUSIVA DO ADMIN -->
                <c:if test="${usuarioLogado.perfil eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-admin" style="margin-right: 10px;">📈 Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin-usuarios" class="btn btn-admin" style="margin-right: 15px;">⚙️ Usuários</a>
                </c:if>
                <!-- ============================ -->

                <c:if test="${ocultarBotaoLista ne 'true' and usuarioLogado.perfil ne 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/minhas-listas" class="btn-listas">Minha Lista</a>
                </c:if>
                
                <a href="${pageContext.request.contextPath}/login?acao=sair" class="btn-sair">Sair</a>
            </c:when>
            
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-blue" style="margin-left: 10px;">Entrar</a>
            </c:otherwise>
        </c:choose>
        <!-- Botão Dark Mode -->
        <button id="btn-theme" class="btn-theme-toggle" aria-label="Mudar Tema">🌙</button>
    </div>
</div>

<script>
    const btnTheme = document.getElementById('btn-theme');
    const body = document.body;

    // 1. Verifica se o usuário já salvou alguma preferência antes
    const temaSalvo = localStorage.getItem('tema');
    
    // 2. Pergunta ao navegador qual é o tema do sistema operacional do usuário
    const prefereDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

    // 3. Define o Modo Escuro se ele salvou 'dark' OU se ele nunca salvou nada e o sistema dele for Dark
    if (temaSalvo === 'dark' || (!temaSalvo && prefereDark)) {
        body.classList.add('dark-mode');
        if(btnTheme) btnTheme.textContent = '☀️';
    } else {
        if(btnTheme) btnTheme.textContent = '🌙';
    }

    // 4. O botão continua funcionando para sobrescrever a escolha do sistema
    if(btnTheme) {
        btnTheme.addEventListener('click', () => {
            body.classList.toggle('dark-mode');
            if (body.classList.contains('dark-mode')) {
                localStorage.setItem('tema', 'dark');
                btnTheme.textContent = '☀️';
            } else {
                localStorage.setItem('tema', 'light');
                btnTheme.textContent = '🌙';
            }
        });
    }
</script>

<!-- === SISTEMA GLOBAL DE TOAST (NOTIFICAÇÕES) === -->
<c:if test="${not empty sessionScope.mensagemToast}">
    <div id="toast-mensagem" class="toast-notificacao">
        ✅ ${sessionScope.mensagemToast}
    </div>
    
    <c:remove var="mensagemToast" scope="session" />

    <script>
        setTimeout(() => {
            const toast = document.getElementById('toast-mensagem');
            if (toast) {
                toast.classList.add('esconder'); 
                setTimeout(() => toast.remove(), 500); 
            }
        }, 3500);
    </script>
</c:if>


<!-- === Toast de Alerta de Login Global === -->
<div id="toast-login" class="toast-alerta">Você precisa estar logado para fazer isso.
    <a href="${pageContext.request.contextPath}/login.jsp" class="toast-link">Fazer Login</a>
</div>

<script>
function mostrarAlertaLogin() {
    const toast = document.getElementById("toast-login");
    if (toast) {
        toast.classList.add("mostrar");
        setTimeout(function() {
            toast.classList.remove("mostrar");
        }, 3000);
    }
}
</script>