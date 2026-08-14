package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Usuario;

public class UsuarioDAO {
    private final String url = "jdbc:mysql://localhost:3306/catalogo_filmes";
    private final String user = "seu_usuario_mysql"; // Coloque o usuário do banco aqui!
    private final String password = "sua_senha_mysql"; // Coloque a senha do banco aqui!

    private Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver não encontrado", e);
        }
    }

    public boolean cadastrar(Usuario u) {
        String sql = "INSERT INTO usuarios (nome, email, senha) VALUES (?, ?, ?)";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, u.getNome());
            stmt.setString(2, u.getEmail());
            stmt.setString(3, u.getSenha()); // Em projetos comerciais, a senha receberia um Hash aqui
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.err.println("Erro ao cadastrar usuário: " + e.getMessage());
            return false;
        }
    }

    public Usuario autenticar(String email, String senha) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ?";
        try (Connection conn = conectar(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, senha);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNome(rs.getString("nome"));
                    u.setEmail(rs.getString("email"));
                    u.setSenha(rs.getString("senha"));
                    u.setPerfil(rs.getString("perfil"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erro ao autenticar: " + e.getMessage());
        }
        return null; // Retorna nulo se o usuário não for encontrado
    }

    // ==========================================
    // MÉTODOS NOVOS ADICIONADOS ABAIXO
    // ==========================================

    // 1. Método para listar todos os usuários na tela do Admin
    public List<Usuario> listarTodosUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY nome";
        
        try (Connection conn = conectar(); 
             PreparedStatement stmt = conn.prepareStatement(sql); 
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                u.setPerfil(rs.getString("perfil"));
                lista.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao listar usuários: " + e.getMessage());
        }
        return lista;
    }

    // 2. Método para o Admin excluir um usuário (e todas as interações dele)
    public void excluirUsuario(int idUsuario) {
        try (Connection conn = conectar()) {
            
            // 1º Passo: Deletar as listas pessoais do usuário
            String sqlListas = "DELETE FROM listas_pessoais WHERE id_usuario = ?";
            try(PreparedStatement stmt = conn.prepareStatement(sqlListas)) {
                stmt.setInt(1, idUsuario);
                stmt.executeUpdate();
            }
            
            // 2º Passo: Deletar as avaliações do usuário
            String sqlAvaliacoes = "DELETE FROM avaliacoes WHERE id_usuario = ?";
            try(PreparedStatement stmt = conn.prepareStatement(sqlAvaliacoes)) {
                stmt.setInt(1, idUsuario);
                stmt.executeUpdate();
            }
            
            // 3º Passo: Finalmente, deletar o usuário
            String sqlUsuario = "DELETE FROM usuarios WHERE id = ?";
            try(PreparedStatement stmt = conn.prepareStatement(sqlUsuario)) {
                stmt.setInt(1, idUsuario);
                stmt.executeUpdate();
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao excluir usuário: " + e.getMessage());
        }
    }
}