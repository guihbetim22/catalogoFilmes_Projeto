package controller;

import java.io.IOException;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

@WebServlet("/login")
public class UsuarioServlet extends HttpServlet {
    private UsuarioDAO dao;

    @Override
    public void init() {
        dao = new UsuarioDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        
        // Lógica de Logout (Sair da conta)
        if ("sair".equals(acao)) {
            HttpSession session = request.getSession();
            session.invalidate(); // Destrói a sessão atual
            response.sendRedirect("login.jsp");
            return;
        }
        
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("cadastrar".equals(acao)) {
            Usuario u = new Usuario();
            u.setNome(request.getParameter("nome"));
            u.setEmail(request.getParameter("email"));
            u.setSenha(request.getParameter("senha"));
            
            if (dao.cadastrar(u)) {
                response.sendRedirect("login.jsp?msg=Cadastro realizado! Faca login para continuar.");
            } else {
                response.sendRedirect("login.jsp?erro=Erro ao cadastrar. E-mail ja existente.");
            }
            
        } else if ("entrar".equals(acao)) {
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            Usuario u = dao.autenticar(email, senha);

            if (u != null) {
                // Inicia a Sessão e guarda o usuário logado
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogado", u);
                response.sendRedirect("filmes"); // Vai direto para o catálogo
            } else {
                response.sendRedirect("login.jsp?erro=E-mail ou senha invalidos.");
            }
        }
    }
}