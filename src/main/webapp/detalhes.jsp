<%--
    Interface de visualização (View) - Detalhes do Filme/Série.
    Renderiza as informações completas de um título específico e exibe a 
    seção de interações, notas e comentários da comunidade.
    Autor: Guilherme Mendes Betim - 2026
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎬</text></svg>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css?v=2'/>">
    <meta charset="UTF-8">
    <title>Detalhes do Filme</title>
    <style>
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        <a href="filmes" class="btn-gray">⬅ Voltar ao Catálogo</a>
        
        <div>
            <c:if test="${not empty filme.posterUrl}">
                <img src="${filme.posterUrl}" class="poster">
            </c:if>
            
            <h2>${filme.titulo} (${filme.anoLancamento}) <span class="tag-tipo">${filme.tipoMidia}</span></h2>
            <p><b>Diretor:</b> ${filme.autorDiretor} | <b>Gênero:</b> ${filme.genero} | <b>Duração:</b> ${filme.duracao} Minutos</p>
            <p style="line-height: 1.6;"><b>Sinopse:</b> ${filme.sinopse}</p>
            
            <h3 class="estrelas">⭐ Média Geral: ${media} / 5.0</h3>

            <!-- ========================================== -->
            <!-- PROTEÇÃO DOS BOTÕES DE LISTAS PESSOAIS     -->
            <!-- ========================================== -->
            <c:choose>
                <c:when test="${empty usuarioLogado}">
                    <!-- Botões Falsos: Apenas chamam o Toast -->
                    <div style="margin-top: 15px;">
                        <button type="button" class="btn btn-green" onclick="mostrarAlertaLogin()">👁️ Já Assisti</button>
                        <button type="button" class="btn btn-blue" onclick="mostrarAlertaLogin()">⏳ Quero Assistir</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Formulário Real: Executado se estiver logado -->
                    <form action="detalhes?acao=lista" method="post" style="margin-top: 15px;">
                        <input type="hidden" name="idMidia" value="${filme.id}">
                        <button type="submit" name="status" value="JA_ASSISTI" class="btn btn-green">👁️ Já Assisti</button>
                        <button type="submit" name="status" value="QUERO_ASSISTIR" class="btn btn-blue">⏳ Quero Assistir</button>
                    </form>
                </c:otherwise>
            </c:choose>
            <!-- ========================================== -->

        </div>

        <div class="clear"></div>
        <hr style="margin: 30px 0;">

        <!-- Formulário para o usuário avaliar -->
        <h3>Deixe sua Avaliação</h3>
        <form action="detalhes?acao=avaliar" method="post" style="background: #f9f9f9; padding: 15px; border-radius: 5px;">
            <input type="hidden" name="idMidia" value="${filme.id}">
            <label><b>Sua Nota (1 a 5):</b></label>
            <input type="number" name="nota" min="1" max="5" required style="width: 60px; padding: 5px; margin-bottom: 10px;">
            <br>
            <textarea name="comentario" rows="3" style="width: 100%; padding: 10px; box-sizing: border-box;" placeholder="Escreva o que você achou..." required></textarea>
            <br><br>
            
            <!-- ========================================== -->
            <!-- PROTEÇÃO DO BOTÃO DE AVALIAR               -->
            <!-- ========================================== -->
            <c:choose>
                <c:when test="${empty usuarioLogado}">
                    <!-- Botão Falso -->
                    <button type="button" class="btn btn-blue" onclick="mostrarAlertaLogin()">Publicar Avaliação</button>
                </c:when>
                <c:otherwise>
                    <!-- Botão Real -->
                    <button type="submit" class="btn btn-blue">Publicar Avaliação</button>
                </c:otherwise>
            </c:choose>
            <!-- ========================================== -->
        </form>

        <hr style="margin: 30px 0;">

        <!-- Listagem dinâmica de Comentários -->
        <h3>Comentários da Comunidade</h3>
        <c:forEach var="av" items="${avaliacoes}">
            <div class="comentario-box" style="position: relative;">
                
                <!-- === BOTÃO DE EXCLUIR DO ADMIN === -->
                <c:if test="${usuarioLogado.perfil eq 'ADMIN'}">
                    <form action="detalhes" method="post" style="position: absolute; top: 10px; right: 10px; background: transparent; padding: 0; box-shadow: none;">
                        <input type="hidden" name="acao" value="excluirComentario">
                        <input type="hidden" name="idMidia" value="${filme.id}">
                        <input type="hidden" name="idAvaliacao" value="${av.id}">
                        
                        <button type="submit" class="btn btn-red" style="font-size: 12px; padding: 5px 10px;" onclick="return confirm('ADMIN: Tem certeza que deseja apagar este comentário da comunidade?');">
                            🗑️ Excluir
                        </button>
                    </form>
                </c:if>
                <!-- ================================== -->

                <p style="margin: 0 0 5px 0;"><b>${av.nomeUsuario}</b> avaliou com <span class="estrelas">⭐ ${av.nota}</span></p>
                <p style="font-size: 12px; color: #7f8c8d; margin: 0 0 10px 0;">Em: ${av.dataAvaliacao}</p>
                <p style="margin: 0; font-style: italic;">"${av.comentario}"</p>
            </div>
        </c:forEach>
        <c:if test="${empty avaliacoes}">
            <p style="color: #7f8c8d;">Nenhum comentário ainda. Seja o primeiro a avaliar!</p>
        </c:if>
    </div>
    <!-- Fim do conteúdo da sua página -->
    
    <jsp:include page="footer.jsp" />
</body>
</html>