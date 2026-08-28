<%--
    Interface de visualização (View) - Página Principal (Catálogo).
    Responsável por renderizar a grade principal de filmes e séries disponíveis no sistema.
    Autor: Guilherme Mendes Betim - 2026
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- Se a lista estiver nula, redireciona para o Servlet -->
<c:if test="${listaFilmes == null}">
    <c:redirect url="filmes"/>
</c:if>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎬</text></svg>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <meta charset="UTF-8">
    <title>Catálogo de Filmes</title>
</head>
<body>
    
    <jsp:include page="navbar.jsp" />

    <!-- ===  DIV QUE CENTRALIZA E LIMITA A LARGURA DA TELA === -->
    <div style="max-width: 1300px; margin: 0 auto; padding: 0 20px;">

        <!-- === CABEÇALHO HERO (Título e Subtítulo) === -->
        <div class="header-acoes" style="align-items: center; margin-bottom: 20px; margin-top: 10px;">
            <div class="textos-header">
                <h1 class="titulo-destaque">A sua melhor experiência</h1>
                <p class="subtitulo-destaque">Explore, filtre e encontre o seu próximo filme favorito.</p>
            </div>
            
            <!-- O BOTÃO ADMIN -->
            <c:if test="${usuarioLogado.perfil eq 'ADMIN'}">
                <a href="cadastro.jsp" class="btn-adicionar">Adicionar Novo Filme</a>
            </c:if>
        </div>

        <!-- === PAINEL DE FILTROS ESTILIZADO === -->
        <div class="painel-filtros">
            
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
                        <p class="detalhes-texto">${filme.anoLancamento} &bull; ${filme.duracao} min &bull; ${filme.genero}</p>
                        
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
            
        </div> <!-- FECHAMENTO CORRETO DO GRID DE FILMES -->

        <!-- === CONTROLES DE PAGINAÇÃO AGORA ESTÃO FORA DO GRID === -->
        <c:if test="${totalPaginas > 1}">
            <div class="paginacao">
                <!-- Botão Anterior -->
                <c:if test="${paginaAtual > 1}">
                    <a href="filmes?pagina=${paginaAtual - 1}" class="btn-pagina">&laquo; Anterior</a>
                </c:if>

                <!-- Números das Páginas -->
                <c:forEach begin="1" end="${totalPaginas}" var="i">
                    <a href="filmes?pagina=${i}" class="btn-pagina ${paginaAtual == i ? 'ativo' : ''}">${i}</a>
                </c:forEach>

                <!-- Botão Próxima -->
                <c:if test="${paginaAtual < totalPaginas}">
                    <a href="filmes?pagina=${paginaAtual + 1}" class="btn-pagina">Próxima &raquo;</a>
                </c:if>
            </div>
        </c:if>

    </div> <!-- FECHAMENTO DA NOVA DIV CENTRALIZADORA -->
    <!-- Fim do conteúdo da sua página -->
    
    <jsp:include page="footer.jsp" />
</body>
</html>