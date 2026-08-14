<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- Se a lista estiver nula, redireciona para o Servlet -->
<c:if test="${listaFilmes == null}">
    <c:redirect url="filmes"/>
</c:if>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Filmes</title>
    
    <!-- Link conectando o arquivo CSS -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
</head>
<body>
    
    <jsp:include page="navbar.jsp" />

    <div class="header-acoes">
        <h1 style="color: #2c3e50; margin: 0;">A sua melhor experiência</h1>
        
        <!-- O BOTÃO DEVE FICAR AQUI, DO LADO DO TÍTULO H1 -->
        <c:if test="${usuarioLogado.perfil eq 'ADMIN'}">
            <a href="cadastro.jsp" class="btn-adicionar">Adicionar Novo Filme</a>
        </c:if>
    </div>
    <hr style="border: 1px solid #eee; margin-bottom: 20px;">

    <!-- NOVO GRID DE CARTÕES -->
    <div class="grid-filmes">
        <c:forEach var="filme" items="${listaFilmes}">
            <div class="card-filme">
                
                <!-- Capa -->
                <c:choose>
                    <c:when test="${not empty filme.posterUrl}">
                        <img src="${filme.posterUrl}" alt="Pôster de ${filme.titulo}" class="capa-filme">
                    </c:when>
                    <c:otherwise>
                        <div class="capa-filme" style="display: flex; align-items: center; justify-content: center; color: white;">
                            Sem Capa
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Informações -->
                <div class="info-filme">
                    <h3 class="titulo-filme">${filme.titulo}</h3>
                    <!-- Mostra o ano, gênero e diretor de forma sutil -->
                    <p class="detalhes-texto">${filme.anoLancamento} ${filme.duracao} mins ${filme.genero}</p>
                    
                    <!-- Botões de Ação -->
                    <div class="acoes-card">
                        <a href="detalhes?id=${filme.id}" class="btn-acao btn-detalhes">Detalhes</a>
                        <c:if test="${usuarioLogado.perfil == 'ADMIN'}">
                            <a href="filmes?acao=excluir&id=${filme.id}" class="btn-acao btn-excluir" onclick="return confirm('Tem certeza?');">Excluir</a>
                        </c:if>
                    </div>
                </div>
                
            </div>
        </c:forEach>

        <!-- Mensagem caso o catálogo esteja vazio -->
        <c:if test="${empty listaFilmes}">
            <p style="color: #7f8c8d; grid-column: 1 / -1; text-align: center; padding: 40px; font-size: 18px;">
                O catálogo está vazio. Que tal adicionar o primeiro filme?
            </p>
        </c:if>
    </div>
    
    </script>

</body>
</html>