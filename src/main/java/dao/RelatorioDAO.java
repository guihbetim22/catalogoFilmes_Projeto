/**
 * Data Access Object (DAO) focado em consultas analíticas e métricas do sistema.
 * Consolida dados estatísticos (como total de usuários, filmes mais bem avaliados) 
 * para alimentar o Dashboard gerencial exclusivo do perfil Administrador.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 */

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

public class RelatorioDAO {
    private final String url = "jdbc:mysql://localhost:3306/catalogo_filmes";
    private final String user = "user"; // Coloque o usuário do banco aqui!
    private final String password = "pass"; // Coloque a senha do banco aqui!

    private Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver não encontrado", e);
        }
    }

    // 1. Quantos usuários cadastrados existem?
    public int contarUsuariosAtivos() {
        String sql = "SELECT COUNT(*) AS total FROM usuarios";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.err.println("Erro ao contar usuários: " + e.getMessage());
        }
        return 0;
    }

    // 2. Quais são os 5 filmes com as melhores médias de avaliação?
    public Map<String, Double> obterTop5Filmes() {
        Map<String, Double> topFilmes = new LinkedHashMap<>();
        String sql = "SELECT m.titulo, AVG(a.nota) as media FROM item_midia m " +
                     "JOIN avaliacoes a ON m.id = a.id_midia " +
                     "GROUP BY m.id, m.titulo ORDER BY media DESC LIMIT 5";
        
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                topFilmes.put(rs.getString("titulo"), rs.getDouble("media"));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar top 5 filmes: " + e.getMessage());
        }
        return topFilmes;
    }

    // 3. Qual gênero é o mais adicionado nas listas dos usuários?
    public Map<String, Integer> obterGenerosMaisAdicionados() {
        Map<String, Integer> generos = new LinkedHashMap<>();
        String sql = "SELECT m.genero, COUNT(l.id_midia) as total FROM item_midia m " +
                     "JOIN listas_pessoais l ON m.id = l.id_midia " +
                     "GROUP BY m.genero ORDER BY total DESC";
        
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                generos.put(rs.getString("genero"), rs.getInt("total"));
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar gêneros populares: " + e.getMessage());
        }
        return generos;
    }
}