# 🎬 Catálogo de Filmes

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![JSP/Servlets](https://img.shields.io/badge/JSP_/_Servlets-007396?style=for-the-badge&logo=java&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

Uma aplicação web Full-Stack desenvolvida para o gerenciamento e interação com mídias (filmes e séries). 
O projeto foca em entregar uma experiência de usuário (UX) premium, 
inspirada em grandes plataformas de streaming, com arquitetura robusta e segura no back-end.


Desenvolvido por Guilherme Mendes Betim como projeto de portfólio e avaliação acadêmica.

## ✨ Funcionalidades em Destaque

*   **UI/UX Premium e Dark Mode:** Interface responsiva com adaptação nativa para modo claro e escuro, utilizando CSS puro e variáveis de ambiente.
*   **Controle de Acesso (Autenticação):** Sistema de login seguro com separação de privilégios entre **Usuários** (interação com o catálogo) e **Administradores** (dashboard de gestão e exclusão de comentários/usuários).
*   **Interatividade Pessoal:** Usuários podem classificar filmes em listas personalizadas ("Já Assisti" e "Quero Assistir") e deixar avaliações (notas de 1 a 5) com comentários.
*   **Gestão de Catálogo:** Adição de novos títulos ao banco de dados com suporte a integração via API (TMDB) ou cadastro manual.

## 🛠️ Arquitetura e Tecnologias

O projeto foi construído aplicando boas práticas de Engenharia de Software, utilizando:

*   **Linguagem & Back-end:** Java (Servlets, JSP e JSTL).
*   **Padrões de Projeto:** **MVC** (Model-View-Controller) para separação de responsabilidades lógicas e visuais, e **DAO** (Data Access Object) para abstração da persistência de dados.
*   **Banco de Dados:** SQL relacional gerenciado via JDBC.
*   **Front-end:** HTML5, CSS3 avançado (Flexbox, Grid, animações, keyframes e custom properties).

## 🚀 Como Executar o Projeto

**Pré-requisitos:**
*   Java Development Kit (JDK) 11 ou superior.
*   Servidor Apache Tomcat (versão 9 ou 10).
*   Banco de Dados SQL (MySQL/PostgreSQL) rodando localmente.

**Passo a Passo:**
1. Faça o clone do repositório:
   ```bash
   git clone [https://github.com/guihbetim22/catalogoFilmes_Projeto.git]

2. Importe o banco de dados utilizando o script catalago_filmes.sql localizado na pasta /database.

3. Configure as credenciais de banco de dados (usuário e senha) nos arquivos da pasta DAO (ou arquivo de propriedades, se aplicável).

4. Adicione o projeto na sua IDE (Eclipse, IntelliJ ou VS Code) configurada com o Tomcat.

5. Inicie o servidor e acesse http://localhost:8080/catalogoFilmes_Projeto.