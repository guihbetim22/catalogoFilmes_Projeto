<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- Se a lista estiver nula, redireciona para o Servlet -->
<c:if test="${listaFilmes == null}">
    <c:redirect url="filmes"/>
</c:if>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <meta charset="UTF-8">
    <title>Catálogo de Filmes</title>
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

    <!-- === NOVOS BOTÕES DE FILTRO === -->
    <div class="filtros-container" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; width: 100%; gap: 15px; margin-bottom: 25px;">
        
        <!-- BLOCO DA ESQUERDA: TODOS E GÊNEROS -->
        <div style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
            <a href="filmes" class="btn-filtro ${empty valorFiltroAtual ? 'ativo' : ''}">🌟 Todos</a>

            <span class="titulo-filtro" style="margin-left: 10px;">Gêneros:</span>
            <a href="filmes?filtro=genero&valor=Ação" class="btn-filtro ${valorFiltroAtual == 'Ação' ? 'ativo' : ''}">Ação</a>
            <a href="filmes?filtro=genero&valor=Comédia" class="btn-filtro ${valorFiltroAtual == 'Comédia' ? 'ativo' : ''}">Comédia</a>
            <a href="filmes?filtro=genero&valor=Drama" class="btn-filtro ${valorFiltroAtual == 'Drama' ? 'ativo' : ''}">Drama</a>
            <a href="filmes?filtro=genero&valor=Ficção" class="btn-filtro ${valorFiltroAtual == 'Ficção' ? 'ativo' : ''}">Ficção</a>
            <a href="filmes?filtro=genero&valor=Terror" class="btn-filtro ${valorFiltroAtual == 'Terror' ? 'ativo' : ''}">Terror</a>
            <a href="filmes?filtro=genero&valor=Romance" class="btn-filtro ${valorFiltroAtual == 'Romance' ? 'ativo' : ''}">Romance</a>
        </div>

        <!-- BLOCO DA DIREITA: LANÇAMENTOS E BUSCA DE ANO -->
        <div style="display: flex; flex-wrap: wrap; gap: 10px; align-items: center;">
            <span class="titulo-filtro">Lançamentos:</span>
            <a href="filmes?filtro=ano&valor=2026" class="btn-filtro ${valorFiltroAtual == '2026' ? 'ativo' : ''}">2026</a>
            <a href="filmes?filtro=ano&valor=2025" class="btn-filtro ${valorFiltroAtual == '2025' ? 'ativo' : ''}">2025</a>
            <a href="filmes?filtro=ano&valor=2024" class="btn-filtro ${valorFiltroAtual == '2024' ? 'ativo' : ''}">2024</a>
            
            <!-- CAMPO PARA DIGITAR QUALQUER ANO -->
            <form action="filmes" method="GET" style="display: flex; align-items: center; gap: 5px; margin-left: 5px; margin-bottom: 0;">
                <input type="hidden" name="filtro" value="ano">
                <input type="number" name="valor" class="input-ano" placeholder="Ano" min="1800" max="2100" required>
                <button type="submit" class="btn-filtro" style="cursor: pointer; padding: 6px 10px;">🔍</button>
            </form>
        </div>

    </div>
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