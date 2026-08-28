/**
 * Controlador (Servlet) que alimenta a interface do painel de controle (Dashboard).
 * Intercepta a requisição do painel administrativo, consulta as métricas gerenciais 
 * via RelatorioDAO e despacha os resultados para análise gráfica e estatística do Admin.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 */

package controller;

import java.io.IOException;
import java.util.Map;

import dao.RelatorioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private RelatorioDAO relatorioDAO;

    @Override
    public void init() {
        relatorioDAO = new RelatorioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Coleta as métricas mineradas do banco
        int totalUsuarios = relatorioDAO.contarUsuariosAtivos();
        Map<String, Double> topFilmes = relatorioDAO.obterTop5Filmes();
        Map<String, Integer> generosPopulares = relatorioDAO.obterGenerosMaisAdicionados();

        // Envia para a visão (JSP)
        request.setAttribute("totalUsuarios", totalUsuarios);
        request.setAttribute("topFilmes", topFilmes);
        request.setAttribute("generosPopulares", generosPopulares);

        request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
    }
}