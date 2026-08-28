/**
 * Controlador (Servlet) exclusivo para a área administrativa.
 * Gerencia as requisições de visualização, edição de permissões e exclusão 
 * de contas de usuários do sistema, exigindo privilégios elevados de acesso.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 */

package controller;

import java.io.IOException;
import java.util.List;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

@WebServlet("/admin-usuarios")
public class AdminUsuariosServlet extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // NÃO PRECISA MAIS CHECAR SE É NULL OU ADMIN AQUI! O Filtro já garantiu isso.
        
        List<Usuario> usuarios = usuarioDAO.listarTodosUsuarios();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("adminUsuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario admin = (Usuario) session.getAttribute("usuarioLogado");

        // A checagem de null e de perfil ADMIN já foi garantida pelo FiltroAutenticacao!
        String acao = request.getParameter("acao");
        
        if ("excluir".equals(acao)) {
            int idExcluir = Integer.parseInt(request.getParameter("idUsuario"));
            
            // Impede que o Admin exclua a própria conta
            if (idExcluir != admin.getId()) {
                usuarioDAO.excluirUsuario(idExcluir);
                
                // === DISPARANDO O TOAST DE SUCESSO ===
                session.setAttribute("mensagemToast", "Usuário excluído com sucesso!");
            } else {
                // === DISPARANDO O TOAST DE AVISO ===
                session.setAttribute("mensagemToast", "Você não pode excluir sua própria conta!");
            }
        }
        
        response.sendRedirect("admin-usuarios");
    }
}