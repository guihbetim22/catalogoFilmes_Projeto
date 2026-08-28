/**
 * Classe de domínio que representa a entidade de mídia (Filme ou Série) no catálogo.
 * Atua como o "Model" na arquitetura MVC, sendo responsável por encapsular os atributos
 * específicos de cada título, como nome, gênero, duração, diretor e ano de lançamento.
 * Facilita o tráfego seguro dessas informações entre a interface de usuário (JSP) 
 * e a camada de persistência (DAO).
 * 
 * @author Guilherme Mendes Betim
 * @version 1.0
 * @since 2026
 */

package model;

public class ItemMidia {
    
    private String titulo;
    private String autorDiretor;
    private String genero;
    private String sinopse;
    private String tipoMidia;
    private String posterUrl;
    private int anoLancamento;
    private int duracao;
    private int id;

    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }

    public int getDuracao(){ 
        return duracao; }

    public ItemMidia() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getAutorDiretor() { return autorDiretor; }
    public void setAutorDiretor(String autorDiretor) { this.autorDiretor = autorDiretor; }
    public int getAnoLancamento() { return anoLancamento; }
    public void setAnoLancamento(int anoLancamento) { this.anoLancamento = anoLancamento; }
    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }
    public String getSinopse() { return sinopse; }
    public void setSinopse(String sinopse) { this.sinopse = sinopse; }
    public String getTipoMidia() { return tipoMidia; }
    public void setTipoMidia(String tipoMidia) { this.tipoMidia = tipoMidia; }
    public void setDuracao(int duracao) { this.duracao = duracao; }
    }
