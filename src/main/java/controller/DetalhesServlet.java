/**
 * Controlador (Servlet) responsável por orquestrar a exibição dos detalhes de uma mídia.
 * Busca as informações completas do filme no ItemMidiaDAO e as avaliações da comunidade 
 * no InteracaoDAO, consolidando os dados para a renderização na página de detalhes.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 */

package controller;

import java.io.IOException;
import java.util.List;

import dao.InteracaoDAO;
import dao.ItemMidiaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Avaliacao;
import model.ItemMidia;
import model.Usuario;

@WebServlet("/detalhes")
public class DetalhesServlet extends HttpServlet {
    private InteracaoDAO interacaoDAO;
    private ItemMidiaDAO midiaDAO;

    @Override
    public void init() {
        interacaoDAO = new InteracaoDAO();
        midiaDAO = new ItemMidiaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // GET é público: Qualquer visitante pode acessar e ler a página!
        int idMidia = Integer.parseInt(request.getParameter("id"));
        
        ItemMidia filme = midiaDAO.buscarPorId(idMidia); 
        List<Avaliacao> avaliacoes = interacaoDAO.listarAvaliacoes(idMidia);
        double media = interacaoDAO.obterMediaEstrelas(idMidia);

        request.setAttribute("filme", filme);
        request.setAttribute("avaliacoes", avaliacoes); 
        request.setAttribute("media", String.format("%.1f", media));

        request.getRequestDispatcher("detalhes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        
        // === SEGURANÇA CENTRALIZADA ===
        // O FiltroAutenticacao já validou que é um POST e garantiu que o usuario NÃO É NULL aqui!

        String acao = request.getParameter("acao");
        int idMidia = Integer.parseInt(request.getParameter("idMidia"));

        if (null != acao) switch (acao) {
            case "avaliar" -> {
                int nota = Integer.parseInt(request.getParameter("nota"));
                String comentario = request.getParameter("comentario");
                interacaoDAO.adicionarAvaliacao(usuario.getId(), idMidia, nota, comentario);
                
                // === TOAST DE AVALIAÇÃO ===
                session.setAttribute("mensagemToast", "Avaliação enviada com sucesso!");
            }
            case "lista" -> {
                String status = request.getParameter("status"); // JA_ASSISTI ou QUERO_ASSISTIR
                interacaoDAO.adicionarALista(usuario.getId(), idMidia, status);
                
                // === TOAST DE LISTA ===
                session.setAttribute("mensagemToast", "Filme adicionado à sua lista!");
            }
            case "excluirComentario" -> {
                // A trava dupla continua APENAS para essa ação, confirmando se o logado é ADMIN
                if ("ADMIN".equals(usuario.getPerfil())) {
                    int idAvaliacao = Integer.parseInt(request.getParameter("idAvaliacao"));
                    interacaoDAO.excluirAvaliacao(idAvaliacao);
                    
                    // === TOAST DE EXCLUSÃO ===
                    session.setAttribute("mensagemToast", "Comentário excluído com sucesso!");
                }
            }
            default -> {
            }
        }
        
        // Redireciona de volta para a mesma página para ver a atualização
        response.sendRedirect("detalhes?id=" + idMidia);
    }
}