<div align="center">

![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-4479A1.svg?style=for-the-badge&logo=mysql&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)

<br>

# 🎬 Catálogo de Filmes

Um sistema web completo para gerenciamento de catálogo de filmes, avaliações da comunidade e listas pessoais, desenvolvido com Java e arquitetura MVC.

## 🚀 Tecnologias Utilizadas
* **Back-end:** Java, Jakarta EE (Servlets)
* **Front-end:** JSP, JSTL, HTML, CSS (Modo Escuro nativo)
* **Banco de Dados:** MySQL (Padrão DAO)
* **Gerenciamento de Dependências:** Maven
* **Servidor de Aplicação:** Apache Tomcat (v10+)

## ⚙️ Pré-requisitos
Antes de começar, certifique-se de ter instalado em sua máquina:
* [Java JDK 11+](https://www.oracle.com/java/technologies/downloads/)
* [Maven](https://maven.apache.org/)
* [MySQL Server](https://dev.mysql.com/downloads/)
* [Apache Tomcat](https://tomcat.apache.org/)

## 🗄️ Configuração do Banco de Dados
1. Abra o seu gerenciador do MySQL (Workbench, DBeaver, etc.).
2. Crie uma nova conexão ou utilize uma existente.
3. Localize o script de criação do banco na pasta do projeto:
   `database/catalogo_filmes.sql`
4. Execute o script no seu MySQL. Ele criará automaticamente o banco de dados `catalogo_filmes`, todas as tabelas (usuários, mídias, avaliações, listas) e a estrutura necessária.

## 🔐 Configuração do Projeto
1. Clone este repositório para a sua máquina:
   ```bash
   git clone [https://github.com/guihbetim22/catalagoFilmes_Projeto.git](https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git)

## 💻 Como Executar o Projeto na IDE

Se você deseja rodar o projeto diretamente na sua IDE para testar e modificar o código em tempo real, siga as instruções abaixo de acordo com o seu ambiente:

### 🔹 Pré-requisito Geral
Certifique-se de que a pasta importada seja a raiz do projeto (onde está o arquivo `pom.xml`) para que a IDE reconheça as dependências do Maven e baixe tudo automaticamente.

### 🔵 Eclipse IDE (Mais tradicional para Java Web)
1. Vá em `File > Import > Maven > Existing Maven Projects` e selecione a pasta do projeto.
2. Na aba inferior, procure por **Servers**. Se não tiver, vá em `Window > Show View > Servers`.
3. Clique com o botão direito na aba Servers > `New > Server`.
4. Escolha **Apache > Tomcat v10.0** (ou a versão que você instalou) e aponte para a pasta onde o Tomcat está instalado no seu computador.
5. Adicione o projeto `catalogo_filmes` ao servidor.
6. Clique no botão de **Play** (Start) no servidor. O projeto estará rodando no seu `localhost`.

### 🟣 Visual Studio Code (VS Code)
1. Abra a pasta do projeto no VS Code.
2. Instale o pacote de extensões **Extension Pack for Java** da Microsoft.
3. Instale a extensão **Community Server Connectors** (desenvolvida pela Red Hat) para gerenciar o Tomcat.
4. Na barra lateral (Explorer), procure pela aba **SERVERS**.
5. Clique no ícone de `+` para adicionar um novo servidor, escolha o seu Tomcat local e aponte o diretório.
6. Clique com o botão direito no servidor adicionado e selecione `Add Deployment`. Escolha o arquivo `.war` gerado na pasta `target` (lembre-se de rodar o `mvn clean package` antes).
7. Clique com o botão direito no servidor e selecione `Start Server`.

### 🟠 IntelliJ IDEA
*Nota: A integração nativa com Tomcat exige a versão Ultimate, mas você pode usar o plugin "Smart Tomcat" na versão Community.*
1. Abra o projeto apontando para o arquivo `pom.xml`.
2. Vá em `Run > Edit Configurations`.
3. Clique no `+` e selecione **Smart Tomcat** (se instalou o plugin) ou **Tomcat Server > Local** (na versão Ultimate).
4. No campo **Tomcat server**, aponte para a instalação do Tomcat na sua máquina.
5. No campo **Deployment Directory**, aponte para a pasta `src/main/webapp`.
6. Aplique as configurações e clique no botão verde de **Play** no canto superior direito para iniciar a aplicação.