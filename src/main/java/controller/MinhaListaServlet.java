/**
 * Controlador (Servlet) que gerencia as listas personalizadas do usuário logado.
 * Processa as requisições para adicionar, remover ou listar os filmes marcados 
 * com status específicos ("Já Assisti" / "Quero Assistir") no catálogo pessoal.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 */

package controller;

import java.io.IOException;
import java.util.List;

import dao.InteracaoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ItemMidia;
import model.Usuario;

@WebServlet("/minhas-listas")
public class MinhaListaServlet extends HttpServlet {
    private InteracaoDAO interacaoDAO;

    @Override
    public void init() {
        interacaoDAO = new InteracaoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Só puxamos o usuário da sessão porque precisamos do ID dele. 
        // O Filtro já garantiu que ele JAMAIS será nulo aqui dentro!
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");

        String acao = request.getParameter("acao");
        String status = request.getParameter("status");
        
        // Mantém a aba padrão se o status vier vazio
        if (status == null || status.isEmpty()) {
            status = "QUERO_ASSISTIR";
        }

        // === LÓGICA DE EXCLUSÃO ===
        if ("remover".equals(acao)) {
            int idMidia = Integer.parseInt(request.getParameter("idMidia"));
            interacaoDAO.removerDaLista(usuario.getId(), idMidia);
            
            // === TOAST DE REMOÇÃO ===
            session.setAttribute("mensagemToast", "Filme removido da sua lista!");
            
            // Redireciona de volta para a mesma aba que o usuário estava
            response.sendRedirect("minhas-listas?status=" + status);
            return;
        }

        // Busca a lista no banco de dados para exibir na tela
        List<ItemMidia> minhaLista = interacaoDAO.listarMinhasMidias(usuario.getId(), status);
        
        request.setAttribute("minhaLista", minhaLista);
        request.setAttribute("abaAtiva", status);
        
        request.getRequestDispatcher("minhasListas.jsp").forward(request, response);
    }
}