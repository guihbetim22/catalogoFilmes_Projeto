<%--
    Interface de visualização (View) - Cadastro de Mídia.
    Apresenta o formulário para adição de novos filmes ou séries ao catálogo, 
    suportando importação automática via API ou preenchimento manual.
    Autor: Guilherme Mendes Betim - 2026
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎬</text></svg>">
    <meta charset="UTF-8">
    <title>Cadastrar Filme</title>
    <!-- Importa o nosso CSS principal -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
</head>
<body>
    
    <!-- 1. ADICIONA A NAVBAR PADRÃO -->
    <jsp:include page="navbar.jsp" />

    <!-- 2. CONTAINER CENTRALIZADOR DA PÁGINA -->
    <div class="container" style="max-width: 650px; margin-top: 40px; padding: 40px;">
        
        <h1 style="text-align: center; color: #3498db; border-bottom: 2px solid #eee; padding-bottom: 15px; margin-bottom: 25px;">Adicionar ao Catálogo</h1>

        <!-- === ÁREA 1: BUSCA RÁPIDA VIA TMDB === -->
        <div class="box-tmdb">
            <h3 style="margin-top: 0; color: #2c3e50; font-size: 18px;">⚡ Importação Rápida (Recomendado)</h3>
            <p style="font-size: 14px; color: #7f8c8d; margin-bottom: 15px;">Digite o nome do filme e nós preenchemos todos os dados e a capa usando a API do TMDB.</p>
            
            <form action="filmes" method="POST" style="display: flex; gap: 10px;">
                <input type="hidden" name="acao" value="buscarTmdb">
                <input type="text" name="nomeFilme" class="input-cadastro" placeholder="Ex: Interstellar, Shrek..." required style="margin: 0;">
                <button type="submit" class="btn btn-blue">Pesquisar e Importar</button>
            </form>
        </div>

        <!-- === ÁREA 2: CADASTRO MANUAL === -->
        <h3 class="divisor-manual" style="color: #2c3e50; margin-bottom: 20px; text-align: center; border-bottom: 1px solid #eee; padding-bottom: 10px;">Ou cadastre manualmente</h3>
        
        <form action="filmes" method="POST">
            
            <div class="form-group">
                <label>Título do Filme / Série:</label>
                <input type="text" name="titulo" class="input-cadastro" required>
            </div>

            <div class="form-group">
                <label>Diretor / Criador:</label>
                <input type="text" name="autorDiretor" class="input-cadastro">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Ano de Lançamento:</label>
                    <input type="number" name="anoLancamento" class="input-cadastro" min="1800" max="2100">
                </div>
                <div class="form-group">
                    <label>Duração (minutos):</label>
                    <input type="number" name="duracao" class="input-cadastro" min="1">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Gênero:</label>
                    <input type="text" name="genero" class="input-cadastro" placeholder="Ex: Ação, Drama...">
                </div>
                <div class="form-group">
                    <label>Tipo da Mídia:</label>
                    <input type="text" name="tipoMidia" class="input-cadastro" placeholder="Ex: Filme, Série...">
                </div>
            </div>

            <div class="form-group">
                <label>Sinopse:</label>
                <textarea name="sinopse" class="input-cadastro" rows="4"></textarea>
            </div>

            <div class="form-group">
                <label>URL do Pôster (Imagem da Capa):</label>
                <input type="text" name="posterUrl" class="input-cadastro" placeholder="https://...">
            </div>

            <button type="submit" class="btn btn-green" style="width: 100%; font-size: 16px; padding: 12px; margin-top: 10px;">Salvar Cadastro Manual</button>
        </form>

        <div style="text-align: center; margin-top: 30px;">
            <a href="filmes" class="btn-gray">⬅ Voltar ao Catálogo</a>
        </div>

    </div>
    <!-- Fim do conteúdo da sua página -->
    
    <jsp:include page="footer.jsp" />
</body>
</html>