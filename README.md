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