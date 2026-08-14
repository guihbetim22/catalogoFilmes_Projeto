<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <meta charset="UTF-8">
    <title>Minhas Listas</title>
    <style>
    </style>
</head>
<body>
    <c:set var="ocultarBotaoLista" value="true" scope="request" />

    <jsp:include page="navbar.jsp" />

    <div class="container">
        <a href="filmes" class="btn-gray">⬅ Voltar ao Catálogo</a>

        <h2 style="color: #2c3e50; margin-top: 20px;">🎬 Minhas Listas Pessoais</h2>
        
        <!-- Menus de navegação das listas -->
        <div class="abas">
            <a href="minhas-listas?status=QUERO_ASSISTIR" class="aba ${abaAtiva == 'QUERO_ASSISTIR' ? 'aba-ativa' : ''}">⏳ Quero Assistir</a>
            <a href="minhas-listas?status=JA_ASSISTI" class="aba ${abaAtiva == 'JA_ASSISTI' ? 'aba-ativa' : ''}">👁️ Já Assisti</a>
        </div>

        <!-- Grade de filmes -->
        <div class="grid-listas">
            <c:forEach var="filme" items="${minhaLista}">
                <div class="card-lista">
                    <c:if test="${not empty filme.posterUrl}">
                        <img src="${filme.posterUrl}" alt="Pôster">
                    </c:if>
                    <c:if test="${empty filme.posterUrl}">
                        <div class="capa-vazia">Sem Capa</div>
                    </c:if>
                    <p style="font-size: 14px; font-weight: bold; margin: 10px 0 5px 0;">${filme.titulo}</p>
                    <a href="detalhes?id=${filme.id}" class="btn-detalhes-lista">Ver Detalhes</a>
                    <a href="minhas-listas?acao=remover&idMidia=${filme.id}&status=${abaAtiva}" 
                       class="btn-remover"
                       onclick="return confirm('Tem certeza que deseja tirar este filme da sua lista?');">Remover</a>
                </div>
            </c:forEach>
            <c:if test="${empty minhaLista}">
                <p style="color: #7f8c8d; padding: 20px;">Nenhum título encontrado nesta lista.</p>
            </c:if>
        </div>
    </div>
</body>
</html>