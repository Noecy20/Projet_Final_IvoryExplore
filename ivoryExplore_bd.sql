CREATE DATABASE ivoryExplore

CREATE TABLE historique (
    id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
    recherche VARCHAR(25) NOT NULL
);



CREATE TABLE users (
    id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
	nom_user VARCHAR(50) NOT NULL,
	prenom_user VARCHAR(50) NOT NULL,
    username VARCHAR(10) NOT NULL,
	email VARCHAR(30) NOT NULL UNIQUE,
    passwords VARCHAR(225) NOT NULL
);

CREATE TABLE preference (
    id_preference INT PRIMARY KEY identity(1,1),
    interests text  not null ,
    id_user  int  not null,
	CONSTRAINT user_interests_fk
    FOREIGN KEY (id_user)
    REFERENCES users (id)
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
FROM 'C:\Users\CAMARA\Documents\hotel.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2  -- Si la premi�re ligne du CSV est un en-t�te, sinon, supprimez cette ligne
);
select * from hotel 
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
FROM 'C:\Users\CAMARA\Documents\restaurant_ci.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2  -- Si la premi�re ligne du CSV est un en-t�te, sinon, supprimez cette ligne
);


INSERT INTO universites1 (Etablissement, Ville, Commune, MontantDesFraisDInscription, ListeDesFilieres)
VALUES 
('AMERICAN UNIVERSITY OF COTE D�IVOIRE -(AUCI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('BORDEAUX ECOLE DE MANAGEMENT -(BEM Abidjan)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('CENTRE UNIVERSITAIRE PROFESSIONNALISE -(CUP)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('CERAP/UNIVERSITE JESUITE -(CERAP/UJ)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('DEMING EXCELLENCE INSTITUTE -(DEI)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE D�ARCHITECTURE D�ABIDJAN -(EAA)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE D�INTERPRETARIAT ET DE TRADUCTION -(ESIT)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE DES PROFESSIONS IMMOBILIERES -(ESPI)', 'ABIDJAN', 'COCODY', 55000, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE GADJI_UNIVERSIT� -(ESUG_UNIVERSIT�)', 'ABIDJAN', 'PLATEAU', 250000, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE LE PETIT CHAMPION_UNIVERSITE -(ESPC_UNIVERSITE)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE PLURIDISCIPLINAIRE D�ABIDJAN COCODY -(ESPA COCODY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE SUPERIEURE PLURIDISCIPLINAIRE D�ABIDJAN/YAMOUSSOUKRO -(ESPA YAMOUSSOUKRO)',	'YAMOUSSOUKRO',	'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES'),
('ECOLE TECHNIQUE INFORMATIQUE ET COMMERCIALE-UNIVERSITY -(ETIC-UNIVERSITY)', 'ABIDJAN', 'COCODY', NULL,	'VOIR LA LISTE DES FILIERES'),
('EMMAUS INTERNATIONAL UNIVERSITY -(EIU)', 'ABIDJAN', 'COCODY', NULL,'VOIR LA LISTE DES FILIERES'),
('FACULTES UNIVERSITAIRES PRIVEES D�ABIDJAN -(FUPA)',	'ABIDJAN',	'COCODY',	165000,	'VOIR LA LISTE DES FILIERES'),
('GLOBAL NUMERIK UNIVERSITY -(GNU)',	'ABIDJAN',	'COCODY',	85000,	'VOIR LA LISTE DES FILIERES'),
('HAUTES ETUDES COMMERCIALES D�ABIDJAN -(HEC-ABIDJAN)',	'ABIDJAN',	'COCODY',	175000,	'VOIR LA LISTE DES FILIERES'),
('INSITUT SUPERIEUR D�INGENIERIE ET DE SANTE YAMOUSSOUKRO -(ISIS YAMOUSSOUKRO)',	'YAMOUSSOUKRO',	'YAMOUSSOUKRO',	85000,	'VOIR LA LISTE DES FILIERES'),
('INSTITIES-LE CAMPUS COCODY_UNIVERSITEUT D�ENSEIGNEMENT SUPERIEUR LE CAMPUS COCODY -(IES-LE CAMPUS COCODY)',	'ABIDJAN', NULL, NULL,	'VOIR LA LISTE DES FILIERES'),
('INSTITUT CATHOLIQUE MISSIONNAIRE D�ABIDJAN -(ICMA)',	'ABIDJAN',	'ABOBO',	NULL,	'VOIR LA LISTE DES FILIERES'),
('INSTITUT D�ENSEIGNEMENT SUPERIEUR LE CAMPUS COCODY_UNIVERSITE -(IES-LE CAMPUS COCODY_UNIVERSITE)',	'ABIDJAN',	'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT D�ENSEIGNEMENT SUPERIEUR LE CAMPUS MAN_UNIVERSITE -(IES-LE CAMPUS MAN_UNIVERSITE)', 'MAN', 'MAN', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT D�ENSEIGNEMENT SUPERIEUR LE CAMPUS YOPOUGON_UNIVERSITE -(IES-LE CAMPUS YOPOUGON_UNIVERSITE)', 'ABIDJAN', 'YOPOUGON', '', 'VOIR LA LISTE DES FILIERES'),
('INSTITUT DE MANAGEMENT ET DES TECHNOLOGIES -(IMAT)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT EUROPEEN DES AFFAIRES -(IEA-ABIDJAN)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT IES-LE CAMPUS COCODY_UNIVERSITESUPERIEUR LE CAMPUS COCODY -(IES-LE CAMPUS COCODY)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT INTERNATIONAL D�ADMINISTRATION ET DE MANAGEMENT -(2IAM)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT IVOIRIEN DE TECHNOLOGIE -(IIT)', 'BASSAM', 'BASSAM', 50000, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT SUPERIEUR D�INGENIERIE ET DE SANTE COCODY -(ISIS COCODY)', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT SUPERIEUR UNIVERSITAIRE POLYTECHNIQUE ACKA EWADJO CECILE -(ISUPEC)', 'GRAND LAHOU', 'GRAND LAHOU', 140000, 'VOIR LA LISTE DES FILIERES'),
('INSTITUT UNIVERSITAIRE Abidjan -(IUA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Abidjan-Bluetooth -(IUA-Bluetooth)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Abidjan-Bonoumin -(IUA-Bonoumin)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Abidjan-Zinsou -(IUA-Zinsou)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire des Sciences Economiques Juridiques et du D�veloppement Durable (IUSEJDD)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire des Sciences Economiques, Juridiques et du D�veloppement Durable -(IUSEJ2D)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire du Sud -(IUS)', 'Jacqueville', 'Jacqueville', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Fred et Popp�e', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Polytechnique Abidjan YOPOUGON_UNIVERSITE -(IUPA YOPOUGON_UNIVERSITE)', 'Abidjan', 'Yopougon', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Professionnalis� (IUP)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut International Polytechnique des Elites Abidjan COCODY -(IIPEA COCODY)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Institut Universitaire Saint Jean-Paul II', 'Yamoussoukro', 'Yamoussoukro', NULL, 'Voir la liste des fili�res'),
('POLE D�EXCELLENCE ET DE SPECIALISATIONS (PES)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('RUSTA UNIVERSITE -(RUSTA UNIVERSITE)', 'Abidjan', 'Cocody', 450000, 'Voir la liste des fili�res'),
('RUSTA UNIVERSITE ANNEXE DE BOUAKE', 'Bouak�', 'Bouak�', 85000, 'Voir la liste des fili�res'),
('SEEKA UNIVERSITY -(Seeka U)', 'Yamoussoukro', 'Yamoussoukro', 100000, 'Voir la liste des fili�res'),
('SWISS UMEF UNIVERSITY OF COTE D�IVOIRE -(UMEF)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('TG MASTER-UNIVERSITY -(TGM-U)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('UNIVERSITE ADAMA SANOGO -(UAS)', 'Abidjan', 'Abobo', NULL, 'Voir la liste des fili�res'),
('UNIVERSITE BILINGUE LA CORNICHE -(UBC)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� Catholique d�Afrique de l�Ouest-Unit� Universitaire d�Abidjan', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� Centrale Chaare Tsedek', 'Daloa', 'Daloa', NULL, 'Voir la liste des fili�res'),
('Universit� Charles-Louis de Montesquieu Cocody-Universit�', 'Abidjan', 'Cocody', 350000, 'Voir la liste des fili�res'),
('Universit� de l�Entrepreneuriat (UE-Azagui�)', 'Azagui�', 'Azagui�', NULL, 'Voir la liste des fili�res'),
('Universit� de l�Alliance Chr�tienne d�Abidjan (UACA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� de l�Atlantique Bouak� -(UA Bouak�)', 'Bouak�', 'Bouak�', 55000, 'Voir la liste des fili�res'),
('Universit� de l�Atlantique Cocody -(UA Cocody)', 'Abidjan', 'Cocody', 125000, 'Voir la liste des fili�res'),
('Universit� de Technologie d�Abidjan -(UTA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� des Innovations Culturelles et des M�tiers du Virtuel -(UIC-MEV)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� des Jeunes Filles -(UJF)', 'Bassam', 'Bassam', NULL, 'Voir la liste des fili�res'),
('Universit� des Sciences Appliqu�es et de Gestion -(USAG)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� des Sciences et Technologie de C�te d�Ivoire Cocody -(USTCI Cocody)', 'Abidjan', 'Cocody', 450000, 'Voir la liste des fili�res'),
('Universit� des Sciences et Technologie de C�te d�Ivoire Yopougon -(USTCI Yopougon)', 'Abidjan', 'Yopougon', 450000, 'Voir la liste des fili�res'),
('Universit� des Sciences et Technologies d�Abidjan (USTA)', 'Abidjan', 'Marcory', NULL, 'Voir la liste des fili�res'),
('Universit� des Sciences Juridiques, Economiques et de Gestion (UJSEG)', 'Abidjan', 'Cocody', 100000, 'Voir la liste des fili�res'),
('Universit� Ephrata -(UE)', 'Abidjan', 'Riviera', 125000, 'Voir la liste des fili�res'),
('Universit� �vang�lique Internationale de Man -(UEIM)', 'Man', 'Man', 75000, 'Voir la liste des fili�res'),
('Universit� Fran�aise d�Afrique Francophone/ Coll�ge Universitaire Fran�ais d�Abidjan (UFAF/CUFA)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('Universit� Fran�aise d�Abidjan -(UFRA)', 'Abidjan', 'Plateau', NULL, 'Voir la liste des fili�res'),
('Universit� Henry Dunant -(UHD)', 'Abidjan', 'Cocody', NULL, 'Voir la liste des fili�res'),
('UNIVERSITE HUBERT VANGAH -(UVHK)', 'BONOUA', 'BONOUA', 165000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE CONCORDET -(UIC)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE ABIDJAN -(UIA)', 'ABIDJAN', 'COCODY', 450000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE BILINGUE AFRICAINE -(UIBA)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE CLAIRE FONTAINE (UICF)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE CLAIREFONTAINE -(UICF)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE BOUAKE (UIB)', 'BOUAKE', 'BOUAKE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE COCODY -(UIC)', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE COTE D�IVOIRE -(UICI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE INTERNATIONALE DE YAMOUSSOUKRO -(UIYA)', 'YAMOUSSOUKRO', 'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale des Sciences et Technologie -(UIST)', 'Abidjan', 'Cocody', 250000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale Evang�lique de C�te d�Ivoire (UIECI)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale Fran�ois (UIF)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale Fran�ois -(UIF)', 'Abidjan', 'Cocody', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale Nayeba (UNID)', 'Abidjan', 'Dabou', 85000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale Priv�e d�Abidjan -(UIPA)', 'Abidjan', 'Riviera', 85000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Methodiste de C�te d�Ivoire -(UMECI)', 'Abidjan', 'Cocody', 210000, 'VOIR LA LISTE DES FILIERES'),
('Universit� M�tropolitaine d�Abidjan -(UMA-GC)', 'Abidjan', 'Plateau', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Musulmane Africaine -(UMA)', 'Abidjan', 'Cocody', 85000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Nanan Yamousso (U NANAN YAMOUSSO)', 'Bouak�', 'Bouak�', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE NBA -(U-NBA)', 'Abidjan', 'Cocody', 100000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD ANGRE', 'Abidjan', 'Cocody', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD ANGRE -(UNS ANGRE)', 'Abidjan', 'Cocody', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD BOUAKE -(UNS BOUAKE)', 'Bouak�', 'Bouak�', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD COCODY -(UNS COCODY)', 'Abidjan', 'Cocody', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD DIMBOKRO -(UNS DIMBOKRO)', 'Dimbokro', 'Dimbokro', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD MARCORY -(UNS MARCORY)', 'Abidjan', 'Marcory', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD PORT-BOU�T -(UNS PORT-BOU�T)', 'Abidjan', 'Port Bou�t', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NORD SUD YOPOUGON -(UNS YOPOUGON)', 'Abidjan', 'Yopougon', 120000, 'Voir la liste des fili�res'),
('UNIVERSITE NOTRE DAME D�ABIDJAN -(UNDA)', 'Abidjan', 'Abobo', 250000, 'Voir la liste des fili�res'),
('UNIVERSITE OUEST AFRICAINE -(UOA)', 'ABIDJAN', 'RIVIERA', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE POLYTECHNIQUE DE BINGERVILLE -(UPB)', 'ABIDJAN', 'BINGERVILLE', 85000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE POLYTECHNIQUE KIBIO -(UPK)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVE N�TAYE (UPN)', 'ABIDJAN', 'TREICHVILLE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVEE AGRICOLE DE COTE D�IVOIRE (UPRACI)', 'ADZOPE', 'ADZOPE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVEE INTERNATIONALE AKANDJI (UPIA)', 'ABIDJAN', 'COCODY', 300000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PRIVEE SOUMARE -(UNIVERSITE SOUMARE)', 'ABIDJAN', 'COCODY', 50000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE PROTESTANTE EVANGELIQUE DE COTE D�IVOIRE -(UPE-CI)', 'YAMOUSSOUKRO', 'YAMOUSSOUKRO', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE SAINT PAUL (USP)', 'ABIDJAN', 'ABOBO', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE SEPI -(US)', 'ABIDJAN', 'YOPOUGON', 120000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE TAHARQA SARE -(UTS)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE TERTIAIRE ET TECHNOLOGIE LOKO -(UTT-LOKO)', 'ABIDJAN', 'MARCORY', 85000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE VAME DE BOUAKE (UVB)', 'BOUAKE', 'BOUAKE', NULL, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITE VIRTUELLE PANAFRICAINE DE TECHNOLOGIE -(UVPT)', 'ABIDJAN', 'COCODY', 450000, 'VOIR LA LISTE DES FILIERES'),
('UNIVERSITY OF ABIDJAN -(UNIABIDJAN)', 'ABIDJAN', 'COCODY', 95000, 'VOIR LA LISTE DES FILIERES'),
('UNVERSITE CANADIENNE DES ARTS DES SCIENCES ET DU MANAGEMENT -(UCASM)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Al Fourqane de Cote d�Ivoire -(UFCI)', 'ABIDJAN', 'COCODY', 100000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale ICK � U2ICK', 'BOUAKE', 'BOUAKE', 200000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Internationale des Sciences Appliqu�es et de Technologies � UNISAT (UNIV)', 'ABIDJAN', 'COCODY', 200000, 'VOIR LA LISTE DES FILIERES'),
('Universit� Populaire de Cote d�Ivoire (UPCI)', 'ABIDJAN', 'COCODY', NULL, 'VOIR LA LISTE DES FILIERES'),
('Universit� Tahaqa Sar� � UNISS (Universit� Internationale des Sciences Sociale Hamp�t� B�h )', 'ABIDJAN', 'COCODY', 85000, 'VOIR LA LISTE DES FILIERES'),
('VALORIS INTERNATIONAL UNIVERSITY -(VIU)', 'ABIDJAN', 'Aucune information', NULL, 'VOIR LA LISTE DES FILIERES');

