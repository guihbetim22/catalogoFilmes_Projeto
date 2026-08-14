<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="navbar">
    <h2>🎬 Catálogo de Filmes</h2>
    <div class="nav-links">
        <c:choose>
            <c:when test="${not empty usuarioLogado}">
                <span style="margin-right: 15px;">Bem-vindo(a), <b>${usuarioLogado.nome}</b>!</span>
                
                <c:if test="${usuarioLogado.perfil eq 'ADMIN'}">
                    <a href="admin-usuarios" style="text-decoration: none; font-weight: bold; margin-right: 15px;">⚙️ Usuários</a>
                
                </c:if>
                <!-- O botão só aparece se a variável NÃO for true -->
                <c:if test="${ocultarBotaoLista ne 'true'}">
                    <a href="minhas-listas" class="btn-listas">Minhas Listas</a>
                </c:if>
                
                <a href="login?acao=sair" class="btn-sair">Sair</a>
            </c:when>
            
            <c:otherwise>
                <a href="login.jsp" style="background-color: #3498db; color: white; padding: 8px 20px; border-radius: 4px; text-decoration: none; font-weight: bold; margin-left: 10px;">Entrar</a>
            </c:otherwise>
        </c:choose>
        <!-- Botão Dark Mode -->
        <button id="btn-theme" style="margin-left: 15px; cursor: pointer; background: none; border: none; font-size: 20px;">🌙</button>
    </div>
</div>

<script>
    const btnTheme = document.getElementById('btn-theme');
    const body = document.body;

    // Quando a página carrega, aplica o tema salvo
    if (localStorage.getItem('tema') === 'dark') {
        body.classList.add('dark-mode');
        if(btnTheme) btnTheme.textContent = '☀️';
    }

    // Quando clica no botão
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