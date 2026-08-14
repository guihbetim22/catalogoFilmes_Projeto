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
        HttpSession session = request.getSession();
        Usuario admin = (Usuario) session.getAttribute("usuarioLogado");

        // Bloqueia o acesso se não estiver logado ou não for ADMIN
        if (admin == null || !"ADMIN".equals(admin.getPerfil())) {
            response.sendRedirect("filmes"); 
            return;
        }

        List<Usuario> usuarios = usuarioDAO.listarTodosUsuarios();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("adminUsuarios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario admin = (Usuario) session.getAttribute("usuarioLogado");

        // Trava dupla de segurança: Confirma no POST se é o ADMIN
        if (admin != null && "ADMIN".equals(admin.getPerfil())) {
            String acao = request.getParameter("acao");
            
            if ("excluir".equals(acao)) {
                int idExcluir = Integer.parseInt(request.getParameter("idUsuario"));
                
                // Impede que o Admin exclua a própria conta
                if (idExcluir != admin.getId()) {
                    usuarioDAO.excluirUsuario(idExcluir);
                }
            }
        }
        
        response.sendRedirect("admin-usuarios");
    }
}