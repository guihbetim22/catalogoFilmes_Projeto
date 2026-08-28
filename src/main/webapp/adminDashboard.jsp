<%--
    Interface de visualização (View) - Dashboard Administrativo.
    Responsável por exibir painéis, métricas e estatísticas gerenciais do sistema.
    Autor: Guilherme Mendes Betim - 2026
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🎬</text></svg>">
    <meta charset="UTF-8">
    <title>Dashboard Analítico - Admin</title>
    
    <!-- Ajuste do caminho do CSS para ficar igual ao seu index.jsp -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    
    <!-- Importando o Chart.js via CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
    </style>
</head>
<body class="dark-mode">

    <!-- Adicionando a Navbar para manter o padrão do sistema -->
    <jsp:include page="navbar.jsp" />

    <div class="dashboard-container">
        <h1 style="color: #ecf0f1;">📊 Dashboard Analítico</h1>
        <p style="color: #8ba5b0; margin-bottom: 30px;">Métricas e mineração de dados em tempo real da plataforma.</p>

        <!-- CARD DE USUÁRIOS ATIVOS -->
        <div class="cards-topo">
            <div class="card-stat">
                <p style="color: #8ba5b0; font-weight: bold; text-transform: uppercase;">Usuários Cadastrados</p>
                <h3>${totalUsuarios}</h3>
            </div>
        </div>

        <!-- GRID DE GRÁFICOS -->
        <div class="graficos-grid">
            <!-- Gráfico 1: Top 5 Filmes -->
            <div class="grafico-card">
                <h3>Top 5 Melhores Médias</h3>
                <canvas id="graficoTopFilmes"></canvas>
                <c:if test="${empty topFilmes}">
                    <p style="text-align: center; color: #7f8c8d; margin-top: 20px;">Nenhuma avaliação registrada ainda.</p>
                </c:if>
            </div>

            <!-- Gráfico 2: Gêneros Mais Adicionados -->
            <div class="grafico-card">
                <h3>Gêneros Mais Populares nas Listas</h3>
                <canvas id="graficoGeneros"></canvas>
                <c:if test="${empty generosPopulares}">
                    <p style="text-align: center; color: #7f8c8d; margin-top: 20px;">Nenhum filme adicionado às listas ainda.</p>
                </c:if>
            </div>
        </div>

        <div style="margin-top: 40px; text-align: center;">
            <a href="${pageContext.request.contextPath}/filmes" class="btn-gray">⬅ Voltar ao Catálogo</a>
        </div>
    </div>

    <!-- Scripts para renderizar os gráficos -->
    <script>
        // Configura a cor padrão dos textos do Chart.js para combinar com o Dark Mode
        Chart.defaults.color = '#8ba5b0';
        Chart.defaults.borderColor = '#2c3440';

        // Gráfico Top 5 Filmes
        const ctxFilmes = document.getElementById('graficoTopFilmes').getContext('2d');
        new Chart(ctxFilmes, {
            type: 'bar',
            data: {
                labels: [
                    <c:forEach var="entry" items="${topFilmes}">
                        "${entry.key}",
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Média de Notas',
                    data: [
                        <c:forEach var="entry" items="${topFilmes}">
                            ${entry.value},
                        </c:forEach>
                    ],
                    backgroundColor: '#3498db',
                    borderRadius: 5
                }]
            },
            options: { responsive: true, scales: { y: { beginAtZero: true, max: 5 } } }
        });

        // Gráfico de Gêneros
        const ctxGeneros = document.getElementById('graficoGeneros').getContext('2d');
        new Chart(ctxGeneros, {
            type: 'doughnut',
            data: {
                labels: [
                    <c:forEach var="entry" items="${generosPopulares}">
                        "${entry.key}",
                    </c:forEach>
                ],
                datasets: [{
                    data: [
                        <c:forEach var="entry" items="${generosPopulares}">
                            ${entry.value},
                        </c:forEach>
                    ],
                    backgroundColor: ['#e74c3c', '#3498db', '#f1c40f', '#2ecc71', '#9b59b6', '#e67e22'],
                    borderWidth: 0
                }]
            },
            options: { responsive: true, cutout: '70%' }
        });
    </script>
    <!-- Fim do conteúdo da sua página -->
    
    <jsp:include page="footer.jsp" />
</body>
</html>