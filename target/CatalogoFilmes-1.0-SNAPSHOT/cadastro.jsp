<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    
    <div style="background: #e8f4f8; padding: 15px; border-radius: 5px; margin-bottom: 20px;">
        <h3>Busca Rápida e Automática (TMDB)</h3>
        <form action="filmes?acao=buscarTmdb" method="post">
            <input type="text" name="nomeFilme" placeholder="Digite o nome do filme..." required style="width: 70%; padding: 8px;">
            <button type="submit" style="background-color: #f39c12;">Importar do TMDB</button>
        </form>
    </div>
    
    <hr>
    <h3>Ou cadastre manualmente:</h3>

    <!-- O seu formulário manual antigo continua aqui embaixo -->


    <title>Cadastrar Mídia</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #fdfbf7; color: #333; }
        h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        form { background: #fff; padding: 20px; border-radius: 5px; border: 1px solid #ddd; max-width: 500px; margin-bottom: 20px; }
        label { font-weight: bold; }
        input[type="text"], input[type="number"], textarea { width: 100%; padding: 8px; margin: 8px 0 15px 0; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        button { background-color: #27ae60; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        button:hover { background-color: #2ecc71; }
        a { text-decoration: none; color: #3498db; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
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
    <a href="filmes">&larr; Voltar para a Lista</a>
</body>
</html>
