/**
 * Filtro de segurança interceptador de requisições (Interceptor).
 * Implementa a interface Filter para garantir que rotas protegidas da aplicação 
 * só sejam acessadas por usuários com sessões válidas e com os devidos privilégios.
 * Redireciona tentativas de acesso não autorizado para a página de login, 
 * prevenindo acessos diretos via URL a recursos e dashboards sensíveis do sistema.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 * @since 2026
 */

package filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

// Adicionamos o /filmes na vigilância
@WebFilter(urlPatterns = {"/minhas-listas", "/admin-usuarios", "/detalhes", "/filmes"})
public class FiltroAutenticacao implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
        
        String uri = req.getRequestURI();
        boolean isMetodoPost = req.getMethod().equalsIgnoreCase("POST");
        String acao = req.getParameter("acao");

        // Identifica ações restritas na rota de filmes
        boolean isAcaoExcluirFilme = uri.endsWith("/filmes") && "excluir".equals(acao);
        boolean isPostFilme = uri.endsWith("/filmes") && isMetodoPost;

        // 1. REGRA DE LOGIN: Verifica se a rota exige usuário logado
        boolean exigeLogin = uri.endsWith("/minhas-listas") || 
                             uri.endsWith("/admin-usuarios") || 
                             (uri.endsWith("/detalhes") && isMetodoPost) ||
                             isPostFilme ||
                             isAcaoExcluirFilme;

        if (exigeLogin && usuarioLogado == null) {
            String mensagem = java.net.URLEncoder.encode("Faça o login para interagir com o sistema.", "UTF-8");
            res.sendRedirect(req.getContextPath() + "/login.jsp?erro=" + mensagem);
            return;
        }

        // 2. CHECAGEM DE ADMIN (Autorização Específica)
        boolean exigeAdmin = uri.endsWith("/admin-usuarios") || isPostFilme || isAcaoExcluirFilme;
        
        if (exigeAdmin && (usuarioLogado == null || !"ADMIN".equals(usuarioLogado.getPerfil()))) {
            String mensagemAdmin = java.net.URLEncoder.encode("Acesso negado. Apenas Administradores.", "UTF-8");
            res.sendRedirect(req.getContextPath() + "/filmes?erro=" + mensagemAdmin);
            return;
        }

        // 3. TUDO CERTO! LIBERA A CATRACA
        chain.doFilter(request, response);
    }
}