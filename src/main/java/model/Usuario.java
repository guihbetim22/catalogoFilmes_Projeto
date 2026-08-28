/**
 * Classe de domínio que representa os usuários do sistema.
 * Armazena as credenciais de acesso, informações pessoais e o perfil de autorização 
 * (como ADMIN ou USER), sendo fundamental para o controle de acesso e gestão de sessão.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 * @since 2026
 */

package model;

public class Usuario {
    private int id;
    private String nome;
    private String email;
    private String senha;
    private String perfil;

    public Usuario() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getSenha() { return senha; }
    public void setSenha(String senha) { this.senha = senha; }

    public String getPerfil() { return perfil; }
    public void setPerfil(String perfil) { this.perfil = perfil; }
}