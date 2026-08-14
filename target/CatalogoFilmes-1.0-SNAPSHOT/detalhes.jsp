<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <meta charset="UTF-8">
    <title>Detalhes do Filme</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #fdfbf7; padding: 20px; }
        .container { background: #fff; padding: 30px; border-radius: 8px; max-width: 800px; margin: auto; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .poster { max-width: 250px; border-radius: 8px; float: left; margin-right: 25px; box-shadow: 2px 2px 5px rgba(0,0,0,0.3); }
        .clear { clear: both; }
        .btn { padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; color: white; font-weight: bold; text-decoration: none; }
        .btn-blue { background-color: #3498db; }
        .btn-green { background-color: #27ae60; }
        .btn-gray { background-color: #7f8c8d; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; text-decoration: none; margin-bottom: 20px; display: inline-block; }
        .comentario-box { border-bottom: 1px solid #eee; padding: 15px 0; }
        .estrelas { color: #f39c12; font-size: 18px; font-weight: bold; }
        .tag-tipo { background-color: #e74c3c; color: white; padding: 3px 8px; border-radius: 12px; font-size: 12px; }
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

            <!-- Botões de Listas Pessoais -->
            <form action="detalhes?acao=lista" method="post" style="margin-top: 15px;">
                <input type="hidden" name="idMidia" value="${filme.id}">
                <button type="submit" name="status" value="JA_ASSISTI" class="btn btn-green">👁️ Já Assisti</button>
                <button type="submit" name="status" value="QUERO_ASSISTIR" class="btn btn-blue">⏳ Quero Assistir</button>
            </form>
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
            <button type="submit" class="btn btn-blue">Publicar Avaliação</button>
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
                        
                        <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; font-size: 12px; font-weight: bold;" onclick="return confirm('ADMIN: Tem certeza que deseja apagar este comentário da comunidade?');">
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
</body>
</html>