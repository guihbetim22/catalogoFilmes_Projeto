<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <meta charset="UTF-8">
    <title>Gerenciar Usuários</title>
    <style>
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">
        <!-- === BOTÃO VOLTAR ADICIONADO AQUI === -->
        <a href="filmes" class="btn-gray">⬅ Voltar ao Catálogo</a>
        
        <h2>👥 Gerenciamento de Usuários</h2>
        <p>Abaixo estão listados todos os usuários cadastrados no sistema.</p>
        <hr style="margin-bottom: 20px;">

        <c:forEach var="u" items="${usuarios}">
            <div class="user-box">
                <div>
                    <p style="margin: 0; font-size: 16px;">
                        <b>${u.nome}</b> (${u.email})
                        <c:if test="${u.perfil eq 'ADMIN'}">
                            <span class="tag-admin">ADMIN</span>
                        </c:if>
                    </p>
                </div>

                <c:if test="${u.id ne usuarioLogado.id}">
                    <form action="admin-usuarios" method="post" style="margin: 0;">
                        <input type="hidden" name="acao" value="excluir">
                        <input type="hidden" name="idUsuario" value="${u.id}">
                        <button type="submit" class="btn-red" onclick="return confirm('ATENÇÃO: Tem certeza que deseja apagar o usuário ${u.nome}? Todas as avaliações e listas dele também serão deletadas permanentemente!');">
                            🗑️ Excluir
                        </button>
                    </form>
                </c:if>
            </div>
        </c:forEach>
    </div>
</body>
</html>