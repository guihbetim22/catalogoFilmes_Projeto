/**
 * Controlador (Servlet) encarregado de gerenciar as requisições HTTP relacionadas ao catálogo de mídias.
 * Intercepta as chamadas vindas do front-end (como formulários de cadastro ou edição de filmes),
 * coordena a validação dos dados recebidos, aciona o ItemMidiaDAO para a devida persistência no banco 
 * e gerencia o redirecionamento do fluxo de navegação do usuário para a view (JSP) apropriada.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 */

package controller;

import java.io.IOException;
import java.util.List;

import com.google.gson.JsonSyntaxException;

import dao.ItemMidiaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ItemMidia;

@WebServlet("/filmes")
public class ItemMidiaServlet extends HttpServlet {
    private ItemMidiaDAO dao;

    @Override
    public void init() {
        dao = new ItemMidiaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao"); 
        String busca = request.getParameter("busca"); 
        
        // Captura os parâmetros dos novos botões de filtro
        String filtro = request.getParameter("filtro"); 
        String valorFiltro = request.getParameter("valor"); 
        
        if ("excluir".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.excluir(id);
            
            // === TOAST DE EXCLUSÃO ===
            request.getSession().setAttribute("mensagemToast", "Filme excluído do catálogo!");
            
            response.sendRedirect("filmes");
            return;
        }

        List<ItemMidia> listaFilmes;
        
        // Prioridade 1: Barra de Pesquisa
        if (busca != null && !busca.trim().isEmpty()) {
            listaFilmes = dao.buscarPorTitulo(busca);
        } 
        // Prioridade 2: Botões de Filtro
        else if (filtro != null && valorFiltro != null && !valorFiltro.trim().isEmpty()) {
            listaFilmes = dao.buscarPorFiltro(filtro, valorFiltro);
        } 
        // Padrão: Catálogo Completo (COM PAGINAÇÃO)
        else {
            int paginaAtual = 1; 
            if (request.getParameter("pagina") != null) {
                paginaAtual = Integer.parseInt(request.getParameter("pagina"));
            }

            int limite = 10; // Mostra 10 filmes por página
            int offset = (paginaAtual - 1) * limite; 

            listaFilmes = dao.listarComPaginacao(limite, offset);
            
            // Calcula o total de páginas
            int totalFilmes = dao.contarTotalFilmes();
            int totalPaginas = (int) Math.ceil((double) totalFilmes / limite);

            // Envia para o JSP desenhar os botões 1, 2, 3...
            request.setAttribute("paginaAtual", paginaAtual);
            request.setAttribute("totalPaginas", totalPaginas);
        }

        // Enviamos o valor do filtro de volta para a tela para pintar o botão selecionado
        request.setAttribute("filtroAtual", filtro);
        request.setAttribute("valorFiltroAtual", valorFiltro);
        
        request.setAttribute("listaFilmes", listaFilmes);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    @Override
    @SuppressWarnings("CallToPrintStackTrace")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // === SEGURANÇA GARANTIDA PELO FILTRO ===
        // O FiltroAutenticacao já bloqueou qualquer usuário que não seja ADMIN de chegar neste POST.

        String acao = request.getParameter("acao");
        HttpSession session = request.getSession();
        
        // =======================================================
        // CENÁRIO 1: BUSCA AUTOMÁTICA PELA API DO TMDB
        // =======================================================
        if ("buscarTmdb".equals(acao)) {
            String nomeBusca = request.getParameter("nomeFilme");
            try {
                String jwtToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ODgwMGYwNmY3MDJiZDIxNzU0MWIzZDNmMjA3YTJmZiIsIm5iZiI6MTc4NjQ3OTEwMC44NTY5OTk5LCJzdWIiOiI2YTdiODFmYzVlOTU1MDY2OTNmOGYwZTgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.VaVgAVBEqwppc04yjGUO-IRzKs92LCLi1XQvBkDHIl0"; 
                String query = java.net.URLEncoder.encode(nomeBusca, java.nio.charset.StandardCharsets.UTF_8);
                
                String searchUrl = "https://api.themoviedb.org/3/search/movie?query=" + query + "&language=pt-BR";

                java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
                java.net.http.HttpRequest searchReq = java.net.http.HttpRequest.newBuilder()
                        .uri(java.net.URI.create(searchUrl))
                        .header("accept", "application/json")
                        .header("Authorization", "Bearer " + jwtToken)
                        .build();
                        
                java.net.http.HttpResponse<String> searchResp = client.send(searchReq, java.net.http.HttpResponse.BodyHandlers.ofString());
                com.google.gson.JsonObject searchJson = com.google.gson.JsonParser.parseString(searchResp.body()).getAsJsonObject();
                com.google.gson.JsonArray results = searchJson.getAsJsonArray("results");

                if (results.size() > 0) {
                    int tmdbId = results.get(0).getAsJsonObject().get("id").getAsInt();

                    String detailsUrl = "https://api.themoviedb.org/3/movie/" + tmdbId + "?language=pt-BR&append_to_response=credits";
                    java.net.http.HttpRequest detailsReq = java.net.http.HttpRequest.newBuilder()
                            .uri(java.net.URI.create(detailsUrl))
                            .header("accept", "application/json")
                            .header("Authorization", "Bearer " + jwtToken)
                            .build();
                            
                    java.net.http.HttpResponse<String> detailsResp = client.send(detailsReq, java.net.http.HttpResponse.BodyHandlers.ofString());
                    com.google.gson.JsonObject filmeDetalhes = com.google.gson.JsonParser.parseString(detailsResp.body()).getAsJsonObject();

                    ItemMidia item = new ItemMidia();
                    item.setTitulo(filmeDetalhes.has("title") ? filmeDetalhes.get("title").getAsString() : "Sem Título");
                    
                    String dataLancamento = filmeDetalhes.has("release_date") ? filmeDetalhes.get("release_date").getAsString() : "0000";
                    item.setAnoLancamento(dataLancamento.length() >= 4 ? Integer.parseInt(dataLancamento.substring(0, 4)) : 0);
                    item.setSinopse(filmeDetalhes.has("overview") ? filmeDetalhes.get("overview").getAsString() : "Sem sinopse.");
                    
                    if (filmeDetalhes.has("poster_path") && !filmeDetalhes.get("poster_path").isJsonNull()) {
                        item.setPosterUrl("https://image.tmdb.org/t/p/w200" + filmeDetalhes.get("poster_path").getAsString());
                    }
                    item.setTipoMidia("Filme");

                    int duracaoTmdb = 0;
                    if (filmeDetalhes.has("runtime") && !filmeDetalhes.get("runtime").isJsonNull()) {
                        duracaoTmdb = filmeDetalhes.get("runtime").getAsInt();
                    }
                    item.setDuracao(duracaoTmdb);

                    String genero = "N/A";
                    if (filmeDetalhes.has("genres") && filmeDetalhes.getAsJsonArray("genres").size() > 0) {
                        genero = filmeDetalhes.getAsJsonArray("genres").get(0).getAsJsonObject().get("name").getAsString();
                    }
                    item.setGenero(genero);

                    String diretor = "N/A";
                    if (filmeDetalhes.has("credits")) {
                        com.google.gson.JsonArray crew = filmeDetalhes.getAsJsonObject("credits").getAsJsonArray("crew");
                        for (int i = 0; i < crew.size(); i++) {
                            com.google.gson.JsonObject membro = crew.get(i).getAsJsonObject();
                            if ("Director".equals(membro.get("job").getAsString())) {
                                diretor = membro.get("name").getAsString();
                                break;
                            }
                        }
                    }
                    item.setAutorDiretor(diretor);

                    dao.inserir(item); 
                    
                    // === TOAST DE IMPORTAÇÃO TMDB ===
                    session.setAttribute("mensagemToast", "Filme importado com sucesso!");
                }
            } catch (JsonSyntaxException | IOException | InterruptedException | NumberFormatException e) {
                e.printStackTrace();
            }
            response.sendRedirect("filmes");
            return;
        }

        // =======================================================
        // CENÁRIO 2: CADASTRO MANUAL (FORMULÁRIO)
        // =======================================================
        String titulo = request.getParameter("titulo");
        String autorDiretor = request.getParameter("autorDiretor");
        
        int ano = 0;
        String paramAno = request.getParameter("anoLancamento");
        if (paramAno != null && !paramAno.isEmpty()) {
            ano = Integer.parseInt(paramAno);
        }
        
        int duracaoManual = 0;
        String paramDuracao = request.getParameter("duracao");
        if (paramDuracao != null && !paramDuracao.isEmpty()) {
            duracaoManual = Integer.parseInt(paramDuracao);
        }
        
        String genero = request.getParameter("genero");
        String sinopse = request.getParameter("sinopse");
        String tipo = request.getParameter("tipoMidia");
        String posterUrl = request.getParameter("posterUrl"); 

        ItemMidia item = new ItemMidia();
        item.setTitulo(titulo);
        item.setAutorDiretor(autorDiretor);
        item.setAnoLancamento(ano);
        item.setDuracao(duracaoManual); 
        item.setGenero(genero);
        item.setSinopse(sinopse);
        item.setTipoMidia(tipo);
        item.setPosterUrl(posterUrl != null && !posterUrl.isEmpty() ? posterUrl : null); 

        dao.inserir(item); 
        
        // === TOAST DE CADASTRO MANUAL ===
        session.setAttribute("mensagemToast", "Filme cadastrado com sucesso!");
        
        response.sendRedirect("filmes");
    }
}