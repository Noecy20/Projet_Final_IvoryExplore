CREATE DATABASE IvoryExplore

CREATE TABLE historique (
    id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
    recherche VARCHAR(25) NOT NULL
);

CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	nom_user VARCHAR(50) NOT NULL,
	prenom_user VARCHAR(50) NOT NULL,
    username VARCHAR(10) NOT NULL,
	email VARCHAR(30) NOT NULL,
    passwords VARCHAR(255) NOT NULL
);

CREATE TABLE universites1 (
    ID INT PRIMARY KEY IDENTITY (1,1),
    Etablissement VARCHAR(255),
    Ville VARCHAR(255),
    Commune VARCHAR(255),
    MontantDesFraisDInscription INT,
    ListeDesFilieres VARCHAR(255),
	lien_image_ecole VARCHAR(255)
);
CREATE TABLE hotel (
    id_hotel INT PRIMARY KEY,
    nom VARCHAR(255),
    localisation VARCHAR(255),
	lien_image_hotel VARCHAR(255)
);
BULK INSERT hotel
FROM 'C:\Users\HP\hotel.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2  -- Si la première ligne du CSV est un en-tête, sinon, supprimez cette ligne
);
select * from hotel
select * from restaurant 
select * from universites1
select * from users

CREATE TABLE restaurant (
    id_resto INT PRIMARY KEY,
    nom_resto VARCHAR(255),
    localisation VARCHAR(255),
	ville_ou_commune VARCHAR(255),
	spécialité VARCHAR(255),
	téléphone VARCHAR(255),
	lien_image_resto VARCHAR(255)
);

BULK INSERT restaurant
FROM 'C:\Users\HP\restaurant_ci.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2  -- Si la première ligne du CSV est un en-tête, sinon, supprimez cette ligne
);


INSERT INTO universites1 (Etablissement, Ville, Commune, MontantDesFraisDInscription, ListeDesFilieres)
VALUES 
('AMERICAN UNIVERSITY OF COTE D’IVOIRE -(AUCI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('BORDEAUX ECOLE DE MANAGEMENT -(BEM Abidjan)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('CENTRE UNIVERSITAIRE PROFESSIONNALISE -(CUP)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('CERAP/UNIVERSITE JESUITE -(CERAP/UJ)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('DEMING EXCELLENCE INSTITUTE -(DEI)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE D’ARCHITECTURE D’ABIDJAN -(EAA)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE D’INTERPRETARIAT ET DE TRADUCTION -(ESIT)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE DES PROFESSIONS IMMOBILIERES -(ESPI)', 'ABIDJAN', 'COCODY', 55000, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE GADJI_UNIVERSITÉ -(ESUG_UNIVERSITÉ)', 'ABIDJAN', 'PLATEAU', 250000, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE LE PETIT CHAMPION_UNIVERSITE -(ESPC_UNIVERSITE)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE PLURIDISCIPLINAIRE D’ABIDJAN COCODY -(ESPA COCODY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE PLURIDISCIPLINAIRE D’ABIDJAN/YAMOUSSOUKRO -(ESPA YAMOUSSOUKRO)',	'YAMOUSSOUKRO',	'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE TECHNIQUE INFORMATIQUE ET COMMERCIALE-UNIVERSITY -(ETIC-UNIVERSITY)', 'ABIDJAN', 'COCODY', NULL,	'VOIR LA LISTE DES FILIERES'),
('EMMAUS INTERNATIONAL UNIVERSITY -(EIU)', 'ABIDJAN', 'COCODY', NULL,'VOIR LA LISTE DES FILIERES'),
('FACULTES UNIVERSITAIRES PRIVEES D’ABIDJAN -(FUPA)',	'ABIDJAN',	'COCODY',	165000,	'VOIR LA LISTE DES FILIERES'),
('GLOBAL NUMERIK UNIVERSITY -(GNU)',	'ABIDJAN',	'COCODY',	85000,	'VOIR LA LISTE DES FILIERES'),
('HAUTES ETUDES COMMERCIALES D’ABIDJAN -(HEC-ABIDJAN)',	'ABIDJAN',	'COCODY',	175000,	'VOIR LA LISTE DES FILIERES'),
('INSITUT SUPERIEUR D’INGENIERIE ET DE SANTE YAMOUSSOUKRO -(ISIS YAMOUSSOUKRO)',	'YAMOUSSOUKRO',	'YAMOUSSOUKRO',	85000,	'VOIR LA LISTE DES FILIERES'),
('INSTITIES-LE CAMPUS COCODY_UNIVERSITEUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS COCODY -(IES-LE CAMPUS COCODY)',	'ABIDJAN', NULL, NULL,	'VOIR LA LISTE DES FILIERES'),
('INSTITUT CATHOLIQUE MISSIONNAIRE D’ABIDJAN -(ICMA)',	'ABIDJAN',	'ABOBO',	NULL,	'VOIR LA LISTE DES FILIERES'),
('INSTITUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS COCODY_UNIVERSITE -(IES-LE CAMPUS COCODY_UNIVERSITE)',	'ABIDJAN',	'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS MAN_UNIVERSITE -(IES-LE CAMPUS MAN_UNIVERSITE)', 'MAN', 'MAN', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT D’ENSEIGNEMENT SUPERIEUR LE CAMPUS YOPOUGON_UNIVERSITE -(IES-LE CAMPUS YOPOUGON_UNIVERSITE)', 'ABIDJAN', 'YOPOUGON', '', 'VOIR LA LISTE DES FILIERES'),
('INSTITUT DE MANAGEMENT ET DES TECHNOLOGIES -(IMAT)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT EUROPEEN DES AFFAIRES -(IEA-ABIDJAN)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT IES-LE CAMPUS COCODY_UNIVERSITESUPERIEUR LE CAMPUS COCODY -(IES-LE CAMPUS COCODY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT INTERNATIONAL D’ADMINISTRATION ET DE MANAGEMENT -(2IAM)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT IVOIRIEN DE TECHNOLOGIE -(IIT)', 'BASSAM', 'BASSAM', 50000, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT SUPERIEUR D’INGENIERIE ET DE SANTE COCODY -(ISIS COCODY)', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT SUPERIEUR UNIVERSITAIRE POLYTECHNIQUE ACKA EWADJO CECILE -(ISUPEC)', 'GRAND LAHOU', 'GRAND LAHOU', 140000, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT UNIVERSITAIRE Abidjan -(IUA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire Abidjan-Bluetooth -(IUA-Bluetooth)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire Abidjan-Bonoumin -(IUA-Bonoumin)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire Abidjan-Zinsou -(IUA-Zinsou)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire des Sciences Economiques Juridiques et du Développement Durable (IUSEJDD)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire des Sciences Economiques, Juridiques et du Développement Durable -(IUSEJ2D)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire du Sud -(IUS)', 'Jacqueville', 'Jacqueville', NULL, 'Voir la liste des filières'),
('Institut Universitaire Fred et Poppée', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire Polytechnique Abidjan YOPOUGON_UNIVERSITE -(IUPA YOPOUGON_UNIVERSITE)', 'Abidjan', 'Yopougon', NULL, 'Voir la liste des filières'),
('Institut Universitaire Professionnalisé (IUP)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut International Polytechnique des Elites Abidjan COCODY -(IIPEA COCODY)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Institut Universitaire Saint Jean-Paul II', 'Yamoussoukro', 'Yamoussoukro', NULL, 'Voir la liste des filières'),
('POLE D’EXCELLENCE ET DE SPECIALISATIONS (PES)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('RUSTA UNIVERSITE -(RUSTA UNIVERSITE)', 'Abidjan', 'Cocody', 450000, 'Voir la liste des filières'),
('RUSTA UNIVERSITE ANNEXE DE BOUAKE', 'Bouaké', 'Bouaké', 85000, 'Voir la liste des filières'),
('SEEKA UNIVERSITY -(Seeka U)', 'Yamoussoukro', 'Yamoussoukro', 100000, 'Voir la liste des filières'),
('SWISS UMEF UNIVERSITY OF COTE D’IVOIRE -(UMEF)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('TG MASTER-UNIVERSITY -(TGM-U)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('UNIVERSITE ADAMA SANOGO -(UAS)', 'Abidjan', 'Abobo', NULL, 'Voir la liste des filières'),
('UNIVERSITE BILINGUE LA CORNICHE -(UBC)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université Catholique d’Afrique de l’Ouest-Unité Universitaire d’Abidjan', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université Centrale Chaare Tsedek', 'Daloa', 'Daloa', NULL, 'Voir la liste des filières'),
('Université Charles-Louis de Montesquieu Cocody-Université', 'Abidjan', 'Cocody', 350000, 'Voir la liste des filières'),
('Université de l’Entrepreneuriat (UE-Azaguié)', 'Azaguié', 'Azaguié', NULL, 'Voir la liste des filières'),
('Université de l’Alliance Chrétienne d’Abidjan (UACA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université de l’Atlantique Bouaké -(UA Bouaké)', 'Bouaké', 'Bouaké', 55000, 'Voir la liste des filières'),
('Université de l’Atlantique Cocody -(UA Cocody)', 'Abidjan', 'Cocody', 125000, 'Voir la liste des filières'),
('Université de Technologie d’Abidjan -(UTA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université des Innovations Culturelles et des Métiers du Virtuel -(UIC-MEV)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université des Jeunes Filles -(UJF)', 'Bassam', 'Bassam', NULL, 'Voir la liste des filières'),
('Université des Sciences Appliquées et de Gestion -(USAG)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université des Sciences et Technologie de Côte d’Ivoire Cocody -(USTCI Cocody)', 'Abidjan', 'Cocody', 450000, 'Voir la liste des filières'),
('Université des Sciences et Technologie de Côte d’Ivoire Yopougon -(USTCI Yopougon)', 'Abidjan', 'Yopougon', 450000, 'Voir la liste des filières'),
('Université des Sciences et Technologies d’Abidjan (USTA)', 'Abidjan', 'Marcory', NULL, 'Voir la liste des filières'),
('Université des Sciences Juridiques, Economiques et de Gestion (UJSEG)', 'Abidjan', 'Cocody', 100000, 'Voir la liste des filières'),
('Université Ephrata -(UE)', 'Abidjan', 'Riviera', 125000, 'Voir la liste des filières'),
('Université Évangélique Internationale de Man -(UEIM)', 'Man', 'Man', 75000, 'Voir la liste des filières'),
('Université Française d’Afrique Francophone/ Collège Universitaire Français d’Abidjan (UFAF/CUFA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('Université Française d’Abidjan -(UFRA)', 'Abidjan', 'Plateau', NULL, 'Voir la liste des filières'),
('Université Henry Dunant -(UHD)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des filières'),
('UNIVERSITE HUBERT VANGAH -(UVHK)', 'BONOUA', 'BONOUA', 165000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE CONCORDET -(UIC)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE ABIDJAN -(UIA)', 'ABIDJAN', 'COCODY', 450000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE BILINGUE AFRICAINE -(UIBA)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE CLAIRE FONTAINE (UICF)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE CLAIREFONTAINE -(UICF)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE BOUAKE (UIB)', 'BOUAKE', 'BOUAKE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE COCODY -(UIC)', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE COTE D’IVOIRE -(UICI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE YAMOUSSOUKRO -(UIYA)', 'YAMOUSSOUKRO', 'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale des Sciences et Technologie -(UIST)', 'Abidjan', 'Cocody', 250000, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale Evangélique de Côte d’Ivoire (UIECI)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale François (UIF)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale François -(UIF)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale Nayeba (UNID)', 'Abidjan', 'Dabou', 85000, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale Privée d’Abidjan -(UIPA)', 'Abidjan', 'Riviera', 85000, 'VOIR LA LISTE DES FILIERES'),
('Université Methodiste de Côte d’Ivoire -(UMECI)', 'Abidjan', 'Cocody', 210000, 'VOIR LA LISTE DES FILIERES'),
('Université Métropolitaine d’Abidjan -(UMA-GC)', 'Abidjan', 'Plateau', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Musulmane Africaine -(UMA)', 'Abidjan', 'Cocody', 85000, 'VOIR LA LISTE DES FILIERES'),
('Université Nanan Yamousso (U NANAN YAMOUSSO)', 'Bouaké', 'Bouaké', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE NBA -(U-NBA)', 'Abidjan', 'Cocody', 100000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD ANGRE', 'Abidjan', 'Cocody', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD ANGRE -(UNS ANGRE)', 'Abidjan', 'Cocody', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD BOUAKE -(UNS BOUAKE)', 'Bouaké', 'Bouaké', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD COCODY -(UNS COCODY)', 'Abidjan', 'Cocody', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD DIMBOKRO -(UNS DIMBOKRO)', 'Dimbokro', 'Dimbokro', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD MARCORY -(UNS MARCORY)', 'Abidjan', 'Marcory', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD PORT-BOUËT -(UNS PORT-BOUËT)', 'Abidjan', 'Port Bouët', 120000, 'Voir la liste des filières'),
('UNIVERSITE NORD SUD YOPOUGON -(UNS YOPOUGON)', 'Abidjan', 'Yopougon', 120000, 'Voir la liste des filières'),
('UNIVERSITE NOTRE DAME D’ABIDJAN -(UNDA)', 'Abidjan', 'Abobo', 250000, 'Voir la liste des filières'),
('UNIVERSITE OUEST AFRICAINE -(UOA)', 'ABIDJAN', 'RIVIERA', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE POLYTECHNIQUE DE BINGERVILLE -(UPB)', 'ABIDJAN', 'BINGERVILLE', 85000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE POLYTECHNIQUE KIBIO -(UPK)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVE N’TAYE (UPN)', 'ABIDJAN', 'TREICHVILLE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVEE AGRICOLE DE COTE D’IVOIRE (UPRACI)', 'ADZOPE', 'ADZOPE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVEE INTERNATIONALE AKANDJI (UPIA)', 'ABIDJAN', 'COCODY', 300000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVEE SOUMARE -(UNIVERSITE SOUMARE)', 'ABIDJAN', 'COCODY', 50000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PROTESTANTE EVANGELIQUE DE COTE D’IVOIRE -(UPE-CI)', 'YAMOUSSOUKRO', 'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE SAINT PAUL (USP)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE SEPI -(US)', 'ABIDJAN', 'YOPOUGON', 120000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE TAHARQA SARE -(UTS)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE TERTIAIRE ET TECHNOLOGIE LOKO -(UTT-LOKO)', 'ABIDJAN', 'MARCORY', 85000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE VAME DE BOUAKE (UVB)', 'BOUAKE', 'BOUAKE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE VIRTUELLE PANAFRICAINE DE TECHNOLOGIE -(UVPT)', 'ABIDJAN', 'COCODY', 450000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITY OF ABIDJAN -(UNIABIDJAN)', 'ABIDJAN', 'COCODY', 95000, 'VOIR LA LISTE DES FILIERES'),
('UNVERSITE CANADIENNE DES ARTS DES SCIENCES ET DU MANAGEMENT -(UCASM)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Al Fourqane de Cote d’Ivoire -(UFCI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale ICK – U2ICK', 'BOUAKE', 'BOUAKE', 200000, 'VOIR LA LISTE DES FILIERES'),
('Université Internationale des Sciences Appliquées et de Technologies – UNISAT (UNIV)', 'ABIDJAN', 'COCODY', 200000, 'VOIR LA LISTE DES FILIERES'),
('Université Populaire de Cote d’Ivoire (UPCI)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('Université Tahaqa Sarê – UNISS (Université Internationale des Sciences Sociale Hampâté Bâh )', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES'),
('VALORIS INTERNATIONAL UNIVERSITY -(VIU)', 'ABIDJAN', 'Aucune information', NULL, 'VOIR LA LISTE DES FILIERES');

