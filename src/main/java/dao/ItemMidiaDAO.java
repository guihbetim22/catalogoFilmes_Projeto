package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ItemMidia;

public class ItemMidiaDAO {
    private final String url = "jdbc:mysql://localhost:3306/catalogo_filmes";
    private final String user = "java_user"; // Coloque o usuário do banco aqui!
    private final String password = "Filmes@2002"; // Coloque a senha do banco aqui!

    private Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver não encontrado", e);
        }
    }

    public void inserir(ItemMidia item) {
        String sql = "INSERT INTO item_midia (titulo, autor_diretor, ano_lancamento, genero, sinopse, tipo_midia, poster_url, duracao) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getTitulo());
            stmt.setString(2, item.getAutorDiretor());
            stmt.setInt(3, item.getAnoLancamento());
            stmt.setString(4, item.getGenero());
            stmt.setString(5, item.getSinopse());
            stmt.setString(6, item.getTipoMidia());
            stmt.setString(7, item.getPosterUrl());
            stmt.setInt(8, item.getDuracao());
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao cadastrar filme: " + e.getMessage());
        }
    }

    public List<ItemMidia> listarTodos() {
        List<ItemMidia> lista = new ArrayList<>();
        String sql = "SELECT * FROM item_midia";
        try (Connection conn = conectar(); 
             PreparedStatement stmt = conn.prepareStatement(sql); 
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ItemMidia item = new ItemMidia();
                item.setId(rs.getInt("id"));
                item.setTitulo(rs.getString("titulo"));
                item.setAutorDiretor(rs.getString("autor_diretor"));
                item.setAnoLancamento(rs.getInt("ano_lancamento"));
                item.setGenero(rs.getString("genero"));
                item.setSinopse(rs.getString("sinopse"));
                item.setTipoMidia(rs.getString("tipo_midia"));
                item.setPosterUrl(rs.getString("poster_url"));
                item.setDuracao(rs.getInt("duracao"));
                lista.add(item);
            }
        } catch (SQLException e) {
             System.err.println("Erro ao listar filmes: " + e.getMessage());
        }   
        return lista;   
    }
    public void excluir(int id) {
        String sql = "DELETE FROM item_midia WHERE id = ?";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Erro ao excluir filme: " + e.getMessage());
        }
    }
    public ItemMidia buscarPorId(int id) {
        String sql = "SELECT * FROM item_midia WHERE id = ?";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ItemMidia item = new ItemMidia();
                    item.setId(rs.getInt("id"));
                    item.setTitulo(rs.getString("titulo"));
                    item.setAutorDiretor(rs.getString("autor_diretor"));
                    item.setAnoLancamento(rs.getInt("ano_lancamento"));
                    item.setGenero(rs.getString("genero"));
                    item.setSinopse(rs.getString("sinopse"));
                    item.setTipoMidia(rs.getString("tipo_midia"));
                    item.setPosterUrl(rs.getString("poster_url"));
                    item.setDuracao(rs.getInt("duracao"));
                    return item;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar filme por ID: " + e.getMessage());
        }
        return null;
    }
    public List<ItemMidia> buscarPorTitulo(String tituloBusca) {
        List<ItemMidia> lista = new ArrayList<>();
        // O LIKE com % permite buscar partes da palavra. Tabela corrigida para 'item_midia'
        String sql = "SELECT * FROM item_midia WHERE titulo LIKE ?";
        
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, "%" + tituloBusca + "%");
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ItemMidia item = new ItemMidia();
                    // Pegando todas as colunas exatamente como no método listarTodos()
                    item.setId(rs.getInt("id"));
                    item.setTitulo(rs.getString("titulo"));
                    item.setAutorDiretor(rs.getString("autor_diretor"));
                    item.setAnoLancamento(rs.getInt("ano_lancamento"));
                    item.setGenero(rs.getString("genero"));
                    item.setSinopse(rs.getString("sinopse"));
                    item.setTipoMidia(rs.getString("tipo_midia"));
                    item.setPosterUrl(rs.getString("poster_url"));
                    item.setDuracao(rs.getInt("duracao"));
                    
                    lista.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar filme por título: " + e.getMessage());
        }
        return lista;
    }
    public List<ItemMidia> buscarPorFiltro(String coluna, String valor) {
        List<ItemMidia> lista = new ArrayList<>();
        String sql = "";

        // Define a query dependendo do filtro selecionado
        if ("genero".equals(coluna)) {
            sql = "SELECT * FROM item_midia WHERE genero LIKE ?";
        } else if ("ano".equals(coluna)) {
            sql = "SELECT * FROM item_midia WHERE ano_lancamento = ?";
        } else {
            return listarTodos();
        }

        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            if ("ano".equals(coluna)) {
                stmt.setInt(1, Integer.parseInt(valor));
            } else {
                stmt.setString(1, "%" + valor + "%");
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ItemMidia item = new ItemMidia();
                    item.setId(rs.getInt("id"));
                    item.setTitulo(rs.getString("titulo"));
                    item.setAutorDiretor(rs.getString("autor_diretor"));
                    item.setAnoLancamento(rs.getInt("ano_lancamento"));
                    item.setGenero(rs.getString("genero"));
                    item.setSinopse(rs.getString("sinopse"));
                    item.setTipoMidia(rs.getString("tipo_midia"));
                    item.setPosterUrl(rs.getString("poster_url"));
                    item.setDuracao(rs.getInt("duracao"));
                    
                    lista.add(item);
                }
            }
        } catch (SQLException | NumberFormatException e) {
            System.err.println("Erro ao buscar por filtro: " + e.getMessage());
        }
        return lista;
    }
}
