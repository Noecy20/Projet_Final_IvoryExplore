CREATE DATABASE ivoryExplore;

USE ivoryExplore;

-- Table users
CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY(1,1),
    nom_user VARCHAR(50) NOT NULL,
    prenom_user VARCHAR(50) NOT NULL,
    username VARCHAR(10) NOT NULL,
    email VARCHAR(30) NOT NULL,
    passwords VARCHAR(225) NOT NULL,
    UNIQUE(email),
	profileImage VARCHAR(90) DEFAULT 'profile.png'
);

-- Table CategorieProduits
CREATE TABLE CategorieProduits (
    codecategorie INT PRIMARY KEY,
    nomcategorie VARCHAR(50)
);

-- Table Client
CREATE TABLE Client (
    CodeClient INT PRIMARY KEY,
    NomClient VARCHAR(50),
    AdresseClient VARCHAR(100),
    Telephone VARCHAR(15)
);

-- Table Commande
CREATE TABLE Commande (
    NumCommande INT PRIMARY KEY,
    DateCommande DATE,
    CodeClient INT,
    CodeProduit INT,
    Quantite INT,
    PrixTotal FLOAT
);

-- Table Fournisseur
CREATE TABLE Fournisseur (
    CodeFournisseur INT PRIMARY KEY,
    NomFournisseur VARCHAR(50),
    AdresseFournisseur VARCHAR(100),
    Telephone VARCHAR(15)
);

-- Table historique
CREATE TABLE historique (
    id INT PRIMARY KEY IDENTITY(1,1),
    recherche VARCHAR(25) NOT NULL
);

-- Table hotel
CREATE TABLE hotel (
    id_hotel INT PRIMARY KEY,
    nom VARCHAR(255),
    localisation VARCHAR(255),
    lien_image_hotel VARCHAR(255)
);

-- Table nco
CREATE TABLE nco (
    id_co INT PRIMARY KEY IDENTITY(1,1),
    nombre_connexion INT,
    id_user INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id)
);

-- Table preference
CREATE TABLE preference (
    id_preference INT PRIMARY KEY IDENTITY(1,1),
    interests TEXT NOT NULL,
    id_user INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id)
);

-- Table produits
CREATE TABLE produits (
    codeproduits INT PRIMARY KEY,
    nom VARCHAR(200),
    descriptions VARCHAR(200),
    stockactuel INT,
    prixunitaire INT,
    codecategories INT,
    codeFournisseurs INT,
    FOREIGN KEY (codecategories) REFERENCES CategorieProduits(codecategorie) ON DELETE CASCADE,
    FOREIGN KEY (codeFournisseurs) REFERENCES Fournisseur(CodeFournisseur) ON DELETE CASCADE
);

-- Table restaurant
CREATE TABLE restaurant (
    id_resto INT PRIMARY KEY,
    nom_resto VARCHAR(255),
    localisation VARCHAR(255),
    ville_ou_commune VARCHAR(255),
    spécialité VARCHAR(255),
    téléphone VARCHAR(255),
    lien_image_resto VARCHAR(255)
);

-- Table universites1
CREATE TABLE universites1 (
    ID INT PRIMARY KEY IDENTITY (1,1),
    Etablissement VARCHAR(255),
    Ville VARCHAR(255),
    Commune VARCHAR(255),
    MontantDesFraisDInscription INT,
    ListeDesFilieres VARCHAR(255),
	ImageUniversite VARCHAR(1000)
);


-- Ajout des contraintes étrangères
ALTER TABLE Commande ADD FOREIGN KEY (CodeClient) REFERENCES Client(CodeClient) ON DELETE CASCADE;
ALTER TABLE Commande ADD FOREIGN KEY (CodeProduit) REFERENCES produits(codeproduits) ON DELETE CASCADE;
ALTER TABLE nco ADD FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE;
ALTER TABLE preference ADD FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE;

select * from universites1

-- Insertion dans la table unuversité --

INSERT INTO universites1 (Etablissement, Ville, Commune, MontantDesFraisDInscription, ListeDesFilieres, ImageUniversite)
VALUES 
('AMERICAN UNIVERSITY OF COTE D’IVOIRE -(AUCI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES','https://www.bing.com/images/blob?bcid=RI1BdhthOG4GLuorjcU9BUj8KQC2.....2c'),
('BORDEAUX ECOLE DE MANAGEMENT -(BEM Abidjan)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES','https://www.bing.com/images/blob?bcid=RKbtivXFEm4GLuorjcU9BUj8KQC2.....6I'),
('CENTRE UNIVERSITAIRE PROFESSIONNALISE -(CUP)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RJVRHaMx8m4GLuorjcU9BUj8KQC2.....xA'),
('CERAP/UNIVERSITE JESUITE -(CERAP/UJ)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RNMgzvu4n24GLuorjcU9BUj8KQC2.....0U'),
('DEMING EXCELLENCE INSTITUTE -(DEI)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RMH9kngjtG4GLuorjcU9BUj8KQC2.....68'),
('ECOLE D’ARCHITECTURE D’ABIDJAN -(EAA)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RMoe5RJC0m4GLuorjcU9BUj8KQC2.....1g'),
('ECOLE SUPERIEURE D’INTERPRETARIAT ET DE TRADUCTION -(ESIT)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES','https://www.bing.com/images/blob?bcid=RKvV8PpMpm4GLuorjcU9BUj8KQC2......k'),
('ECOLE SUPERIEURE DES PROFESSIONS IMMOBILIERES -(ESPI)', 'ABIDJAN', 'COCODY', 55000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RKNvYTBC6G4GqxcxoNWLuD9SqbotqVTdP8k'),
('ECOLE SUPERIEURE GADJI_UNIVERSITÉ -(ESUG_UNIVERSITÉ)', 'ABIDJAN', 'PLATEAU', 250000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RJpZQru2vW4GLuorjcU9BUj8KQC2.....4I'),
('ECOLE SUPERIEURE LE PETIT CHAMPION_UNIVERSITE -(ESPC_UNIVERSITE)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES','https://www.bing.com/images/blob?bcid=RJXDxEGWgG4GLuorjcU9BUj8KQC2.....4k'),
('ECOLE SUPERIEURE PLURIDISCIPLINAIRE D’ABIDJAN COCODY -(ESPA COCODY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/R.11d1452993669607a8d8b826369736f3?rik=RHxS5TTJAarc9A&riu=http%3a%2f%2fwww.espa-university.tech%2fimages%2fjoomlart%2flogos%2flogo-espa.jpg&ehk=bwKfNLj1mpaQgaa%2b5SknX%2fvj%2f6sWyt%2fFXkGY4%2fbMwEQ%3d&risl=&pid=ImgRaw&r=0'),
('ECOLE SUPERIEURE PLURIDISCIPLINAIRE D’ABIDJAN/YAMOUSSOUKRO -(ESPA YAMOUSSOUKRO)',	'YAMOUSSOUKRO',	'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/R.11d1452993669607a8d8b826369736f3?rik=RHxS5TTJAarc9A&riu=http%3a%2f%2fwww.espa-university.tech%2fimages%2fjoomlart%2flogos%2flogo-espa.jpg&ehk=bwKfNLj1mpaQgaa%2b5SknX%2fvj%2f6sWyt%2fFXkGY4%2fbMwEQ%3d&risl=&pid=ImgRaw&r=0'),
('ECOLE TECHNIQUE INFORMATIQUE ET COMMERCIALE-UNIVERSITY -(ETIC-UNIVERSITY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RK-lNb3x.G4GLuorjcU9BUj8KQC2.....-I'),
('EMMAUS INTERNATIONAL UNIVERSITY -(EIU)', 'ABIDJAN', 'COCODY', NULL,'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RCbLj4MELG4GLuorjcU9BUj8KQC2.....wQ'),
('FACULTES UNIVERSITAIRES PRIVEES D’ABIDJAN -(FUPA)',	'ABIDJAN',	'COCODY',	165000,	'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RBdm2FNKIm4GLuorjcU9BUj8KQC2.....3I'),
('GLOBAL NUMERIK UNIVERSITY -(GNU)', 'ABIDJAN',	'COCODY',	85000,	'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RHs0G5pRgG4GLuorjcU9BUj8KQC2.....8M'),
('HAUTES ETUDES COMMERCIALES D’ABIDJAN -(HEC-ABIDJAN)',	'ABIDJAN',	'COCODY',	175000,	'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RCVlvQTOLG4GLuorjcU9BUj8KQC2.....0w'),
('INSITUT SUPERIEUR D’INGENIERIE ET DE SANTE YAMOUSSOUKRO -(ISIS YAMOUSSOUKRO)',	'YAMOUSSOUKRO',	'YAMOUSSOUKRO',	85000,	'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RF9zipPoRG4GLuorjcU9BUj8KQC2.....5o'),
('INSTITUTES-LE CAMPUS COCODY_UNIVERSITÉ et D’ENSEIGNEMENT SUPÉRIEUR LE CAMPUS COCODY -(IES-LE CAMPUS COCODY)',	'ABIDJAN', NULL, NULL,	'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RHc-oNlzHG4GLuorjcU9BUj8KQC2.....7Q'),
('INSTITUT CATHOLIQUE MISSIONNAIRE D’ABIDJAN -(ICMA)',	'ABIDJAN',	'ABOBO',	NULL,	'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RGIv-gYcWG4GLuorjcU9BUj8KQC2.....8o'),
('INSTITUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS COCODY_UNIVERSITE -(IES-LE CAMPUS COCODY_UNIVERSITE)',	'ABIDJAN',	'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RHc-oNlzHG4GLuorjcU9BUj8KQC2.....7Q'),
('INSTITUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS MAN_UNIVERSITE -(IES-LE CAMPUS MAN_UNIVERSITE)', 'MAN', 'MAN', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RHc-oNlzHG4GLuorjcU9BUj8KQC2.....7Q'),
('INSTITUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS YOPOUGON_UNIVERSITE -(IES-LE CAMPUS YOPOUGON_UNIVERSITE)', 'ABIDJAN', 'YOPOUGON', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RHc-oNlzHG4GLuorjcU9BUj8KQC2.....7Q'),
('INSTITUT DE MANAGEMENT ET DES TECHNOLOGIES -(IMAT)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES','https://edukiya.com/wp-content/uploads/2022/02/IMAT-ABIDJAN-Institut-de-Management-et-des-Technologies-dAbidjan-cote-divoire-licence-master-doctorat-formations-gestion-afrique.jpg'),
('INSTITUT EUROPEEN DES AFFAIRES -(IEA-ABIDJAN)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t1.6435-9/152356366_119316393455374_7900155149955271540_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=7f8c78&_nc_eui2=AeHe5_PAA5of8_vGUcT3g33Ouz6MR5KNMDm7PoxHko0wOaOve9BVZMr7L8UoG_tzs1kwGsCHrZSNM5G7HgH4-Kvl&_nc_ohc=6Od2Q9LnNaAAX8mHVQS&_nc_ht=scontent.fabj1-1.fna&oh=00_AfDcR3EB1--YNyZ-A9AxXNmtS8USj2daSpUd4s0ssnheaw&oe=65A2ADBF'),
('INSTITUT IES-LE CAMPUS COCODY_UNIVERSITE SUPERIEUR LE CAMPUS COCODY -(IES-LE CAMPUS COCODY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RHc-oNlzHG4GLuorjcU9BUj8KQC2.....7Q'),
('INSTITUT INTERNATIONAL D’ADMINISTRATION ET DE MANAGEMENT -(2IAM)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t1.6435-9/128739285_141939891055604_6909881034419281088_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=dd63ad&_nc_eui2=AeFSYwKM16NyUpOCu6McWkjz3CBu7ZPBtIHcIG7tk8G0gQa-k3d3QBetJxaihTXPvfgrphgkdcoQ4QqDHwcnFTUm&_nc_ohc=FVZD370Tnu8AX9K5CqA&_nc_ht=scontent.fabj1-1.fna&oh=00_AfBkXFWeBdrDbtI4X9sQQ4FuN1I_FFVEfC5nyRD8iS39fg&oe=65A2A51B'),
('INSTITUT IVOIRIEN DE TECHNOLOGIE -(IIT)', 'BASSAM', 'BASSAM', 50000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/298340574_429668705849181_3122165989312500458_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeHAdjI4vEz5dtPEGHwgk1hC7vuAW9n-d2ju-4Bb2f53aNNxc8Pz6BXY-xI78Ld8Ce-Tm3wuwCmJZvDEx0Vcf8Ht&_nc_ohc=ImirS7Q9Kf4AX9CqQtT&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfAQUVDVrLgYO-bBm4Gi7m-ZrmdwwLr1PzaBVmuro8TFZA&oe=657F5783'),
('INSTITUT SUPERIEUR D’INGENIERIE ET DE SANTE COCODY -(ISIS COCODY)', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RF9zipPoRG4GLuorjcU9BUj8KQC2.....5o'),
('INSTITUT SUPERIEUR UNIVERSITAIRE POLYTECHNIQUE ACKA EWADJO CECILE -(ISUPEC)', 'GRAND LAHOU', 'GRAND LAHOU', 140000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj2-1.fna.fbcdn.net/v/t39.30808-6/307184016_436359805227025_816413570754465862_n.png?_nc_cat=108&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeG2M36-BuR57Jg6AW1YNO1d3geF3l7ZRODeB4XeXtlE4PCfrQG2aEmpoeWkmEgJ8Ep6MAAlPUsl02GJj9CU-9YX&_nc_ohc=TYjIKVMVA28AX-ZeKCR&_nc_zt=23&_nc_ht=scontent.fabj2-1.fna&oh=00_AfClduAfRipfJOvCHwHG26rj7Vj2sO105DJh-fbzaZBv-g&oe=65814690'),
('INSTITUT UNIVERSITAIRE Abidjan -(IUA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.iuaci.org/wp-content/uploads/2022/08/WhatsApp-Image-2022-08-04-at-14.06.19-1.jpeg'),
('Institut Universitaire Abidjan-Bluetooth -(IUA-Bluetooth)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.iuaci.org/wp-content/uploads/2022/08/WhatsApp-Image-2022-08-04-at-14.06.19-1.jpeg'),
('Institut Universitaire Abidjan-Bonoumin -(IUA-Bonoumin)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.iuaci.org/wp-content/uploads/2022/08/WhatsApp-Image-2022-08-04-at-14.06.19-1.jpeg'),
('Institut Universitaire Abidjan-Zinsou -(IUA-Zinsou)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.iuaci.org/wp-content/uploads/2022/08/WhatsApp-Image-2022-08-04-at-14.06.19-1.jpeg'),
('Institut Universitaire des Sciences Economiques Juridiques et du Développement Durable (IUSEJDD)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RIcKtxGeQm4GLuorjcU9BUj8KQC2.....34'),
('Institut Universitaire des Sciences Economiques, Juridiques et du Développement Durable -(IUSEJ2D)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RIcKtxGeQm4GLuorjcU9BUj8KQC2.....34'),
('Institut Universitaire du Sud -(IUS)', 'Jacqueville', 'Jacqueville', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RMO-Ol4hQG4GLuorjcU9BUj8KQC2.....xw'),
('Institut Universitaire Fred et Poppée', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://th.bing.com/th/id/OIP.0Ltokk_V6YdEvLHDyB_4lAHaE8?rs=1&pid=ImgDetMain'),
('Institut Universitaire Polytechnique Abidjan YOPOUGON_UNIVERSITE -(IUPA YOPOUGON_UNIVERSITE)', 'Abidjan', 'Yopougon', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RPoGQLp2K24GLuorjcU9BUj8KQC2.....2c'),
('Institut Universitaire Professionnalisé (IUP)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://th.bing.com/th/id/OIP.N7rsUNbNAYweTgK0S1cMdQHaE8?w=1200&h=800&rs=1&pid=ImgDetMain'),
('Institut International Polytechnique des Elites Abidjan COCODY -(IIPEA COCODY)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières','https://www.goafricaonline.com/media/cache/resolve/w800/uploads/media/company_media/0002/34/608008230cda8-visuel6-iipea-cote-ivoire.png'),
('Institut Universitaire Saint Jean-Paul II', 'Yamoussoukro', 'Yamoussoukro', NULL, 'Voir la liste des filières', 'https://iu-stjp2.com/images/os_touchslider_93/original/jp2ABCBA0C0-B8C6-96AD-A1CF-93204C68ECD8.jpg'),
('POLE D’EXCELLENCE ET DE SPECIALISATIONS (PES)', 'Abidjan', 'Cocody', NULL, 'https://universite-pes.com/', 'https://www.bing.com/images/blob?bcid=RBQaIJZfV24GLuorjcU9BUj8KQC2.....7Y'),
('RUSTA UNIVERSITE -(RUSTA UNIVERSITE)', 'Abidjan', 'Cocody', 450000, 'Voir la liste des filières', 'https://th.bing.com/th/id/OIP.GR_oEg73HsPzWy-_DDJIngHaFj?rs=1&pid=ImgDetMain'),
('RUSTA UNIVERSITE ANNEXE DE BOUAKE', 'Bouaké', 'Bouaké', 85000, 'Voir la liste des filières', 'https://th.bing.com/th/id/OIP.GR_oEg73HsPzWy-_DDJIngHaFj?rs=1&pid=ImgDetMain'),
('SEEKA UNIVERSITY -(Seeka U)', 'Yamoussoukro', 'Yamoussoukro', 100000, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RCDvImQoWG4GLuorjcU9BUj8KQC2.....-o'),
('SWISS UMEF UNIVERSITY OF COTE D’IVOIRE -(UMEF)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/260207117_5311797592184173_6225272115237895946_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeGSTCKz-Jnsr9auDkW_Oh-836Y-D8V1uLvfpj4PxXW4u5_xrzrWOvjcIxLhDkS6R-7Gb2wKWYhRrCjuVkSbNNzk&_nc_ohc=KD2rR6GePRQAX_rPTiY&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfBSICSVSXewECyoCybIua60in0NijUAhARfoPB8FpfMIw&oe=65809B61'),
('TG MASTER-UNIVERSITY -(TGM-U)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://univ.tgmaster.com/img/good/Accueil-min.jpeg'),
('UNIVERSITE ADAMA SANOGO -(UAS)', 'Abidjan', 'Abobo', NULL, 'Voir la liste des filières', 'https://th.bing.com/th/id/R.6bfa925b04ae3edff463a6678a117e01?rik=KFcOzKpPK15gVw&riu=http%3a%2f%2fwww.groupeadamasanogo.com%2fimages%2f2017%2f12%2f06%2fdsc_6215.jpg&ehk=mrGAIi0gb%2bUnQ%2b3N%2bdtiJKET8FnY1H7r653akhRHcBs%3d&risl=&pid=ImgRaw&r=0'),
('UNIVERSITE BILINGUE LA CORNICHE -(UBC)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://th.bing.com/th/id/R.d40ea035ec6bf45e5cf0812dc80e8361?rik=%2f3HxHGEvZL9t5g&pid=ImgRaw&r=0'),
('Université Catholique d’Afrique de l’Ouest-Unité Universitaire d’Abidjan', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.goafricaonline.com/uploads/media/default/0001/26/5a708b8a4f8f4-enceinte-ucao-cote-ivoire.JPG'),
('Université Centrale Chaare Tsedek', 'Daloa', 'Daloa', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RCSYaubR3W4GLuorjcU9BUj8KQC2.....3k'),
('Université Charles-Louis de Montesquieu Cocody-Université', 'Abidjan', 'Cocody', 350000, 'Voir la liste des filières', 'https://media-files.abidjan.net/photo/ceremonie-rentre-academique-35.JPG'),
('Université de l’Entrepreneuriat (UE-Azaguié)', 'Azaguié', 'Azaguié', NULL, 'Voir la liste des filières','https://www.telanon.info/wp-content/uploads/2020/05/Cabaz-e1589918933438.jpg'),
('Université de l’Alliance Chrétienne d’Abidjan (UACA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RDrQZC62gm4GLuorjcU9BUj8KQC2.....yM'),
('Université de l’Atlantique Bouaké -(UA Bouaké)', 'Bouaké', 'Bouaké', 55000, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RNyePNQ1AG4GLuorjcU9BUj8KQC2.....2o'),
('Université de l’Atlantique Cocody -(UA Cocody)', 'Abidjan', 'Cocody', 125000, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RNyePNQ1AG4GLuorjcU9BUj8KQC2.....2o'),
('Université de Technologie d’Abidjan -(UTA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RHUHIkgj3m4GLuorjcU9BUj8KQC2.....20'),
('Université des Innovations Culturelles et des Métiers du Virtuel -(UIC-MEV)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RPpym8ATWG4GLuorjcU9BUj8KQC2.....48'),
('Université des Jeunes Filles -(UJF)', 'Bassam', 'Bassam', NULL, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/271309428_119860680546926_6830508870677081045_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeE4xVxNbM6CIwYa4D_iLIlgegdtqPfN0eB6B22o983R4N_1sYxgR7I1bNA9y8P3ladKaGMkkKkShssVjY0FsmBI&_nc_ohc=WPh5eMv1_pUAX_l9Jmy&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfDFSYdBnDMX83s-xJURG-ebwkxlZDclHZxQqKw2VCYTcQ&oe=65805EFA'),
('Université des Sciences Appliquées et de Gestion -(USAG)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RKobi9aAD24GLuorjcU9BUj8KQC2.....08'),
('Université des Sciences et Technologie de Côte d’Ivoire Cocody -(USTCI Cocody)', 'Abidjan', 'Cocody', 450000, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/391700801_800307701895650_5586363833590785501_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeG7gfYorzXkwMfdS80yIJziwmkrg-DPDcLCaSuD4M8NwqnNjXhivrYsvNpILSUBepWajUB2GuqmR8DDvgfl5GfX&_nc_ohc=WZmka3T7ZnAAX-_Ofmr&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfDlQ7c9tZosD52E0hCwEtfAIYxRFo0oHyE9V_kfMoAh2w&oe=6581B038'),
('Université des Sciences et Technologies d’Abidjan (USTA)', 'Abidjan', 'Marcory', NULL, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/391700801_800307701895650_5586363833590785501_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeG7gfYorzXkwMfdS80yIJziwmkrg-DPDcLCaSuD4M8NwqnNjXhivrYsvNpILSUBepWajUB2GuqmR8DDvgfl5GfX&_nc_ohc=WZmka3T7ZnAAX-_Ofmr&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfDlQ7c9tZosD52E0hCwEtfAIYxRFo0oHyE9V_kfMoAh2w&oe=6581B038'),
('Université des Sciences Juridiques, Economiques et de Gestion (UJSEG)', 'Abidjan', 'Cocody', 100000, 'Voir la liste des filières', 'https://th.bing.com/th/id/OIP.y-hyxo1rVd-6Rd72p8nvVAHaFO?rs=1&pid=ImgDetMain'),
('Université Ephrata -(UE)', 'Abidjan', 'Riviera', 125000, 'Voir la liste des filières', 'https://th.bing.com/th/id/R.b6bb6e7942b3d9e11aae4f1436ed1fe6?rik=9pn%2f6yHpdDR4XQ&riu=http%3a%2f%2funiversiteephrata.ci%2fcssjs%2fimages%2fglance%2f2.jpg&ehk=oAz4HUFlBr94b2V%2fHL%2bpUcBjDrF0qx365z0X1Cq07tc%3d&risl=&pid=ImgRaw&r=0'),
('Université Évangélique Internationale de Man -(UEIM)', 'Man', 'Man', 75000, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/314404830_502410601904168_7271826620241262783_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeEolWfAzuqkP-JkmWeI8DwEd5F8rHpzhMx3kXysenOEzIQHToBYE8yl3lEGfD-_7LMeJyqlneLH4VndoRLa-rb5&_nc_ohc=3iA1bqvqVMoAX-_qUt_&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfAlKk-IP-5K3EeQxvObEeNEvg67_mhs6AA1poE8HACUUA&oe=6581890D'),
('Université Française d’Afrique Francophone/ Collège Universitaire Français d’Abidjan (UFAF/CUFA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://edukiya.com/wp-content/uploads/2022/02/UFRA-Universite-francaise-dAbidjan-cote-divoire-etudes-afrique-formations-6.jpg'),
('Université Française d’Abidjan -(UFRA)', 'Abidjan', 'Plateau', NULL, 'Voir la liste des filières', 'https://edukiya.com/wp-content/uploads/2022/02/UFRA-Universite-francaise-dAbidjan-cote-divoire-etudes-afrique-formations-6.jpg'),
('Université Henry Dunant -(UHD)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/358628097_731789892287761_794278047875026569_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeGSlLo8Y9rf3wQqyPL_tDL6_lfZDEzxd7z-V9kMTPF3vNWz7dkkG6y7i1sNIF1vraXtPDTUDmroYDjdbEyVhfvF&_nc_ohc=MosnyOZIjJkAX-Jgesk&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfCBYojBPbv3Yl83ohYoBdtBf0habgVJsq3rtkq40ZBPSw&oe=6581490A'),
('UNIVERSITE HUBERT VANGAH -(UVHK)', 'BONOUA', 'BONOUA', 165000, 'VOIR LA LISTE DES FILIERES', 'https://ulagunes.com/storage/articles/Qyreq1WixcVIieOhvwIJHeqWsAbOR0UMSuUh3tJg.jpg'),
('UNIVERSITE INTERNATIONALE ABIDJAN -(UIA)', 'ABIDJAN', 'COCODY', 450000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/292448349_472797751516610_997918010960583876_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=efb6e6&_nc_eui2=AeGbiojVJeeNcvIHijuTtwZG8w1-KHpZ-zLzDX4oeln7MuinxjWoiZxjcJ-Q4NQJiLuSJCXfJ8_MG0kx3qhdRR2W&_nc_ohc=feaIP0Wv6ikAX_hvHMG&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfAH0MtpXT5hA18OZ_CK3_V7ZnA6KNXD2p2gkKGSMJRQXQ&oe=6588F2E8' ),
('UNIVERSITE INTERNATIONALE BILINGUE AFRICAINE -(UIBA)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj2-1.fna.fbcdn.net/v/t31.18172-8/11222217_822595674500635_6632186034389574777_o.jpg?_nc_cat=107&ccb=1-7&_nc_sid=2be8e3&_nc_eui2=AeHE1T-Jr-sQQvyObt9R8CWbPyDcLM-YELs_INwsz5gQu0cm9G2jLQKeayD0ZgGYfPSIivQyuNc8nzVvKPik0ndP&_nc_ohc=P1YVpfT2xQwAX_Ip7Ki&_nc_ht=scontent.fabj2-1.fna&oh=00_AfBzPZB02UWkDizRdHL0WztyiONVIAQZB7c_9JXYKqZ-rw&oe=65A33868'),
('UNIVERSITE INTERNATIONALE CLAIRE FONTAINE (UICF)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj2-1.fna.fbcdn.net/v/t39.30808-6/305913676_1211173512996316_31248993634348607_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeFO0IxMt5Mq-2lrbjohhDBf5rhJ7Xv-G2DmuEnte_4bYIDrZaf1Q_CJ9mHKnDU2jirHPG7R8H1OBD5EN1nXMSXh&_nc_ohc=LM8r2gzggl8AX9rrEfv&_nc_zt=23&_nc_ht=scontent.fabj2-1.fna&oh=00_AfD8PhUcbbEE8QrwMTYLaEz38vkA0ZSq4I7nGWFmJp6qeQ&oe=65807C57'),
('UNIVERSITE INTERNATIONALE DE BOUAKE (UIB)', 'BOUAKE', 'BOUAKE', NULL, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/OIP.uUErCoyCU3O8BTgg4OfVSAHaER?rs=1&pid=ImgDetMain'),
('UNIVERSITE INTERNATIONALE DE COCODY -(UIC)', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/OIP.uUErCoyCU3O8BTgg4OfVSAHaER?rs=1&pid=ImgDetMain'),
('UNIVERSITE INTERNATIONALE DE COTE D’IVOIRE -(UICI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj2-1.fna.fbcdn.net/v/t39.30808-6/328959581_1465083007353173_8939032188132012615_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeEpicld7CiwdoOj2LaCWbrlOELX7mRyaHE4QtfuZHJocdpeEY8Cx36SeAZ1-9G-2HueihzRuiZoJ0JSRrstOnMM&_nc_ohc=YqKnZ0JEVXIAX-IoTgV&_nc_zt=23&_nc_ht=scontent.fabj2-1.fna&oh=00_AfBATxb68p-jCGBmH51qX6Ky4Sz7_uAV6FjJw5m_mTIEPA&oe=65815EAD'),
('UNIVERSITE INTERNATIONALE DE YAMOUSSOUKRO -(UIYA)', 'YAMOUSSOUKRO', 'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RPfJtfchfG8GLuorjcU9BUj8KQC2.....64'),
('Université Internationale des Sciences et Technologie -(UIST)', 'Abidjan', 'Cocody', 250000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RNw-FRc2CG8GLuorjcU9BUj8KQC2.....8Y'),
('Université Internationale Evangélique de Côte d’Ivoire (UIECI)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RNvCxbC9yG8GLuorjcU9BUj8KQC2.....yc'),
('Université Internationale François (UIF)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES', 'https://lh3.googleusercontent.com/p/AF1QipNxyWKALJqX8m_bLBsC8OEozX4xnQPq9xe1I2Ka=w600-h0'),
('Université Internationale Nayeba (UNID)', 'Abidjan', 'Dabou', 85000, 'VOIR LA LISTE DES FILIERES', 'https://nayeba.net/wp-content/uploads/2022/08/IMG-20220815-WA0052.jpg'),
('Université Internationale Privée d’Abidjan -(UIPA)', 'Abidjan', 'Riviera', 85000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=ROALn.lWGW8GLuorjcU9BUj8KQC2.....xU'),
('Université Methodiste de Côte d’Ivoire -(UMECI)', 'Abidjan', 'Cocody', 210000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/359474248_697974089007133_3150949264015371662_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeEyNF8p8mPpapxJp3kg6gHp3aQhFKQhV-TdpCEUpCFX5GNfMY5jnmzOj0admip5SgX4K_G1Vvqa2zIVKT-TM188&_nc_ohc=Nv-2mUJAg-wAX9CpwMK&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfCLXzMMicq9s9vGqtnYe-PHbTnEDtVQ4i48nSL8gJAEqQ&oe=6581E3AA'),
('Université Métropolitaine d’Abidjan -(UMA-GC)', 'Abidjan', 'Plateau', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RPJiob2RWG8GLuorjcU9BUj8KQC2.....xo'),
('Université Musulmane Africaine -(UMA)', 'Abidjan', 'Cocody', 85000, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RAzn-4gC6m8GLuorjcU9BUj8KQC2.....1o'),
('Université Nanan Yamousso (U NANAN YAMOUSSO)', 'Bouaké', 'Bouaké', NULL, 'VOIR LA LISTE DES FILIERES', 'https://st.depositphotos.com/1011643/3007/i/950/depositphotos_30073485-stock-photo-group-of-african-college-students.jpg'),
('UNIVERSITE NBA -(U-NBA)', 'Abidjan', 'Cocody', 100000, 'Voir la liste des filières', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/239093027_1059123057960012_5208473243910379261_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeFnF2J98S0ZGd5pS4BVOf8yRdX-6mF0UuxF1f7qYXRS7Fpf9zhPgZN2pTRx6u1uIpTBSeNIjpc5hGoKV8l1bXzq&_nc_ohc=TUlj7TCXj_UAX8IZeHG&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfD63a1n8iY_A6YXPZKXBhPv9Lu29Ju6AxoOFKABeNdgbQ&oe=6588E642'),
('UNIVERSITE NORD SUD ANGRE', 'Abidjan', 'Cocody', 120000, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RFpPd06ZAG8GLuorjcU9BUj8KQC2.....-4'),
('UNIVERSITE NOTRE DAME D’ABIDJAN -(UNDA)', 'Abidjan', 'Abobo', 250000, 'Voir la liste des filières', 'https://www.bing.com/images/blob?bcid=RG83q8aiBW8GLuorjcU9BUj8KQC2.....-c'),
('UNIVERSITE OUEST AFRICAINE -(UOA)', 'ABIDJAN', 'RIVIERA', NULL, 'VOIR LA LISTE DES FILIERES', 'https://www.bing.com/images/blob?bcid=RBZ1RB4M6m8GLuorjcU9BUj8KQC2.....zA'),
('UNIVERSITE POLYTECHNIQUE DE BINGERVILLE -(UPB)', 'ABIDJAN', 'BINGERVILLE', 85000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t1.6435-9/51477566_1036436486541639_579779641036767232_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=300f58&_nc_eui2=AeEHhfBQjH8yKZgQu_90yKZfCaLLFEPK0UEJossUQ8rRQY7Hq-wzZ0Hba7D-ns7jdqALTwTyayT-sApSn7oot3kZ&_nc_ohc=hqVuHO671JEAX9v7Nn_&_nc_ht=scontent.fabj1-1.fna&oh=00_AfC5KI2dIyKS2clHtdBe7Nm6yx9U00AW23kxhDbb-t5jSw&oe=65ABB150'),
('UNIVERSITE POLYTECHNIQUE KIBIO -(UPK)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/385815911_810038871128032_6804048710259501489_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeHmwahe5A9eMGV5lQB7fo3_x7SiW85K-P3HtKJbzkr4_REGIBZpbNkqlx-V9XCyILR-6wR8xoY5tjRDf8A3orDI&_nc_ohc=Y5Ya8EtsPGcAX9CG--F&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfCZflEDNtxkRfLrCMrGA5ST36DX73G622AKJZ-fgfE7kg&oe=65890BE9'),
('UNIVERSITE PRIVE N’TAYE (UPN)', 'ABIDJAN', 'TREICHVILLE', NULL, 'VOIR LA LISTE DES FILIERES', 'https://media-files.abidjan.net/photo/Universite-privee.jpg'),
('UNIVERSITE PRIVEE AGRICOLE DE COTE D’IVOIRE (UPRACI)', 'ADZOPE', 'ADZOPE', NULL, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/OIP.mqSi0LI2ntFr2cOgElM34AHaEK?rs=1&pid=ImgDetMain'),
('UNIVERSITE PRIVEE INTERNATIONALE AKANDJI (UPIA)', 'ABIDJAN', 'COCODY', 300000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/236320500_195080656015713_6038025622431071858_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeGlw4IZGjxxJLikxh42eU1BuIkNHcSvCdW4iQ0dxK8J1bPEZA1lHWVXW2YrjzpORW6yRqX8ze-qgzUSKuuYCYU9&_nc_ohc=JVAdmAtudfwAX9MS_jS&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfBT3AqIHu0z89p5dpniaOZIlNRHltLql4ZRfTRAiOPtbw&oe=658989D6'),
('UNIVERSITE PRIVEE SOUMARE -(UNIVERSITE SOUMARE)', 'ABIDJAN', 'COCODY', 50000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/284207018_308636808136755_942981316138926801_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=3635dc&_nc_eui2=AeEh5XxjJ6aZsnbk8JiVKEn2Z-LlZDMW2vNn4uVkMxba813LfOHiYUpPbRKuEdl2s6Xjcr1NFzfQ01Y5y4DilQPz&_nc_ohc=U478E67zdVQAX8-LPmu&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfB7a_wnoZGNVnLPMJluk5Z_-p15D_ZuPbT9gINspHkpdQ&oe=65893952'),
('UNIVERSITE SAINT PAUL (USP)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES', 'https://universitesaintpaul.org/assets/img/usp.png'),
('UNIVERSITE SEPI -(US)', 'ABIDJAN', 'YOPOUGON', 120000, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/R.ef1976410d7b058dc199f7a405dd2304?rik=OBcCxeZP1d6uaw&pid=ImgRaw&r=0'),
('Université Tahaqa Sarê – UNISS (Université Internationale des Sciences Sociale Hampâté Bâh )', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/OIP.7NpB76vvA6jcr7brV_2gRgHaE4?rs=1&pid=ImgDetMain'),
('UNIVERSITE TERTIAIRE ET TECHNOLOGIE LOKO -(UTT-LOKO)', 'ABIDJAN', 'MARCORY', 85000, 'VOIR LA LISTE DES FILIERES', 'https://www.koaci.com/assets/news/thumbnails/1500/2022/08/photo_1661272337.JPG'),
('UNIVERSITE VAME DE BOUAKE (UVB)', 'BOUAKE', 'BOUAKE', NULL, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/OIP.Q-etSdiSVLQXbPC8j9noygHaE3?rs=1&pid=ImgDetMain'),
('UNIVERSITE VIRTUELLE PANAFRICAINE DE TECHNOLOGIE -(UVPT)', 'ABIDJAN', 'COCODY', 450000, 'VOIR LA LISTE DES FILIERES', 'https://www.uvpt.university/images/comm_universitaire_de_rusta.png'),
('UNIVERSITY OF ABIDJAN -(UNIABIDJAN)', 'ABIDJAN', 'COCODY', 95000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/380652337_786830543451825_2835291429920760333_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeFUiEfOl5FHrwzdZ0hjwCiz_PzWch4h1K38_NZyHiHUrTf-vU847IzFUelWCyNriXesG-sI1BDLzt7dH-8tNiMt&_nc_ohc=LtoWj3djfjAAX8oDqJi&_nc_oc=AQn1bofmCQaGKsmcYKrJ5jW9YPDg9rnZ_g-z1A2MebJf5SnchbqYjAheRMeq_bGn4Vo&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfBpYGgSZdmqyKykmwXcqyO3ZhdVsgLuQJexrja4noLhGg&oe=658A34CD'),
('UNVERSITE CANADIENNE DES ARTS DES SCIENCES ET DU MANAGEMENT -(UCASM)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES', 'https://edukiya.com/wp-content/uploads/2020/05/Universit%C3%A9-Canadienne-arts-sciences-management-UCASM-formation-Abidjan-3.jpg'),
('Université Al Fourqane de Cote d’Ivoire -(UFCI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/379006483_122117501894024518_4955268925114976710_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeGr1LPX1ekWjDHgVVxfz05lWqIQNnsBDdlaohA2ewEN2UeQC4R0_jaJ9Vr6uLlHxr2lgPPZQi8KKjJqRXXSMvv3&_nc_ohc=vb3uXHzR2fgAX-0laA0&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfBtKPmG8HV3agFkDfX9zjidPo_WoLeY8iI3rGDA9z8STg&oe=6588C10F'),
('Université Internationale ICK – U2ICK', 'BOUAKE', 'BOUAKE', 200000, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/312253472_543306431138894_4615372935466133335_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=dd5e9f&_nc_eui2=AeGzQaAyAPHwEP_rtSwBpUGu-IXZi1ATTg34hdmLUBNODVdIg4JdgJgzRYDkLO2j0XKuHhOFydXe6wFpBcznhaEk&_nc_ohc=ZAlZAtXrBh4AX-9vIFM&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfD_MNbzD1OqOgmxX0KQsgyTW4_RAjL2gptGaIhiPVaMaw&oe=658A27C1'),
('Université Internationale des Sciences Appliquées et de Technologies – UNISAT (UNIV)', 'ABIDJAN', 'COCODY', 200000, 'VOIR LA LISTE DES FILIERES', 'https://th.bing.com/th/id/R.c25efb581a1f2c0979ebba025f051432?rik=Qp3CpVaBdcgKTg&riu=http%3a%2f%2fwww.unisat-ci.com%2fassets%2fimg%2flogo.png&ehk=7lLNvQ3mejjC4vKjFTpBf5jmCkk%2bpHbXdAJ5AYFaR6c%3d&risl=&pid=ImgRaw&r=0'),
('VALORIS INTERNATIONAL UNIVERSITY -(VIU)', 'ABIDJAN', 'Aucune information', NULL, 'VOIR LA LISTE DES FILIERES', 'https://scontent.fabj1-1.fna.fbcdn.net/v/t39.30808-6/237608200_3993639647430872_1939330595914093770_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeEGPX6PPYVhiOKWKN0Q2gnMFdJSnxsTiiMV0lKfGxOKI-a39Ueid0-9c89BdVanRJktCtQXQvlwQh8JQp7NEJ1t&_nc_ohc=rpSUwr7sfgUAX-S2wIF&_nc_zt=23&_nc_ht=scontent.fabj1-1.fna&oh=00_AfDzpBEsjrnMkWGElowkNCsN9OuCXOj6Wau_0tLXeTojcg&oe=658A421C');
