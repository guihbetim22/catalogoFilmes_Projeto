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
        // === BLOQUEIO REMOVIDO ===
        // Agora, qualquer visitante pode acessar a página de detalhes para ver o filme e os comentários!

        int idMidia = Integer.parseInt(request.getParameter("id"));
        
        ItemMidia filme = midiaDAO.buscarPorId(idMidia); 
        List<Avaliacao> avaliacoes = interacaoDAO.listarAvaliacoes(idMidia);
        double media = interacaoDAO.obterMediaEstrelas(idMidia);

        request.setAttribute("filme", filme);
        
        // Ajustado para "avaliacoes" para combinar com o HTML do detalhes.jsp
        request.setAttribute("avaliacoes", avaliacoes); 
        request.setAttribute("media", String.format("%.1f", media)); // Formata para 1 casa decimal

        request.getRequestDispatcher("detalhes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // === BLOQUEIO MANTIDO ===
        // A segurança continua ativa aqui! Só quem está logado pode enviar comentários ou adicionar à lista.
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        
        if (usuario == null) {
            String mensagem = java.net.URLEncoder.encode("Faça o login para interagir com o catálogo.", "UTF-8");
            response.sendRedirect("login.jsp?erro=" + mensagem);
            return;
        }

        String acao = request.getParameter("acao");
        int idMidia = Integer.parseInt(request.getParameter("idMidia"));

        if (null != acao) switch (acao) {
            case "avaliar" -> {
                int nota = Integer.parseInt(request.getParameter("nota"));
                String comentario = request.getParameter("comentario");
                interacaoDAO.adicionarAvaliacao(usuario.getId(), idMidia, nota, comentario);
            }
            case "lista" -> {
                String status = request.getParameter("status"); // JA_ASSISTI ou QUERO_ASSISTIR
                interacaoDAO.adicionarALista(usuario.getId(), idMidia, status);
            }
            case "excluirComentario" -> {
                // === NOVO: Trava de segurança dupla para exclusão ===
                // Confirma no back-end se quem mandou a requisição realmente é o ADMIN
                if ("ADMIN".equals(usuario.getPerfil())) {
                    int idAvaliacao = Integer.parseInt(request.getParameter("idAvaliacao"));
                    interacaoDAO.excluirAvaliacao(idAvaliacao);
                }
            }
            default -> {
            }
        }
        
        // Redireciona de volta para a mesma página para ver a atualização
        response.sendRedirect("detalhes?id=" + idMidia);
    }
}