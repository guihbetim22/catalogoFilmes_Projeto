/**
 * Classe de domínio que representa a interação de notas e comentários da comunidade.
 * Relaciona um Usuário a um ItemMidia, permitindo o tráfego de dados sobre 
 * o engajamento e a opinião do público sobre os filmes e séries do catálogo.
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 * @since 2026
 */

package model;

public class Avaliacao {
    private String nomeUsuario; // Nome de quem comentou
    private int nota;
    private String comentario;
    private String dataAvaliacao;
    private int id;

    public Avaliacao() {}

    public String getNomeUsuario() { return nomeUsuario; }
    public void setNomeUsuario(String nomeUsuario) { this.nomeUsuario = nomeUsuario; }

    public int getNota() { return nota; }
    public void setNota(int nota) { this.nota = nota; }

    public String getComentario() { return comentario; }
    public void setComentario(String comentario) { this.comentario = comentario; }

    public String getDataAvaliacao() { return dataAvaliacao; }
    public void setDataAvaliacao(String dataAvaliacao) { this.dataAvaliacao = dataAvaliacao; }

    public int getId() {return id;}
    public void setId(int id) {this.id = id;}

}