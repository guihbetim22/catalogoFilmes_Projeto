package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Avaliacao;
import model.ItemMidia;

public class InteracaoDAO {
    private final String url = "jdbc:mysql://localhost:3306/catalogo_filmes";
    private final String user = "java_user";
    private final String password = "Filmes@2002"; // Coloque a senha do banco aqui!

    private Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver não encontrado", e);
        }
    }

    // 1. Salva a nota e o comentário no banco
    public void adicionarAvaliacao(int idUsuario, int idMidia, int nota, String comentario) {
        String sql = "INSERT INTO avaliacoes (id_usuario, id_midia, nota, comentario) VALUES (?, ?, ?, ?)";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idMidia);
            stmt.setInt(3, nota);
            stmt.setString(4, comentario);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao avaliar: " + e.getMessage());
        }
    }

    // 2. Busca todos os comentários de um filme específico
    public List<Avaliacao> listarAvaliacoes(int idMidia) {
        List<Avaliacao> avaliacoes = new ArrayList<>();
        // MUDANÇA AQUI: Adicionei 'a.id' no SELECT para o botão do Admin saber qual comentário excluir
        String sql = "SELECT a.id, u.nome, a.nota, a.comentario, a.data_avaliacao FROM avaliacoes a JOIN usuarios u ON a.id_usuario = u.id WHERE a.id_midia = ? ORDER BY a.data_avaliacao DESC";
        
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idMidia);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Avaliacao av = new Avaliacao();
                    // MUDANÇA AQUI: Setando o ID resgatado do banco
                    av.setId(rs.getInt("id")); 
                    av.setNomeUsuario(rs.getString("nome"));
                    av.setNota(rs.getInt("nota"));
                    av.setComentario(rs.getString("comentario"));
                    av.setDataAvaliacao(rs.getString("data_avaliacao"));
                    avaliacoes.add(av);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar avaliações: " + e.getMessage());
        }
        return avaliacoes;
    }

    // 3. O banco de dados calcula a média geral das estrelas sozinho
    public double obterMediaEstrelas(int idMidia) {
        String sql = "SELECT AVG(nota) as media FROM avaliacoes WHERE id_midia = ?";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idMidia);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("media");
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao calcular média: " + e.getMessage());
        }
        return 0.0;
    }

    // 4. Adiciona o filme na lista "Já Assisti" ou "Quero Assistir"
    public void adicionarALista(int idUsuario, int idMidia, String status) {
        // Usa REPLACE INTO para atualizar caso o usuário mude de "Quero Assistir" para "Já Assisti"
        String sql = "REPLACE INTO listas_pessoais (id, id_usuario, id_midia, status_lista) VALUES ((SELECT id FROM listas_pessoais WHERE id_usuario = ? AND id_midia = ? LIMIT 1), ?, ?, ?)";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idMidia);
            stmt.setInt(3, idUsuario);
            stmt.setInt(4, idMidia);
            stmt.setString(5, status);
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Fallback simples se o REPLACE falhar por estrutura
            try {
                String sqlInsert = "INSERT INTO listas_pessoais (id_usuario, id_midia, status_lista) VALUES (?, ?, ?)";
                try (Connection conn2 = conectar(); PreparedStatement stmt2 = conn2.prepareStatement(sqlInsert)) {
                    stmt2.setInt(1, idUsuario);
                    stmt2.setInt(2, idMidia);
                    stmt2.setString(3, status);
                    stmt2.executeUpdate();
                }
            } catch (SQLException ex) {
                 System.err.println("Erro ao adicionar à lista: " + ex.getMessage());
            }
        }
    }
    
    // 5. Busca os filmes de uma lista específica do usuário
    public List<ItemMidia> listarMinhasMidias(int idUsuario, String status) {
        List<ItemMidia> lista = new ArrayList<>();
        // Faz um JOIN para pegar os dados do filme que estão atrelados ao ID do usuário na tabela de listas
        String sql = "SELECT m.* FROM item_midia m JOIN listas_pessoais l ON m.id = l.id_midia WHERE l.id_usuario = ? AND l.status_lista = ?";
        
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            stmt.setString(2, status);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ItemMidia item = new ItemMidia();
                    item.setId(rs.getInt("id"));
                    item.setTitulo(rs.getString("titulo"));
                    item.setAutorDiretor(rs.getString("autor_diretor"));
                    item.setAnoLancamento(rs.getInt("ano_lancamento"));
                    item.setGenero(rs.getString("genero"));
                    item.setTipoMidia(rs.getString("tipo_midia"));
                    item.setPosterUrl(rs.getString("poster_url"));
                    lista.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao listar minha lista: " + e.getMessage());
        }
        return lista;
    }
    
    // 6. Remove da lista pessoal
    public void removerDaLista(int idUsuario, int idMidia) {
        String sql = "DELETE FROM listas_pessoais WHERE id_usuario = ? AND id_midia = ?";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            stmt.setInt(2, idMidia);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao remover da lista: " + e.getMessage());
        }
    }

    // ==========================================
    // 7. NOVO: Método para o Admin excluir uma avaliação
    // ==========================================
    public void excluirAvaliacao(int idAvaliacao) {
        String sql = "DELETE FROM avaliacoes WHERE id = ?";
        
        try (Connection conn = conectar(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, idAvaliacao);
            stmt.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Erro ao excluir comentário: " + e.getMessage());
        }
    }
}