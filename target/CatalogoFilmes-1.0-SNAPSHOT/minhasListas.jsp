<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Minhas Listas</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <style>
        .btn-gray { background-color: #7f8c8d; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; text-decoration: none; margin-bottom: 20px; display: inline-block; }
        /* ======================================================= */
        /* ESTILOS BASE (MODO CLARO)                               */
        /* ======================================================= */
        body { font-family: Arial, sans-serif; background-color: #fdfbf7; padding: 20px; margin: 0; }
        
        .container { background: #fff; padding: 30px; border-radius: 8px; max-width: 900px; margin: auto; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: background-color 0.4s, color 0.4s; }
        
        .abas { margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .aba { padding: 10px 20px; text-decoration: none; font-weight: bold; color: #7f8c8d; border-radius: 4px; margin-right: 10px; transition: 0.2s; }
        .aba:hover { background-color: #f1f2f6; }
        .aba-ativa { background-color: #3498db !important; color: white !important; }
        
        .grid-filmes { display: flex; flex-wrap: wrap; gap: 20px; }
        
        /* Mudei o nome para card-lista para não conflitar com o catálogo */
        .card-lista { width: 150px; text-align: center; border: 1px solid #eee; padding: 10px; border-radius: 5px; background: #f9f9f9; display: flex; flex-direction: column; transition: transform 0.3s, box-shadow 0.3s; }
        .card-lista:hover { transform: translateY(-3px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .card-lista img { width: 100%; height: 220px; object-fit: cover; border-radius: 5px; }
        .capa-vazia { height: 220px; background: #ddd; display: flex; align-items: center; justify-content: center; border-radius: 5px; color: #666; font-size: 13px; }
        
        .btn-detalhes { display: block; background-color: #2c3e50; color: white; text-decoration: none; padding: 8px 5px; margin-top: auto; margin-bottom: 5px; border-radius: 3px; font-size: 13px; font-weight: bold; }
        .btn-remover { display: block; background-color: #e74c3c; color: white; text-decoration: none; padding: 8px 5px; border-radius: 3px; font-size: 13px; font-weight: bold; }

        /* ======================================================= */
        /* MODO ESCURO EXCLUSIVO PARA AS ABAS E CARDS DESTA PÁGINA */
        /* ======================================================= */
        body.dark-mode .container h2 { color: #ffffff !important; }
        body.dark-mode .abas { border-bottom: 2px solid #2c3440; }
        body.dark-mode .aba { color: #8ba5b0; }
        body.dark-mode .aba:hover { background-color: #2c3440; }
        
        body.dark-mode .card-lista { 
            background: #2c3440; 
            border-color: #1b2228; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.5); 
        }
        body.dark-mode .card-lista p { color: #e5e5e5 !important; }
        body.dark-mode .capa-vazia { background: #1b2228; color: #8ba5b0; }
        body.dark-mode .btn-detalhes { background-color: #3498db; }
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
        <div class="grid-filmes">
            <c:forEach var="filme" items="${minhaLista}">
                <div class="card-lista">
                    <c:if test="${not empty filme.posterUrl}">
                        <img src="${filme.posterUrl}" alt="Pôster">
                    </c:if>
                    <c:if test="${empty filme.posterUrl}">
                        <div class="capa-vazia">Sem Capa</div>
                    </c:if>
                    <p style="font-size: 14px; font-weight: bold; margin: 10px 0 5px 0;">${filme.titulo}</p>
                    <a href="detalhes?id=${filme.id}" class="btn-detalhes">Ver Detalhes</a>
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