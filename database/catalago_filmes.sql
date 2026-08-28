-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: catalogo_filmes
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avaliacoes`
--

DROP TABLE IF EXISTS `avaliacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_midia` int NOT NULL,
  `nota` int DEFAULT NULL,
  `comentario` text,
  `data_avaliacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_midia` (`id_midia`),
  CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`id_midia`) REFERENCES `item_midia` (`id`) ON DELETE CASCADE,
  CONSTRAINT `avaliacoes_chk_1` CHECK (((`nota` >= 1) and (`nota` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacoes`
--

LOCK TABLES `avaliacoes` WRITE;
/*!40000 ALTER TABLE `avaliacoes` DISABLE KEYS */;
INSERT INTO `avaliacoes` VALUES (34,16,67,5,'top','2026-08-15 15:50:59'),(35,18,83,5,'melhor filme de zumbi, recomendo!','2026-08-15 16:32:15'),(36,18,84,5,'parece ser bom !','2026-08-15 16:32:44');
/*!40000 ALTER TABLE `avaliacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_midia`
--

DROP TABLE IF EXISTS `item_midia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_midia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `autor_diretor` varchar(255) DEFAULT NULL,
  `ano_lancamento` int DEFAULT NULL,
  `genero` varchar(100) DEFAULT NULL,
  `sinopse` text,
  `tipo_midia` varchar(50) NOT NULL,
  `poster_url` varchar(500) DEFAULT NULL,
  `duracao` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_midia`
--

LOCK TABLES `item_midia` WRITE;
/*!40000 ALTER TABLE `item_midia` DISABLE KEYS */;
INSERT INTO `item_midia` VALUES (67,'Gente Grande 2','Dennis Dugan',2013,'Comédia','Lenny Feder e sua família se mudam para sua cidade natal para ficar perto dos amigos, mas acabam tendo que enfrentar alguns fantasmas do passado, como a covardia diante de valentões e o famigerado bullying na escola.','Filme','https://image.tmdb.org/t/p/w200/fKYW0oKPvy6HF8x5egL1ljC36xb.jpg',101),(68,'Superbad: É Hoje','Greg Mottola',2007,'Comédia','Os estudantes adolescentes Seth e Evan têm grandes esperanças para uma festa de formatura. Os adolescentes co-dependentes pretendem beber e conquistar garotas para que eles possam se tornar parte da multidão popular da escola, mas a ansiedade de separação e dois policiais entediados complicam a auto-missão proclamada dos amigos.','Filme','https://image.tmdb.org/t/p/w200/rABcQMa8m67EJslknSlMfE3BP8L.jpg',113),(69,'Se Beber, Não Case!','Todd Phillips',2009,'Comédia','Dois dias antes de seu casamento, Doug e três amigos vão de carro até Las Vegas para uma louca e memorável despedida de solteiro. Quando os três padrinhos acordam na manhã seguinte, eles não conseguem se lembrar de nada e notam que Doug desapareceu. Com pouco tempo de sobra, os amigos tentam refazer a noite anterior e encontrar Doug para que possam levá-lo de volta a Los Angeles a tempo de chegar ao altar.','Filme','https://image.tmdb.org/t/p/w200/m0tQyMdp3fy5ooUOQkJMd1fQKBJ.jpg',99),(70,'Se Beber, Não Case! Parte II','Todd Phillips',2011,'Comédia','Phil, Stu, Alan e Doug viajam à exótica Tailândia para o casamento de Stu. O que poderia dar errado? Dois anos depois da desastrosa despedida de solteiro de Doug em Las Vegas, agora é a vez de Stu. Ele decide se casar na Tailândia, país de sua futura mulher. Com medo de que os incidentes da despedida de solteiro em Las Vegas se repitam, Stu organiza muito bem a comemoração, mas nada sai como o esperado, e as confusões prometem ser inimagináveis.','Filme','https://image.tmdb.org/t/p/w200/lvwO6R9RImeq3UBbh6DPWG3Iiqw.jpg',101),(72,'Se Beber, Não Case! Parte III','Todd Phillips',2013,'Comédia','Faz dois anos desde que o quarteto, conhecido como Wolfpack, quase escapou de um desastre em Bangkok. Agora, Phil, Stu e Doug vivem felizes em casa, mas Alan não. Ainda sem rumo na vida, Alan não tem tomado seus remédios e está vivendo sob impulsos naturais. Está nas mãos dos amigos ajudá-lo com sua crise pessoal, embarcando em uma viagem para o lugar onde tudo começou: Las Vegas.','Filme','https://image.tmdb.org/t/p/w200/6SOnmTK0XoEcc7AoyXoce76to3Y.jpg',100),(73,'Gente Grande','Dennis Dugan',2010,'Comédia','A morte do treinador de basquete da infância de velhos amigos os reúne no mesmo lugar que celebraram um campeonato anos atrás. Os amigos, acompanhados de suas esposas e filhos, descobrem que idade não significa o mesmo que maturidade.','Filme','https://image.tmdb.org/t/p/w200/ppU2xJnlKdW3F01AtC9wMuXRZCg.jpg',102),(74,'Finalmente 18','Jon Lucas',2013,'Comédia','A melhor coisa da vida é ter amigos! E Jeff não pode reclamar nem um pouco disso, afinal, seus dois melhores amigos vão até o campus onde ele mora para agitar o seu aniversário de 18 anos. Este é \"O\" primeiro grande momento na vida de uma pessoa, é poder entrar em qualquer clube de dança, poder beber a vontade e praticamente fazer tudo o que quiser... ou quase tudo.','Filme','https://image.tmdb.org/t/p/w200/7EnsavgdNdj7mz5I37y5f1x1m5o.jpg',93),(75,'American Pie: A Primeira Vez é Inesquecível','Paul Weitz',1999,'Comédia','Jim Kevin, Oz e Finch são quatro amigos às vésperas do baile de formatura de escola. Entre tentativas frustradas de fazer sexo com as namoradas, vigiar garotas nuas pela Internet e até atacar uma torta recém-saída do forno, os rapazes fazem um pacto: deixar a virgindade para trás antes do baile de formatura. Começam, então, as investidas mais hilariantes em busca de sexo e, principalmente, mulheres.','Filme','https://image.tmdb.org/t/p/w200/4GxuPJxUcArRpfBGJL6BG3B4Cb9.jpg',95),(77,'Minions & Monstros','Pierre Coffin',2026,'Aventura','Esta é a frenética, ridícula e totalmente verdadeira história de como os Minions conquistaram Hollywood, se tornaram estrelas de cinema, perderam tudo, libertaram monstros pelo mundo e, depois, se uniram para tentar salvar o planeta do caos que eles mesmos haviam acabado de criar.','Filme','https://image.tmdb.org/t/p/w200/hTowtXrkCY7FJyoj4p91JckrJSE.jpg',87),(78,'Shrek','Andrew Adamson',2001,'Animação','Em um pântano distante vive Shrek, um ogro solitário que vê, sem mais nem menos, sua vida ser invadida por uma série de personagens de contos de fada. Todos eles foram expulsos de suas casas pelo maligno Lorde Farquaad. Determinado a recuperar a tranquilidade, Shrek faz um acordo com Farquaad: todos os personagens poderão retornar aos seus lares se ele e seu amigo Burro resgatarem uma princesa que foi aprisionada por um dragão.','Filme','https://image.tmdb.org/t/p/w200/wxeqfC221YMptRRdzxlijAh7q8l.jpg',90),(79,'Carros','John Lasseter',2006,'Animação','Ao viajar para a Califórnia, o famoso carro de corridas Relâmpago McQueen se perde e vai parar em Radiator Springs, uma cidadezinha na Rota 66. Ele conhece novos amigos e aprende lições que mudam sua forma de encarar a vida.','Filme','https://image.tmdb.org/t/p/w200/A7nssMRIPauZhEVf2dzwsf4EALO.jpg',117),(80,'A Era do Gelo','Chris Wedge',2002,'Animação','Vinte mil anos atrás, num mundo coberto de gelo, o mamute Manfred e a preguiça Sid resgatam um bebê humano órfão. Agora, os dois vão enfrentar muitas aventuras até devolver o filhote de gente à sua tribo, que migrou para um novo acampamento.','Filme','https://image.tmdb.org/t/p/w200/dlqC2gJs02gc23XvyOjoz52ToRI.jpg',82),(81,'Tropa de Elite','José Padilha',2007,'Drama','Rio de Janeiro, 1997. Nascimento, capitão da Tropa de Elite do Rio de Janeiro, é designado para chefiar uma das equipes que tem como missão \"apaziguar\" o Morro do Turano por um motivo que ele considera insensato. Mas ele tem que cumprir as ordens enquanto procura por um substituto. Sua mulher, Rosane, está no final da gravidez e todos os dias lhe pede para sair da linha de frente do batalhão. Pressionado, o capitão sente os efeitos do estresse.Neste clima, é chamado para mais uma emergência num morro. Em meio a um tiroteio em um baile funk, Nascimento e sua equipe têm que resgatar dois aspirantes a oficiais da PM: Neto e Matias. Ansiosos por entrar em ação e impressionados com a eficiência de seus salvadores, os dois se candidatam ao curso de formação da Tropa de Elite.','Filme','https://image.tmdb.org/t/p/w200/jpG8AVzRQabzjHeJ7JWbuXe9T1n.jpg',115),(82,'Tropa de Elite 2: O Inimigo Agora é Outro','José Padilha',2010,'Drama','O destino da cidade do Rio de Janeiro e de Nascimento se cruzam em \"Tropa de Elite 2\", quando suas obrigações de pai se chocam com as de policial. Mais maduro, estratégico e solitário, o agora Coronel Nascimento faz o bope crescer e coloca o tráfico de drogas de joelho. Isto apenas para descobrir que na segurança pública do Rio de Janeiro nada é o que parece. O sistema se reinventa e descobre como lucrar sem o intermédio do tráfico. Em perseguição ao caminho trilhado pelo sistema, Nascimento vai além dos limites do quartel, revelando as ligações das milícias com o Estado. E o preço por essa descoberta é alto: o inimigo agora é outro.','Filme','https://image.tmdb.org/t/p/w200/gW2JzWuOKHkKOr33slfBEQJYYeS.jpg',115),(83,'Extermínio 2','Juan Carlos Fresnadillo',2007,'Terror','Seis meses depois de um vírus ter destruído um grande número de pessoas na Grã-Betanha, o exército americano declara que o perigo já passou e começa a reconstrução da cidade. Os refugiados retornam, mas um deles carrega um segredo mortal. O vírus não está morto e agora está mais perigoso.','Filme','https://image.tmdb.org/t/p/w200/mZVFtNKPv3aiESKKeUDV61DaQ90.jpg',100),(84,'Extermínio: O Templo dos Ossos','Nia DaCosta',2026,'Terror','Dr. Kelson se vê envolvido num novo relacionamento chocante – com consequências que podem mudar o mundo como eles o conhecem – e o encontro de Spike com Jimmy Crystal se torna um pesadelo do qual ele não consegue escapar.','Filme','https://image.tmdb.org/t/p/w200/tbECC1mMbytgaynCnBhgVPzCZcd.jpg',109);
/*!40000 ALTER TABLE `item_midia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listas_pessoais`
--

DROP TABLE IF EXISTS `listas_pessoais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listas_pessoais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_midia` int NOT NULL,
  `status_lista` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_midia` (`id_midia`),
  CONSTRAINT `listas_pessoais_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `listas_pessoais_ibfk_2` FOREIGN KEY (`id_midia`) REFERENCES `item_midia` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listas_pessoais`
--

LOCK TABLES `listas_pessoais` WRITE;
/*!40000 ALTER TABLE `listas_pessoais` DISABLE KEYS */;
INSERT INTO `listas_pessoais` VALUES (40,16,67,'JA_ASSISTI'),(42,18,84,'QUERO_ASSISTIR'),(44,18,83,'JA_ASSISTI');
/*!40000 ALTER TABLE `listas_pessoais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `perfil` varchar(20) DEFAULT 'COMUM',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (16,'Admin','admin@admin.com','$2a$10$ZMaHMcVXZG2XsuIXUzCPkO.xvd/um8rg79FzE5XVqeiBqtmevECua','ADMIN'),(18,'User','user@user.com','$2a$10$fJ3u3QFKPWRL3xakOEOT/ePzT4.CydBSNOqX9Q0bv75V8nmOB4Dfe','COMUM');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-28 18:25:49
