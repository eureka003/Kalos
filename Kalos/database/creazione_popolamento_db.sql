UNLOCK TABLES;
CREATE DATABASE  IF NOT EXISTS `storage` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `storage`;


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
-- Table structure for table `metodo_pagamento`
--

DROP TABLE IF EXISTS `metodo_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_pagamento` (
  `numero_carta` varchar(16) NOT NULL,
  `scadenza_carta` date NOT NULL,
  `titolare_carta` varchar(100) NOT NULL,
  PRIMARY KEY (`numero_carta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_pagamento`
--

LOCK TABLES metodo_pagamento WRITE;
/*!40000 ALTER TABLE metodo_pagamento DISABLE KEYS */;
INSERT INTO metodo_pagamento VALUES ('1111222233334444','2027-06-12','Luca Avella');
INSERT INTO metodo_pagamento VALUES ('9999888877776666','2027-06-12','Abigail Bianchi');
/*!40000 ALTER TABLE metodo_pagamento ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `email` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `pwd` varchar(60) DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `data_nascita` date NOT NULL,
  `amministratore` tinyint(1) NOT NULL,
  `carta_credito` varchar(16) DEFAULT NULL,
  `indirizzo` varchar(100) DEFAULT NULL,
  `cap` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `carta_credito` (`carta_credito`),
  KEY `indirizzo` (`indirizzo`,`cap`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`carta_credito`) REFERENCES `metodo_pagamento` (`numero_carta`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`indirizzo`, `cap`) REFERENCES `indirizzo_spedizione` (`indirizzo`, `cap`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping data for table `cliente`
--

LOCK TABLES cliente WRITE;
/*!40000 ALTER TABLE cliente DISABLE KEYS */;
INSERT INTO cliente VALUES 
('admin99@gmail.com','admin','$2a$10$Bnnh2HshXhwVV1JVhphZ/us6WUXyHCR7.ikxOg3aXUyJ9REoTOI3W','luca','avella','2003-10-22',1, '1111222233334444','Viale Zonta, 19','46029'),
('dummy@gmail.com','user','$2a$10$BG/3oJjvo.S4peISA76WV.sUklM/jkT1Tw/IO5aOEHlI5IAvv48qS','Abigail','Bianchi','2010-10-12',0,'9999888877776666','via Collegalle, 3','50022');
/*!40000 ALTER TABLE cliente ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `composizione`
--

DROP TABLE IF EXISTS `composizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `composizione` (
  `id_ordine` int NOT NULL,
  `id_prodotto` int NOT NULL,
  `quantita` int NOT NULL,
  `prezzo_tot` double NOT NULL,
  `iva` varchar(100) NOT NULL,
  PRIMARY KEY (`id_ordine`,`id_prodotto`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `composizione_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `composizione_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composizione`
--

LOCK TABLES composizione WRITE;
/*!40000 ALTER TABLE composizione DISABLE KEYS */;
INSERT INTO composizione VALUES (1, 1, 1, 499.99, '23%');
/*!40000 ALTER TABLE composizione ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indirizzo_spedizione`
--

DROP TABLE IF EXISTS `indirizzo_spedizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indirizzo_spedizione` (
  `indirizzo` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `cap` varchar(100) NOT NULL,
  `provincia` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `citta` varchar(100) NOT NULL,
  PRIMARY KEY (`indirizzo`,`cap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indirizzo_spedizione`
--

LOCK TABLES indirizzo_spedizione WRITE;
/*!40000 ALTER TABLE indirizzo_spedizione DISABLE KEYS */;
INSERT INTO indirizzo_spedizione VALUES 
('Viale Zonta, 19','0987654321','46029','Salerno','Luca','Avella','Salerno'),
('via Collegalle, 3','1234567890','50022','Salerno','Abigail','Bianchi','Salerno');
/*!40000 ALTER TABLE indirizzo_spedizione ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `stato` varchar(100) NOT NULL,
  `data_ordine` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `importo_totale` double NOT NULL,
  `carta_credito` varchar(16) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `cap` varchar(100) NOT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `email` (`email`),
  KEY `carta_credito` (`carta_credito`),
  KEY `indirizzo` (`indirizzo`,`cap`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`email`) REFERENCES `cliente` (`email`) ON UPDATE CASCADE,
  CONSTRAINT `ordine_ibfk_2` FOREIGN KEY (`carta_credito`) REFERENCES `metodo_pagamento` (`numero_carta`),
  CONSTRAINT `ordine_ibfk_3` FOREIGN KEY (`indirizzo`, `cap`) REFERENCES `indirizzo_spedizione` (`indirizzo`, `cap`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES ordine WRITE;
/*!40000 ALTER TABLE ordine DISABLE KEYS */;
INSERT INTO ordine VALUES (1,'confermato','2024-06-13','dummy@gmail.com',499.99,'9999888877776666','via Collegalle, 3','50022');
/*!40000 ALTER TABLE ordine ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto`(
  `id_prodotto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descrizione` varchar(300) NOT NULL,
  `descrizione_dettagliata` text,
  `iva` varchar(100) NOT NULL,
  `in_vendita` tinyint(1) NOT NULL,
  `prezzo` double NOT NULL,
  `quantita` int NOT NULL,
  `immagine` varchar(100) NOT NULL,
  `tipologia` varchar(100) NOT NULL,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  
  PRIMARY KEY (`id_prodotto`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1, 'Anello a forma di cuore con rubino', 'Materiale: Argento 925, Pietra: Rubino, Forma: Cuore, Stile: Gotico, romantico, Occasione: Abbigliamento quotidiano, occasioni speciali', 'Questo splendido anello a forma di cuore è realizzato in argento 925 e presenta una pietra rossa scintillante al centro. La pietra è un rubino. Questo anello è perfetto per essere indossato da solo o come parte di un set di gioielli', '23%', 1, 499.99, 2, 'images/anello1.jpg', 'Anelli', 0), 
(2, 'Anello con croce in oro bianco', 'Materiale: Oro bianco 18 carati, Forma: Croce, Stile: Gotico, elegante, Occasione: Abbigliamento quotidiano, occasioni speciali', 'Questo anello con croce è realizzato in oro bianco 18 carati. La croce è semplice e minimalista, con linee pulite e definite. È realizzata in oro bianco lucido e presenta una superficie liscia e uniforme. Questo anello è sottile e delicato, perfetto per essere indossato quotidianamente.', '23%', 1, 699.99, 4, 'images/anello2.jpg', 'Anelli', 0), 
(3, 'Anello Nodo Celtico in Acciaio Inossidabile Placcato Oro', 'Materiale: Acciaio inossidabile placcato oro, Design: Nodo celtico, Finitura: lucida, Stile: unisex, Gotico, elegante, Occasione: Abbigliamento quotidiano, occasioni speciali', 'Questo splendido anello presenta un nodo celtico intricato, simbolo antico di forza, eternità e interconnessione. Realizzato in acciaio inossidabile resistente e placcato in oro per una lucentezza duratura, questo anello è l''accessorio perfetto per chi apprezza la bellezza senza tempo dei simboli celtici.', '23%', 0, 299.99, 0, 'images/anello3.jpg', 'Anelli', 0), 
(4, 'Ciondolo con teschio in bronzo', 'Materiale: bronzo, Dimensione del teschio: 2 cm x 1,5 cm, Finitura: lucida', 'Questo ciondolo è un accessorio audace e accattivante perfetto per chi ama distinguersi dalla massa. Il teschio in bronzo è un simbolo potente che rappresenta forza ribellione e individualità. Il ciondolo è realizzato con materiali di alta qualità e presenta una finitura impeccabile. È un regalo perfetto per qualsiasi occasione, o semplicemente per te stesso', '23%', 1, 199.99, 5, 'images/ciondolo1.jpg', 'Ciondoli', 0),
(5, 'Ciondolo pipistrello', 'Materiale: Argento 925, Pietra: Onice, Forma: Ovale, Dimensioni: 2 cm x 1 cm', 'Questo ciondolo a forma di pipistrello è un accessorio unico e accattivante che non mancherà di attirare l''attenzione. Realizzato con materiali di alta qualità, questo ciondolo è destinato a durare nel tempo. Il design delicato e dettagliato del pipistrello lo rende un''aggiunta perfetta a qualsiasi outfit', '23%', 1, 219.99, 3, 'images/ciondolo2.jpg', 'Ciondoli', 0), 
(6, 'Ciondolo Ragno in Argento', 'Materiale: Argento 925, Finitura: Lucida, Pietra: Rubino, Taglio della pietra: Cabochon', 'Questo splendido ciondolo in argento a forma di ragno è un accessorio unico e accattivante che non mancherà di farsi notare. Realizzato in argento di alta qualità, questo ciondolo presenta un design delicato e dettagliato che cattura la bellezza intricata di un ragno. Le otto zampe sottili e il corpo arrotondato sono resi ancora più affascinanti dalla presenza di un rubino. La pietra, tagliata a cabochon, cattura la luce e scintilla con ogni movimento, aggiungendo un tocco di eleganza e raffinatezza al gioiello', '23%', 0, 399.99, 0, 'images/ciondolo3.jpg', 'Ciondoli', 0), 
(7, 'Collana di perle con pendente di giada', 'Materiale: Perline di giada verde, pendente di giada a forma di cabochon, argento 925, Lunghezza: 45 cm (regolabile), Chiusura: Moschettone, Stile: Classico, elegante', 'Questa splendida collana è realizzata con perline di giada verde e un grande pendente di giada a forma di cabochon. La giada è una pietra preziosa conosciuta da secoli per la sua bellezza e le sue proprietà benefiche. Si dice che la giada porti fortuna, prosperità e salute. La collana è lunga 45 cm ed è regolabile con una chiusura a moschettone. La catena è realizzata in argento 925', '23%', 1, 599.99, 2, 'images/collana1.jpg', 'Collane', 0), 
(8, 'Collana in Argento 925', 'Materiale: Argento 925, Lunghezza: 45 cm, Larghezza: 2 mm, Chiusura: Moschettone, Stile: Classico, Elegante, Versatile', 'Questa collana è realizzata in argento 925. Il design semplice e raffinato la rende un accessorio versatile che può essere indossato in ogni occasione, da quelle più formali a quelle più casual. La catena è a maglia fine, con una lunghezza di 45 cm e una chiusura a moschettone. La larghezza della catena è di 2 mm.', '23%', 0, 149.99, 0, 'images/collana2.jpg', 'Collane', 0), 
(9, 'Collana Albero della Vita', 'Materiale: Argento sterling 925, Finitura: Lucida, Dimensioni ciondolo: 24 mm x 24 mm, Lunghezza catena: 55 cm (regolabile), Chiusura: Moschettone, Stile: Unisex, Occasione: Regalo, Tutti i giorni', 'Questa splendida collana è realizzata in argento sterling 925 e presenta un ciondolo a forma di Albero della Vita. L''Albero della Vita è un simbolo universale che rappresenta la forza, la crescita e la vita eterna. È un regalo perfetto per chiunque voglia celebrare la bellezza della natura e la forza interiore', '23%', '1', 249.99, 6, 'images/collana3.jpg', 'Collane', 0), 
(10, 'Bracciale Uomo Occhio di Tigre Onice Argento', 'Materiali Pietre: Pietre naturali occhio di tigre e onice, Materiale Bracciale: Argento 925, Finitura: Lucida, Dimensioni pietre: 8 mm, Lunghezza bracciale: Regolabile (da 18 cm a 22 cm)', 'Questo bracciale da uomo è realizzato con pietre naturali di occhio di tigre e onice e componenti in argento 925. L''occhio di tigre è una pietra che simboleggia la protezione, la fortuna e il coraggio. L''onice è una pietra che simboleggia la forza, la perseveranza e la sicurezza in se stessi. Questo bracciale è un regalo perfetto per un uomo che desidera un gioiello elegante e significativo', '23%', 0, 129.99, 0, 'images/bracciale1.jpg', 'Bracciali', 0), 
(11, 'Bracciale Corona di Spine in Argento', 'Materiale: Argento sterling 925, Finitura: Lucida, Dimensioni corona di spine: circa 20 mm x 20 mm, Lunghezza bracciale: 18 cm (regolabile), Chiusura: Moschettone, Stile: Unisex, Occasione: Regalo, Tutti i giorni', 'Questo bracciale è realizzato in Argento Sterling 925 e presenta una delicata corona di spine in rilievo. La corona di spine, pur essendo un simbolo religioso, può essere apprezzata anche per il suo valore estetico e la sua complessa fattura. Questo gioiello rappresenta forza, resilienza e il superamento delle avversità.', '23%', 1, 99.99, 7, 'images/bracciale2.jpg', 'Bracciali', 0), 
(12, 'Bracciale Cuore in Argento', 'Materiale: Argento sterling 925, Finitura: Lucida, Dimensioni ciondolo: circa 15 mm x 15 mm, Lunghezza bracciale: 18 cm (regolabile), Chiusura: Moschettone, Stile: Unisex, Occasione: Regalo, Tutti i giorni', 'Questo bracciale è realizzato in Argento Sterling 925 e presenta un ciondolo a forma di cuore in rilievo. Il cuore è un simbolo universale che rappresenta l''amore, la passione, l''affetto e la felicità Questo bracciale è un regalo perfetto per chi apprezza i gioielli con un design classico e senza tempo', '23%', 1, 149.99, 4, 'images/bracciale3.jpg', 'Bracciali', 0), 
(13, 'Body chain con stelle in argento', 'Materiale prodotto: Argento Sterling 925, Forma: Stella', 'Questa body chain è un gioiello elegante e alla moda che può essere indossato in molte occasioni diverse. È realizzata in argento e presenta una serie di stelle scintillanti in diverse dimensioni. La catena è regolabile in lunghezza, quindi può essere adattata a qualsiasi corporatura.', '23%', 1, 69.99, 3, 'images/bodychain1.jpg', 'BodyChains', 0), 
(14, 'Body chain in argento con design a torsione', 'Materiale: Argento Sterling 925, Forma: Torsione', 'Questa elegante body chain in argento è realizzata con un design a torsione che la rende perfetta per aggiungere un tocco di lusso a qualsiasi outfit. È realizzata in argento di alta qualità ed è disponibile in una varietà di lunghezze per adattarsi a qualsiasi figura.', '23%', 1, 79.99, 8, 'images/bodychain2.jpg', 'BodyChains', 0), 
(15, 'Body chain in argento con pendente di onice a goccia', 'Materiale: Argento Sterling 925, Pietra: Onice, Forma pietra: Goccia', 'Questa raffinata body chain in argento è caratterizzata da un design minimalista con un elegante pendente di onice a goccia. Realizzata in argento di alta qualità, questa body chain è perfetta per aggiungere un tocco di classe a qualsiasi outfit. È disponibile in una varietà di lunghezze per adattarsi a qualsiasi figura', '23%', 0, 119.99, 0, 'images/bodychain3.jpg', 'BodyChains', 0), 
(16, 'Piercing a cerchio con tridente in acciaio chirurgico', 'Materiale: Acciaio Chirurgico, Forma: Tridente', 'Questo elegante piercing a cerchio è realizzato in acciaio chirurgico di alta qualità ed è caratterizzato da un design a tridente unico. Il design del tridente è un simbolo di forza e potere e questo piercing è perfetto per chi vuole esprimere la propria individualità. Il piercing è disponibile in una varietà di calibri e diametri per adattarsi perfettamente al tuo orecchio.', '23%', 1, 34.99, 7, 'images/piercing1.jpg', 'Piercings', 0), 
(17, 'Piercing septum gotico in acciaio chirurgico', 'Materiale: Acciaio Chirurgico, Design: Gotico', 'Questo elegante piercing septum è realizzato in acciaio chirurgico di alta qualità ed è caratterizzato da un design gotico.', '23%', 1, 49.99, 4, 'images/piercing2.jpg', 'Piercings', 0), 
(18, 'Helix piercing a spirale in argento', 'Materiale: Argento Sterling 925, Forma: Spirale', 'Questo splendido helix piercing a spirale in argento è un accessorio perfetto per chi desidera aggiungere un tocco di eleganza e raffinatezza al proprio look. Realizzato in argento di alta qualità, questo piercing è resistente e duraturo e non si appanna nel tempo. La spirale delicata e sinuosa cattura la luce e crea un effetto accattivante. Questo piercing è perfetto da indossare da solo o abbinato ad altri gioielli', '23%', 0, 29.99, 0, 'images/piercing3.jpg', 'Piercings', 0), 
(19, 'Orecchini pendenti in argento con design celtico', 'Materiale: Argento Sterling 925, Stile: Celtico, Finitura: lucida, Chiusura: a gancio, Dimensioni: 3 cm di lunghezza, 2 cm di larghezza, Spessore: 1 mm', 'Questi splendidi orecchini pendenti in argento con design celtico sono un accessorio perfetto per chi desidera aggiungere un tocco di tradizione e cultura al proprio look. Realizzati in argento di alta qualità, questi orecchini sono resistenti e duraturi e non si appannano nel tempo. Il design celtico intricato è sia elegante che accattivante, e i pendenti delicati si muovono con grazia con ogni movimento. Questi orecchini sono perfetti da indossare da soli o abbinati ad altri gioielli con motivi celtici', '23%', 1, 69.99, 6, 'images/orecchini1.jpg', 'Orecchini', 0), 
(20, 'Orecchini a croce con pietra nera in oro giallo', 'Materiale: oro giallo, Stile: a croce, Pietra: onice, Finitura: lucida, Chiusura: a gancio, Dimensioni: 1 cm di lunghezza, 0,5 cm di larghezza, Spessore: 1 mm', 'Questi eleganti orecchini a croce con onice in oro giallo sono un accessorio perfetto per chi desidera aggiungere un tocco di raffinatezza e spiritualità al proprio look. Realizzati in oro giallo di alta qualità, questi orecchini sono resistenti e duraturi e non si appannano nel tempo. La croce delicata e simbolica è impreziosita da un onice scintillante che cattura la luce e crea un effetto accattivante. Questi orecchini sono perfetti da indossare da soli o abbinati ad altri gioielli in oro.', '23%', 1, 99.99, 3, 'images/orecchini2.jpg', 'Orecchini', 0), 
(21, 'Orecchini a forma di pipistrello in argento', 'Materiale: Argento Sterling 925, Stile: pendenti, Stile: pendenti, Chiusura: a gancio, Dimensioni: 2 cm di lunghezza, 1 cm di larghezza, Spessore: 1 mm', 'Questi orecchini a forma di pipistrello in argento sono un accessorio unico e accattivante che sicuramente farà colpo. Realizzati in argento di alta qualità, questi orecchini sono resistenti e duraturi e non si appannano nel tempo. La forma del pipistrello è delicata e dettagliata, e gli orecchini pendono graziosamente dalle orecchie. Questi orecchini sono perfetti da indossare da soli o abbinati ad altri gioielli in argento.', '23%', 0, 129.99, 0, 'images/orecchini3.jpg', 'Orecchini', 0), 
(22, 'Orologio nero e oro con cinturino in pelle nera', 'Cassa: acciaio inossidabile, Cinturino: pelle, Quadrante: metallo, Indici e lancette: ottone dorato', 'Questo orologio è un accessorio elegante e raffinato, perfetto per ogni occasione. Ha una cassa in acciaio inossidabile nero con dettagli dorati e un cinturino in pelle nera morbida e resistente. Il quadrante è nero con indici e lancette dorate. Questo orologio ha una funzione cronografo, che consente di misurare il tempo trascorso', '23%', 1, 799.99, 2, 'images/orologio1.jpg', 'Orologi', 0), 
(23, 'Orologio da uomo in acciaio inossidabile con cronografo e cinturino nero', 'Cassa in acciaio inossidabile con dettagli dorati, Cinturino in pelle nera, Quadrante nero con indici e lancette dorate, Finestra per la data a ore 3, Funzione cronografo, Resistenza all''acqua fino a 50 metri, Movimento al quarzo', 'Questo orologio da uomo è un accessorio elegante e funzionale, perfetto per l''uomo moderno. Ha una cassa in acciaio inossidabile resistente e lucida con dettagli dorati, e un cinturino in pelle nera morbida e resistente. Il quadrante è nero con indici e lancette dorate, e presenta una finestra per la data a ore 3. L''orologio ha una funzione cronografo, che consente di misurare il tempo trascorso, e una resistenza all''acqua fino a 50 metri, che lo rende ideale per l''uso quotidiano', '23%', 1, 699.99, 3, 'images/orologio2.jpg', 'Orologi', 0),                 																																												
(24, 'Orologio nero con cinturino in pelle nera', 'Cassa in acciaio inossidabile nero con dettagli dorati, Cinturino in pelle nera, Quadrante nero con indici e lancette dorate, Finestra per la data a ore 6, Funzione cronografo, Movimento al quarzo, Resistente all''acqua fino a 50 metri', 'Questo orologio è un accessorio elegante e raffinato, perfetto per ogni occasione. Ha una cassa in acciaio inossidabile nero con dettagli dorati e un cinturino in pelle nera morbida e resistente. Il quadrante è nero con indici e lancette dorate, e presenta una finestra per la data a ore 6. L''orologio ha una funzione cronografo, che consente di misurare il tempo trascorso', '23%', 0, 599.99, 0, 'images/orologio3.jpg', 'Orologi', 0);
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
