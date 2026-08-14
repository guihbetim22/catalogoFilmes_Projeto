<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Mídia</title>
    <!-- Link para o CSS centralizado -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
</head>
<body class="container-cadastro">

    <div style="background: #e8f4f8; padding: 15px; border-radius: 5px; margin-bottom: 20px; max-width: 500px;">
        <h3 style="margin-top: 0;">Busca Rápida e Automática (TMDB)</h3>
        <form action="filmes?acao=buscarTmdb" method="post" style="padding: 0; border: none; margin: 0; box-shadow: none;">
            <input type="text" name="nomeFilme" placeholder="Digite o nome do filme..." required style="width: 60%; padding: 8px;">
            <button type="submit" style="background-color: #f39c12; width: auto; padding: 10px;">Importar do TMDB</button>
        </form>
    </div>
    
    <hr style="max-width: 500px; margin-left: 0;">
    <h3>Ou cadastre manualmente:</h3>

    <h1>Cadastrar Novo Filme ou Série</h1>
    <form action="filmes" method="post">
        <label>Título:</label>
        <input type="text" name="titulo" required>
        
        <label>Diretor/Autor:</label>
        <input type="text" name="autorDiretor">
        
        <label>Ano de Lançamento:</label>
        <input type="number" name="anoLancamento" required>

        <label>Duração (minutos):</label>
        <input type="number" name="duracao" required>
        
        <label>Gênero:</label>
        <input type="text" name="genero">
        
        <label>Tipo (Filme, Série, etc):</label>
        <input type="text" name="tipoMidia" required>
        
        <label>Sinopse:</label>
        <textarea name="sinopse" rows="4"></textarea>

        <label>Link da Capa do Filme (URL):</label><br>
        <input type="text" name="posterUrl" placeholder="https://exemplo.com/imagem.jpg"><br><br>
        
        <button type="submit">Salvar no Catálogo</button>
    </form>
    
    <a href="filmes" class="btn-gray">&larr; Voltar para a Lista</a>

</body>
</html>