-- Base de données : 'LuxCar'

CREATE DATABASE LuxCar;
USE Luxcar;

-- Structure de la table 'Catégorie' (Visiteur ou Administrateur)

CREATE TABLE IF NOT EXISTS Categorie (
	idCategorie char(2) NOT NULL,
	nomCategorie varchar(20) NOT NULL,
	PRIMARY KEY (idCategorie)
	) ENGINE=InnoDB CHARACTER SET latin1;

-- Structure de la table 'Inscrit'

CREATE TABLE IF NOT EXISTS Inscrit (
	idInscrit smallint(4) NOT NULL auto_increment,
	idCategorie char(2) NOT NULL,
	nomInscrit varchar(20) NOT NULL,
	prenomInscrit varchar(20) NOT NULL,
	mailInscrit varchar(50) NOT NULL,
	pswInscrit varchar(100) NOT NULL,
	token varchar(100),
	PRIMARY KEY (idInscrit),
	CONSTRAINT fk_inscrit_categorie FOREIGN KEY (idCategorie) REFERENCES Categorie(idCategorie)
	 ) ENGINE=InnoDB CHARACTER SET latin1 auto_increment=1200;

-- Structure de la table 'Marque'

CREATE TABLE IF NOT EXISTS Marque(
	idMarque smallint(3) NOT NULL auto_increment,
	nomMarque varchar(20) NOT NULL,
	logoMarque varchar(50),
	PRIMARY KEY (idMarque)
	) ENGINE=InnoDB CHARACTER SET latin1;

-- Structure de la table 'Options'

CREATE TABLE IF NOT EXISTS Options(
	idOption smallint(4) NOT NULL auto_increment,
	nomOption varchar(50),
	descriptionOption varchar(200) DEFAULT " ",
	prixOption float(8,2),
	PRIMARY KEY (idOption)
	) ENGINE=InnoDB CHARACTER SET latin1 auto_increment=100;

-- Structure de la table 'Modèle'

CREATE TABLE IF NOT EXISTS Modele(
	idModele smallint(3) NOT NULL auto_increment,
	idMarque smallint(3) NOT NULL,
	nomModele varchar(30) NOT NULL,
	imgModele varchar(50),
	prixModele float(9,2) NOT NULL DEFAULT 0,
	nbDisponible int,
	PRIMARY KEY (idModele),
	CONSTRAINT fk_modele_marque FOREIGN KEY (idMarque) REFERENCES Marque(idMarque)
	) ENGINE=InnoDB CHARACTER SET latin1;

-- Structure de la table 'Etat' (spécifie l'état d'un devis : En attente (AT), validé (VA), annulé (AN))

CREATE TABLE IF NOT EXISTS Etat(
	idEtat char(2) NOT NULL,
	nomEtat varchar(15) NOT NULL,
	PRIMARY KEY (idEtat)
	) ENGINE=InnoDB CHARACTER SET latin1;

-- Structure de la table 'Devis' (qu'un client peut créer pour eventuellement passer commande)

CREATE TABLE IF NOT EXISTS Devis(
	idDevis smallint(4) NOT NULL auto_increment,
	idInscrit smallint(4) NOT NULL,
	idMarque smallint(3) NOT NULL,
	idModele smallint(3) NOT NULL,
	idEtat char(2) DEFAULT "AT",
	dateDevis date,
	prixDevis float(10,2),
	PRIMARY KEY (idDevis),
	CONSTRAINT fk_devis_inscrit FOREIGN KEY (idInscrit) REFERENCES Inscrit(idInscrit),
	CONSTRAINT fk_devis_marque FOREIGN KEY (idMarque) REFERENCES Marque(idMarque),
	CONSTRAINT fk_devis_modele FOREIGN KEY (idModele) REFERENCES Modele(idModele),
	CONSTRAINT fk_devis_etat FOREIGN KEY (idEtat) REFERENCES Etat(idEtat)
	) ENGINE=InnoDB CHARACTER SET latin1 auto_increment=7777;

-- Structure de la table LigneOption (qui contient les options que l'utilisateur a choisies pour son devis)

CREATE TABLE IF NOT EXISTS LigneOption(
	idDevis smallint(4) NOT NULL,
	idOption smallint(4) NOT NULL,
	PRIMARY KEY (idDevis, idOption),
	CONSTRAINT fk_ligneOption_devis FOREIGN KEY (idDevis) REFERENCES Devis(idDevis) ON DELETE CASCADE,
	CONSTRAINT fk_ligneOption_options FOREIGN KEY (idOption) REFERENCES 	Options(idOption) ON DELETE CASCADE
	) ENGINE=InnoDB CHARACTER SET latin1;

-- INSERTION table 'Categorie'

INSERT INTO Categorie VALUES ("AD","Administrateur");
INSERT INTO Categorie VALUES ("CL","Client");

-- INSERTION de l'Administrateur de LuxCar dans la table 'Inscrit'

INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ("AD","Savornin","Simon","simon.savornin@polytech.univ-montp2.fr",SHA1(CONCAT('LuxCar','admin','LuxCar')));

-- INSERTION des clients inscrits dans 'Inscrit' (merci au générateur de données http://www.mockaroo.com)

INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Lee', 'Annotés', 'rlee0@typepad.com', SHA1(CONCAT('LuxCar','AnnotésLee','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hicks', 'Hélène', 'shicks1@google.nl', SHA1(CONCAT('LuxCar','HélèneHicks','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Porter', 'Mégane', 'aporter2@geocities.jp', SHA1(CONCAT('LuxCar','MéganePorter','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Nguyen', 'Méng', 'snguyen3@multiply.com', SHA1(CONCAT('LuxCar','MéngNguyen','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Reynolds', 'Åsa', 'rreynolds4@rambler.ru', SHA1(CONCAT('LuxCar','ÅsaReynolds','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Long', 'Naëlle', 'dlong5@flickr.com', SHA1(CONCAT('LuxCar','NaëlleLong','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Riley', 'Maëlys', 'criley6@bloglovin.com', SHA1(CONCAT('LuxCar','MaëlysRiley','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Edwards', 'Vénus', 'dedwards7@shutterfly.com', SHA1(CONCAT('LuxCar','VénusEdwards','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Franklin', 'Mélys', 'lfranklin8@g.co', SHA1(CONCAT('LuxCar','MélysFranklin','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Williamson', 'Gaëlle', 'mwilliamson9@163.com', SHA1(CONCAT('LuxCar','GaëlleWilliamson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Chapman', 'Célia', 'cchapmana@goo.ne.jp', SHA1(CONCAT('LuxCar','CéliaChapman','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hill', 'Anaëlle', 'thillb@java.com', SHA1(CONCAT('LuxCar','AnaëlleHill','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Vasquez', 'Néhémie', 'rvasquezc@timesonline.co.uk', SHA1(CONCAT('LuxCar','NéhémieVasquez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Anderson', 'Réjane', 'sandersond@dailymotion.com', SHA1(CONCAT('LuxCar','RéjaneAnderson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Chapman', 'Geneviève', 'schapmane@bloglines.com', SHA1(CONCAT('LuxCar','GenevièveChapman','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Stone', 'Almérinda', 'sstonef@engadget.com', SHA1(CONCAT('LuxCar','AlmérindaStone','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Wells', 'Ruò', 'mwellsg@apache.org', SHA1(CONCAT('LuxCar','RuòWells','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hanson', 'Mélys', 'whansonh@nymag.com', SHA1(CONCAT('LuxCar','MélysHanson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'King', 'Méghane', 'skingi@aboutads.info', SHA1(CONCAT('LuxCar','MéghaneKing','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ortiz', 'Ruò', 'sortizj@nyu.edu', SHA1(CONCAT('LuxCar','RuòOrtiz','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Fuller', 'Loïs', 'dfullerk@wisc.edu', SHA1(CONCAT('LuxCar','LoïsFuller','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Rivera', 'Maëlyss', 'friveral@seesaa.net', SHA1(CONCAT('LuxCar','MaëlyssRivera','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Allen', 'Lorène', 'eallenm@nymag.com', SHA1(CONCAT('LuxCar','LorèneAllen','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Wheeler', 'Géraldine', 'jwheelern@chicagotribune.com', SHA1(CONCAT('LuxCar','GéraldineWheeler','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Castillo', 'Mélys', 'ccastilloo@cmu.edu', SHA1(CONCAT('LuxCar','MélysCastillo','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gonzales', 'Renée', 'jgonzalesp@mlb.com', SHA1(CONCAT('LuxCar','RenéeGonzales','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Wright', 'Fèi', 'rwrightq@house.gov', SHA1(CONCAT('LuxCar','FèiWright','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Henry', 'Mélina', 'phenryr@craigslist.org', SHA1(CONCAT('LuxCar','MélinaHenry','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ryan', 'Liè', 'cryans@dailymail.co.uk', SHA1(CONCAT('LuxCar','LièRyan','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Snyder', 'Thérèsa', 'msnydert@simplemachines.org', SHA1(CONCAT('LuxCar','ThérèsaSnyder','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hernandez', 'Annotée', 'ahernandezu@senate.gov', SHA1(CONCAT('LuxCar','AnnotéeHernandez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gomez', 'Bérengère', 'dgomezv@stumbleupon.com', SHA1(CONCAT('LuxCar','BérengèreGomez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Woods', 'Rébecca', 'dwoodsw@senate.gov', SHA1(CONCAT('LuxCar','RébeccaWoods','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Peters', 'Marie-ève', 'wpetersx@uol.com.br', SHA1(CONCAT('LuxCar','Marie-èvePeters','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gardner', 'Athéna', 'ggardnery@biglobe.ne.jp', SHA1(CONCAT('LuxCar','AthénaGardner','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Wheeler', 'Thérèse', 'jwheelerz@ucoz.com', SHA1(CONCAT('LuxCar','ThérèseWheeler','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Reynolds', 'Maïwenn', 'breynolds10@twitter.com', SHA1(CONCAT('LuxCar','MaïwennReynolds','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Fields', 'Réjane', 'jfields11@wunderground.com', SHA1(CONCAT('LuxCar','RéjaneFields','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Vasquez', 'Léonore', 'dvasquez12@amazon.co.uk', SHA1(CONCAT('LuxCar','LéonoreVasquez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gardner', 'Camélia', 'tgardner13@apple.com', SHA1(CONCAT('LuxCar','CaméliaGardner','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Mccoy', 'Léa', 'vmccoy14@wikia.com', SHA1(CONCAT('LuxCar','LéaMccoy','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Watkins', 'Börje', 'jwatkins15@ebay.co.uk', SHA1(CONCAT('LuxCar','BörjeWatkins','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Moore', 'Loïs', 'rmoore16@ezinearticles.com', SHA1(CONCAT('LuxCar','LoïsMoore','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Harris', 'Judicaël', 'lharris17@flavors.me', SHA1(CONCAT('LuxCar','JudicaëlHarris','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gonzalez', 'Cléopatre', 'mgonzalez18@homestead.com', SHA1(CONCAT('LuxCar','CléopatreGonzalez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'West', 'Gaëlle', 'vwest19@moonfruit.com', SHA1(CONCAT('LuxCar','GaëlleWest','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Lee', 'Loïc', 'mlee1a@senate.gov', SHA1(CONCAT('LuxCar','LoïcLee','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hanson', 'Maëly', 'ehanson1b@homestead.com', SHA1(CONCAT('LuxCar','MaëlyHanson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Adams', 'Marie-ève', 'gadams1c@deliciousdays.com', SHA1(CONCAT('LuxCar','Marie-èveAdams','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Wood', 'Anaël', 'rwood1d@wp.com', SHA1(CONCAT('LuxCar','AnaëlWood','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Richardson', 'Marie-thérèse', 'brichardson1e@ifeng.com', SHA1(CONCAT('LuxCar','Marie-thérèseRichardson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Medina', 'Örjan', 'gmedina1f@mlb.com', SHA1(CONCAT('LuxCar','ÖrjanMedina','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Pierce', 'Rébecca', 'kpierce1g@boston.com', SHA1(CONCAT('LuxCar','RébeccaPierce','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sanders', 'Tán', 'ssanders1h@zimbio.com', SHA1(CONCAT('LuxCar','TánSanders','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sims', 'Erwéi', 'csims1i@foxnews.com', SHA1(CONCAT('LuxCar','ErwéiSims','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Perkins', 'Athéna', 'jperkins1j@google.cn', SHA1(CONCAT('LuxCar','AthénaPerkins','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Lee', 'Maëly', 'elee1k@123-reg.co.uk', SHA1(CONCAT('LuxCar','MaëlyLee','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Davis', 'Adèle', 'sdavis1l@goo.gl', SHA1(CONCAT('LuxCar','AdèleDavis','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Richardson', 'Annotée', 'crichardson1m@va.gov', SHA1(CONCAT('LuxCar','AnnotéeRichardson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Franklin', 'Michèle', 'wfranklin1n@java.com', SHA1(CONCAT('LuxCar','MichèleFranklin','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'George', 'Lyséa', 'rgeorge1o@cnbc.com', SHA1(CONCAT('LuxCar','LyséaGeorge','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Carpenter', 'Måns', 'ecarpenter1p@howstuffworks.com', SHA1(CONCAT('LuxCar','MånsCarpenter','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'George', 'Lauréna', 'ggeorge1q@blinklist.com', SHA1(CONCAT('LuxCar','LaurénaGeorge','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Lawson', 'Edmée', 'klawson1r@wsj.com', SHA1(CONCAT('LuxCar','EdméeLawson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Willis', 'Naëlle', 'rwillis1s@unicef.org', SHA1(CONCAT('LuxCar','NaëlleWillis','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Clark', 'Estée', 'fclark1t@google.com', SHA1(CONCAT('LuxCar','EstéeClark','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Chapman', 'Ruì', 'jchapman1u@ucoz.ru', SHA1(CONCAT('LuxCar','RuìChapman','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Black', 'Bérénice', 'mblack1v@addthis.com', SHA1(CONCAT('LuxCar','BéréniceBlack','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ward', 'Méryl', 'rward1w@cdbaby.com', SHA1(CONCAT('LuxCar','MérylWard','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hansen', 'Méghane', 'mhansen1x@rediff.com', SHA1(CONCAT('LuxCar','MéghaneHansen','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Bowman', 'Danièle', 'fbowman1y@ifeng.com', SHA1(CONCAT('LuxCar','DanièleBowman','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Henderson', 'Vénus', 'whenderson1z@multiply.com', SHA1(CONCAT('LuxCar','VénusHenderson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Diaz', 'Renée', 'rdiaz20@tamu.edu', SHA1(CONCAT('LuxCar','RenéeDiaz','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hawkins', 'Lèi', 'jhawkins21@techcrunch.com', SHA1(CONCAT('LuxCar','LèiHawkins','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Chapman', 'Magdalène', 'kchapman22@yolasite.com', SHA1(CONCAT('LuxCar','MagdalèneChapman','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Bryant', 'Andréanne', 'nbryant23@slashdot.org', SHA1(CONCAT('LuxCar','AndréanneBryant','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ramos', 'Liè', 'cramos24@oracle.com', SHA1(CONCAT('LuxCar','LièRamos','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Tucker', 'Noémie', 'stucker25@prnewswire.com', SHA1(CONCAT('LuxCar','NoémieTucker','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Watkins', 'Audréanne', 'gwatkins26@umn.edu', SHA1(CONCAT('LuxCar','AudréanneWatkins','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Austin', 'Noëlla', 'haustin27@imageshack.us', SHA1(CONCAT('LuxCar','NoëllaAustin','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Cole', 'Sélène', 'ecole28@list-manage.com', SHA1(CONCAT('LuxCar','SélèneCole','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sims', 'Léone', 'gsims29@upenn.edu', SHA1(CONCAT('LuxCar','LéoneSims','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Larson', 'Pål', 'llarson2a@last.fm', SHA1(CONCAT('LuxCar','PålLarson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Fernandez', 'Uò', 'rfernandez2b@newsvine.com', SHA1(CONCAT('LuxCar','UòFernandez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Smith', 'Yénora', 'jsmith2c@mapy.cz', SHA1(CONCAT('LuxCar','YénoraSmith','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Murray', 'Lyséa', 'rmurray2d@craigslist.org', SHA1(CONCAT('LuxCar','LyséaMurray','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Mills', 'Yáo', 'lmills2e@reference.com', SHA1(CONCAT('LuxCar','YáoMills','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Fields', 'Léandre', 'cfields2f@weebly.com', SHA1(CONCAT('LuxCar','LéandreFields','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Evans', 'Marylène', 'tevans2g@opera.com', SHA1(CONCAT('LuxCar','MarylèneEvans','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Grant', 'Eléonore', 'lgrant2h@google.de', SHA1(CONCAT('LuxCar','EléonoreGrant','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Barnes', 'Mén', 'hbarnes2i@prnewswire.com', SHA1(CONCAT('LuxCar','MénBarnes','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Howell', 'Méghane', 'bhowell2j@businesswire.com', SHA1(CONCAT('LuxCar','MéghaneHowell','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sullivan', 'Eléa', 'ksullivan2k@tripadvisor.com', SHA1(CONCAT('LuxCar','EléaSullivan','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Montgomery', 'Solène', 'cmontgomery2l@yellowpages.com', SHA1(CONCAT('LuxCar','SolèneMontgomery','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ortiz', 'Kévina', 'mortiz2m@scientificamerican.com', SHA1(CONCAT('LuxCar','KévinaOrtiz','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'George', 'Görel', 'sgeorge2n@wisc.edu', SHA1(CONCAT('LuxCar','GörelGeorge','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ryan', 'Solène', 'jryan2o@nature.com', SHA1(CONCAT('LuxCar','SolèneRyan','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Lawson', 'Maëlann', 'alawson2p@cbc.ca', SHA1(CONCAT('LuxCar','MaëlannLawson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Webb', 'Intéressant', 'swebb2q@un.org', SHA1(CONCAT('LuxCar','IntéressantWebb','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Nelson', 'Garçon', 'gnelson2r@state.gov', SHA1(CONCAT('LuxCar','GarçonNelson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Griffin', 'Simplifiés', 'mgriffin2s@indiatimes.com', SHA1(CONCAT('LuxCar','SimplifiésGriffin','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Black', 'Maïté', 'ablack2t@facebook.com', SHA1(CONCAT('LuxCar','MaïtéBlack','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Mccoy', 'Irène', 'cmccoy2u@tripadvisor.com', SHA1(CONCAT('LuxCar','IrèneMccoy','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sims', 'Marlène', 'msims2v@shop-pro.jp', SHA1(CONCAT('LuxCar','MarlèneSims','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Coleman', 'Gaëlle', 'vcoleman2w@purevolume.com', SHA1(CONCAT('LuxCar','GaëlleColeman','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Duncan', 'Noémie', 'sduncan2x@sourceforge.net', SHA1(CONCAT('LuxCar','NoémieDuncan','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Mason', 'Chloé', 'jmason2y@squidoo.com', SHA1(CONCAT('LuxCar','ChloéMason','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Turner', 'Yénora', 'kturner2z@liveinternet.ru', SHA1(CONCAT('LuxCar','YénoraTurner','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hamilton', 'Vérane', 'lhamilton30@flavors.me', SHA1(CONCAT('LuxCar','VéraneHamilton','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gibson', 'Yóu', 'jgibson31@state.tx.us', SHA1(CONCAT('LuxCar','YóuGibson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'George', 'Inès', 'mgeorge32@census.gov', SHA1(CONCAT('LuxCar','InèsGeorge','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Richardson', 'Tú', 'arichardson33@booking.com', SHA1(CONCAT('LuxCar','TúRichardson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Jordan', 'Zoé', 'jjordan34@webeden.co.uk', SHA1(CONCAT('LuxCar','ZoéJordan','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Nguyen', 'Maëlys', 'dnguyen35@usda.gov', SHA1(CONCAT('LuxCar','MaëlysNguyen','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Reed', 'Marie-françoise', 'lreed36@nymag.com', SHA1(CONCAT('LuxCar','Marie-françoiseReed','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Fox', 'Frédérique', 'jfox37@blogspot.com', SHA1(CONCAT('LuxCar','FrédériqueFox','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Reyes', 'Adélaïde', 'kreyes38@rakuten.co.jp', SHA1(CONCAT('LuxCar','AdélaïdeReyes','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Bishop', 'Crééz', 'gbishop39@google.ru', SHA1(CONCAT('LuxCar','CréézBishop','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Fisher', 'Andréa', 'rfisher3a@dmoz.org', SHA1(CONCAT('LuxCar','AndréaFisher','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hawkins', 'Cécile', 'chawkins3b@rediff.com', SHA1(CONCAT('LuxCar','CécileHawkins','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sullivan', 'Dà', 'csullivan3c@tumblr.com', SHA1(CONCAT('LuxCar','DàSullivan','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Snyder', 'Estève', 'fsnyder3d@google.com.hk', SHA1(CONCAT('LuxCar','EstèveSnyder','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Kelly', 'Mélia', 'pkelly3e@home.pl', SHA1(CONCAT('LuxCar','MéliaKelly','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sanders', 'Garçon', 'ssanders3f@google.cn', SHA1(CONCAT('LuxCar','GarçonSanders','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Banks', 'Valérie', 'wbanks3g@drupal.org', SHA1(CONCAT('LuxCar','ValérieBanks','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Robertson', 'Françoise', 'jrobertson3h@gizmodo.com', SHA1(CONCAT('LuxCar','FrançoiseRobertson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Parker', 'Adèle', 'mparker3i@miitbeian.gov.cn', SHA1(CONCAT('LuxCar','AdèleParker','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Alexander', 'Cunégonde', 'calexander3j@youtube.com', SHA1(CONCAT('LuxCar','CunégondeAlexander','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Morris', 'Tán', 'gmorris3k@feedburner.com', SHA1(CONCAT('LuxCar','TánMorris','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Garcia', 'Bécassine', 'kgarcia3l@surveymonkey.com', SHA1(CONCAT('LuxCar','BécassineGarcia','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Hughes', 'Marie-thérèse', 'mhughes3m@sourceforge.net', SHA1(CONCAT('LuxCar','Marie-thérèseHughes','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Torres', 'Åslög', 'atorres3n@webs.com', SHA1(CONCAT('LuxCar','ÅslögTorres','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Mccoy', 'Lén', 'imccoy3o@fastcompany.com', SHA1(CONCAT('LuxCar','LénMccoy','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gonzales', 'Personnalisée', 'sgonzales3p@domainmarket.com', SHA1(CONCAT('LuxCar','PersonnaliséeGonzales','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Powell', 'Réservés', 'hpowell3q@upenn.edu', SHA1(CONCAT('LuxCar','RéservésPowell','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gonzales', 'Bécassine', 'bgonzales3r@nba.com', SHA1(CONCAT('LuxCar','BécassineGonzales','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Willis', 'Lèi', 'rwillis3s@walmart.com', SHA1(CONCAT('LuxCar','LèiWillis','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Castillo', 'Marie-hélène', 'tcastillo3t@google.ca', SHA1(CONCAT('LuxCar','Marie-hélèneCastillo','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sanders', 'Adélie', 'jsanders3u@cargocollective.com', SHA1(CONCAT('LuxCar','AdélieSanders','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Richardson', 'Célia', 'krichardson3v@umn.edu', SHA1(CONCAT('LuxCar','CéliaRichardson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ross', 'Clélia', 'sross3w@zimbio.com', SHA1(CONCAT('LuxCar','CléliaRoss','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'James', 'Pò', 'jjames3x@quantcast.com', SHA1(CONCAT('LuxCar','PòJames','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Martinez', 'Märta', 'cmartinez3y@plala.or.jp', SHA1(CONCAT('LuxCar','MärtaMartinez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Ferguson', 'Cloé', 'sferguson3z@ow.ly', SHA1(CONCAT('LuxCar','CloéFerguson','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Williams', 'Maëline', 'lwilliams40@alibaba.com', SHA1(CONCAT('LuxCar','MaëlineWilliams','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Gilbert', 'Réjane', 'sgilbert41@seesaa.net', SHA1(CONCAT('LuxCar','RéjaneGilbert','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Warren', 'Zhì', 'dwarren42@pen.io', SHA1(CONCAT('LuxCar','ZhìWarren','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Reid', 'Simplifiés', 'mreid43@123-reg.co.uk', SHA1(CONCAT('LuxCar','SimplifiésReid','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Sanchez', 'Jú', 'psanchez44@icio.us', SHA1(CONCAT('LuxCar','JúSanchez','LuxCar')));
INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ('CL', 'Long', 'Angélique', 'along45@mail.ru', SHA1(CONCAT('LuxCar','AngéliqueLong','LuxCar')));

-- INSERTION table 'Marque'

INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Aston Martin","images/logo/tn_logo_astonmartin.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Audi","images/logo/tn_logo_audi.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("BMW","images/logo/tn_logo_bmw.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Bugatti","images/logo/tn_logo_bugatti.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Ferrari","images/logo/tn_logo_ferrari.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Jaguar","images/logo/tn_logo_jaguar.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Lamborghini","images/logo/tn_logo_lamborghini.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Lexus","images/logo/tn_logo_lexus.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Maserati","images/logo/tn_logo_maserati.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Mercedes","images/logo/tn_logo_mercedes.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("Porsche","images/logo/tn_logo_porsche.jpeg");
INSERT INTO Marque (nomMarque, logoMarque) VALUES ("W Motors","images/logo/tn_logo_wmotors.jpeg");

-- INSERTION table 'Options'

INSERT INTO Options (nomOption, prixOption) VALUES ("Pack confort",1614.50);
INSERT INTO Options (nomOption, prixOption) VALUES ("Pack Business",2168.99);
INSERT INTO Options (nomOption, prixOption) VALUES ("Kit fumeur",60.00);
INSERT INTO Options (nomOption, prixOption) VALUES ("Finition carbone",3000.90);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Sieges chauffants","Grâce à ce système de sièges chauffants, vous ne passerez plus jamais l'hiver de la même façon dans votre berline",960.00);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Toit ouvrant","Pour apprécier une conduite la tête dans les nuages, optez pour ce toit ouvrant très design qui vous fera oublier tous vos soucis",524.99);
INSERT INTO Options (nomOption, prixOption) VALUES ("Vitres teintées",960.99);
INSERT INTO Options (nomOption, prixOption) VALUES ("Volant en bois precieux",836.50);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Volant en or massif","Ce volant vous permettra d'avoir la classe absolue",50006.50);
INSERT INTO Options (nomOption, prixOption) VALUES ("Wifi Hotspot",840.90);
INSERT INTO Options (nomOption, prixOption) VALUES ("Alarme antivol",550.50);
INSERT INTO Options (nomOption, prixOption) VALUES ("Avertisseur d'angle mort",650.00);
INSERT INTO Options (nomOption, prixOption) VALUES ("Camera de recul",500.99);
INSERT INTO Options (nomOption, prixOption) VALUES ("Fonction TV",500.50);
INSERT INTO Options (nomOption, prixOption) VALUES ("Régulateur de vitesse",1790.99);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Systeme Hi-fi","Profitez d'un son UHD qui décoiffe",500.99);
INSERT INTO Options (nomOption, prixOption) VALUES ("Volant chauffant",275.90);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Station multimedia","Grâce à cette station multimédia, vos trajets vous paraîtront moins long malgré la limitation de vitesse",3140.00);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Pack Confort +","Ce pack confort optimum vous rappellera qui est le boss",9788.90);
INSERT INTO Options (nomOption, prixOption) VALUES ("Pack interieur bois",1644.50);
INSERT INTO Options (nomOption, prixOption) VALUES ("Jante 911 Turbo",1320.90);
INSERT INTO Options (nomOption, prixOption) VALUES ("Ventilation des sièges",1068.99);
INSERT INTO Options (nomOption, prixOption) VALUES ("Volant SportDesign",420.99);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Ecran côté passage","Cet écran peut être un bon moyen pour divertir votre co-pilote si celui-ci commence à vous ennuyer",324.00);
INSERT INTO Options (nomOption, prixOption) VALUES ("Phares antibrouillard arriere",500.90);
INSERT INTO Options (nomOption, prixOption) VALUES ("Plaque dedicacee",480.00);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Roue de secours","Cette roue deviendra votre meilleure amie si par malchance quelqu'un de mal intentionné vous a crevé votre berline adorée",2640.00);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Camera de parking arriere","Cette caméra se révèle indispensable pour d'éviter que votre berline ne grignotte les murs lorsque vous vous garez", 2640.90);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Peinture anti-rayures","Grâce à cette superbe peinture anti-rayures, vous pourrez vous permettre de rentrer dans la clio d'à côté lors de vos créneaux",15292.90);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Siège passager éjectable","Si la compagnie de votre co-pilote devient un supplice, vous ne regretterez pas cette investissement", 26550.99);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Système Plaque Immatriculation Interchangeable","Grâce à votre deuxième plaque d'immatriculation cachée, fini les problèmes de radars", 18620.00);
INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("Boîte automatique","Grâce à la boîte automatique vous serez en mesure de rouler les mains dans les poches ! ou presque...", 10120.00);
INSERT INTO Options (nomOption, prixOption) VALUES ("Pack racing en fibre carbone", 10080.00);
INSERT INTO Options (nomOption, prixOption) VALUES ("Sièges électriques", 4914.00);

-- INSERTION table 'Modèle'

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (1,"Vantage","images/modele/1_1.png",180000.90,15);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (1,"DB9","images/modele/1_2.png",175000.99,12);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (1,"Rapide S","images/modele/1_3.png",185000.50,9);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (1,"Vanquish","images/modele/1_4.png",195000,5);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (2,"A7","images/modele/2_1.png",55000,22);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (2,"A8","images/modele/2_2.png",73000.99,21);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (2,"TT","images/modele/2_3.png",105000,12);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (2,"R8","images/modele/2_4.png",118000.90,9);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (2,"RS","images/modele/2_5.png",125000,10);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (3,"Série 2 Cabriolet","images/modele/3_1.png",37500.80,30);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (3,"Série 3 Berline","images/modele/3_2.png",29000.99,10);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (3,"Série 4 Coupé","images/modele/3_3.png",39200,20);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (3,"Série 5 Berline","images/modele/3_4.png",39500.99,12);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (3,"Série 6 Cabriolet","images/modele/3_5.png",93450,8);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (3,"Série 6 Gran Coupé","images/modele/3_5.png",86550.50,6);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (4,"Veyron","images/modele/4_1.jpeg",2350000.99,1);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (4,"Grand sport","images/modele/4_2.jpeg",2500000,3);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (5,"LaFerrari","images/modele/5_1.jpeg",1200000.90,2);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (5,"F12 Berlinetta","images/modele/5_2.jpeg",290000.50,5);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (5,"Spider","images/modele/5_3.jpeg",285000.30,4);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (5,"FF","images/modele/5_4.jpeg",290000,8);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (6,"XE Prestige","images/modele/6_1.png",41210.99,9);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (6,"XJ","images/modele/6_2.png",82400,7);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (6,"F-Type R Coupé","images/modele/6_3.png",107660.90,10);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (7,"Veneno","images/modele/7_1.jpeg",3300000.90,3);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (7,"Aventador","images/modele/7_2.jpeg",392000.99,6);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (7,"Huracan","images/modele/7_3.jpeg",260000,4);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (7,"Gallardo","images/modele/7_4.jpeg",220000.99,7);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (8,"CT 200h","images/modele/8_1.png",27990.50,17);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (8,"IS 250","images/modele/8_2.png",43390,12);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (8,"RC F","images/modele/8_3.png",79790.90,9);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (8,"LS 600h L","images/modele/8_4.png",150500,5);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (9,"Ghibli","images/modele/9_1.jpeg",67250,11);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (9,"Quattroporte GTS","images/modele/9_2.jpeg",150700.99,10);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (9,"GranTurismo MC Stradale","images/modele/9_3.jpeg",154950.99,11);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (9,"GranCabrio MC","images/modele/9_4.jpeg",153800,13);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (10,"Classe E Cabriolet","images/modele/10_1.png",95000,13);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (10,"SLK","images/modele/10_2.png",88000.90,8);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (10,"Classe S Coupé","images/modele/10_3.png",100000.50,5);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (10,"Classe E Cabriolet","images/modele/10_4.png",98000,12);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (10,"Classe E Coupé","images/modele/10_5.png",99999.99,3);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"Boxster","images/modele/11_1.png",82430.50,15);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"Cayman","images/modele/11_2.png",88310,6);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"911","images/modele/11_3.png",140285.90,3);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"918 Spyder","images/modele/11_4.png",777997.90,3);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"Panamera","images/modele/11_5.png",166000.99,8);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"Macan","images/modele/11_6.png",84000,4);
INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (11,"Cayenne","images/modele/11_7.png",170000,2);

INSERT INTO Modele (idMarque, nomModele, imgModele, prixModele, nbDisponible) VALUES (12,"Lykan hypersport","images/modele/12_1.jpeg",3600000,1);

-- INSERTION table 'Etat'

INSERT INTO Etat VALUES ("AT","En attente");
INSERT INTO Etat VALUES ("VA","Validé");
INSERT INTO Etat VALUES ("AN","Annulé");

-- INSERTION Devis --

INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1200,3,14, 'AT',20150530,93450.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1200,7,27, 'AT',20150530,260000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1200,7,28, 'VA',20150530,220000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1200,8,29, 'VA',20150530,27990.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1200,8,30, 'VA',20150530,43390.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1200,8,31, 'AT',20150530,79790.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,8,32, 'VA',20150530,150500.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,9,33, 'VA',20150530,67250.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,9,34, 'AT',20150530,150700.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,9,35, 'AT',20150530,154950.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1201,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,1,3, 'AT',20150530,185000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,1,4, 'AT',20150530,195000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1202,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,11,43, 'AT',20150530,88310.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,11,44, 'AT',20150530,140285.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,11,45, 'AT',20150530,777997.88); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,11,46, 'VA',20150530,166000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1203,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,9,36, 'VA',20150530,153800.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,10,37, 'AT',20150530,95000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,10,38, 'VA',20150530,88000.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,10,39, 'VA',20150530,100000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,10,40, 'AT',20150530,98000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,10,41, 'AT',20150530,99999.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1204,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,3,15, 'AT',20150530,86550.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,4,16, 'VA',20150530,2350001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,4,17, 'AT',20150530,2500000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,5,18, 'VA',20150530,1200000.88); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,5,19, 'VA',20150530,290000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,5,20, 'AT',20150530,285000.31); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,5,21, 'AT',20150530,290000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,6,22, 'VA',20150530,41210.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,6,23, 'AT',20150530,82400.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,6,24, 'AT',20150530,107660.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,7,25, 'AT',20150530,3300001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,7,26, 'VA',20150530,392001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,11,44, 'AT',20150530,140285.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,11,45, 'AT',20150530,777997.88); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,11,46, 'VA',20150530,166000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1205,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,8,32, 'VA',20150530,150500.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,9,33, 'VA',20150530,67250.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,9,34, 'AT',20150530,150700.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,9,35, 'AT',20150530,154950.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,9,36, 'VA',20150530,153800.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1206,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,3,14, 'AT',20150530,93450.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,3,15, 'AT',20150530,86550.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,4,16, 'VA',20150530,2350001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,4,17, 'AT',20150530,2500000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,11,47, 'AT',20150530,84000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1207,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1208,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,1,3, 'AT',20150530,185000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,1,4, 'AT',20150530,195000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,5,21, 'AT',20150530,290000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,6,22, 'VA',20150530,41210.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1210,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,1,3, 'AT',20150530,185000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,1,4, 'AT',20150530,195000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,11,44, 'AT',20150530,140285.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,11,45, 'AT',20150530,777997.88); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,11,46, 'VA',20150530,166000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1211,11,47, 'AT',20150530,84000.00);  
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1245,5,20, 'AT',20150530,285000.31); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1245,5,21, 'AT',20150530,290000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1245,11,48, 'VA',20150530,170000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1245,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,1,3, 'AT',20150530,185000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,1,4, 'AT',20150530,195000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,2,5, 'AT',20150530,55000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,2,6, 'VA',20150530,73000.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,2,7, 'AT',20150530,105000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,2,8, 'VA',20150530,118000.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1246,3,11, 'AT',20150530,29000.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1281,12,49, 'VA',20150530,3600000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1282,1,1, 'AT',20150530,180000.91); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1282,1,2, 'VA',20150530,175000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1282,1,3, 'AT',20150530,185000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1282,1,4, 'AT',20150530,195000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1282,2,5, 'AT',20150530,55000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1282,2,6, 'VA',20150530,73000.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,2,9, 'VA',20150530,125000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,3,10, 'AT',20150530,37500.80); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,3,11, 'AT',20150530,29000.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,3,12, 'VA',20150530,39200.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,3,13, 'AT',20150530,39500.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,3,14, 'AT',20150530,93450.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,3,15, 'AT',20150530,86550.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,5,18, 'VA',20150530,1200000.88); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,5,19, 'VA',20150530,290000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1283,5,20, 'AT',20150530,285000.31); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,4,17, 'AT',20150530,2500000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,5,18, 'VA',20150530,1200000.88); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,5,19, 'VA',20150530,290000.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,5,20, 'AT',20150530,285000.31); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,5,21, 'AT',20150530,290000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,6,22, 'VA',20150530,41210.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,6,23, 'AT',20150530,82400.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,6,24, 'AT',20150530,107660.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,7,25, 'AT',20150530,3300001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1305,7,26, 'VA',20150530,392001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,5,21, 'AT',20150530,290000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,6,22, 'VA',20150530,41210.99); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,6,23, 'AT',20150530,82400.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,6,24, 'AT',20150530,107660.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,7,25, 'AT',20150530,3300001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,7,26, 'VA',20150530,392001.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,7,27, 'AT',20150530,260000.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,7,28, 'VA',20150530,220000.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,8,29, 'VA',20150530,27990.50); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,8,30, 'VA',20150530,43390.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,8,31, 'AT',20150530,79790.90); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,8,32, 'VA',20150530,150500.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,9,33, 'VA',20150530,67250.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1346,9,34, 'AT',20150530,150700.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1349,8,32, 'VA',20150530,150500.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1349,9,33, 'VA',20150530,67250.00); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1349,9,34, 'AT',20150530,150700.98); 
INSERT INTO Devis (idInscrit, idMarque, idModele, idEtat, dateDevis, prixDevis) VALUES (1349,9,35, 'AT',20150530,154950.98); 

-- Insertion pour les Options des Devis

INSERT INTO LigneOption VALUES (7777,132); 
INSERT INTO LigneOption VALUES (7777,128); 
INSERT INTO LigneOption VALUES (7777,113); 
INSERT INTO LigneOption VALUES (7777,124); 
INSERT INTO LigneOption VALUES (7777,104); 
INSERT INTO LigneOption VALUES (7777,114); 
INSERT INTO LigneOption VALUES (7777,121); 
INSERT INTO LigneOption VALUES (7777,103); 
INSERT INTO LigneOption VALUES (7777,102); 
INSERT INTO LigneOption VALUES (7777,101); 
INSERT INTO LigneOption VALUES (7777,122); 
INSERT INTO LigneOption VALUES (7777,107); 
INSERT INTO LigneOption VALUES (7777,117); 
INSERT INTO LigneOption VALUES (7777,108); 
INSERT INTO LigneOption VALUES (7777,109); 
INSERT INTO LigneOption VALUES (7777,123); 
INSERT INTO LigneOption VALUES (7777,110); 
INSERT INTO LigneOption VALUES (7778,111); 
INSERT INTO LigneOption VALUES (7778,112); 
INSERT INTO LigneOption VALUES (7778,132); 
INSERT INTO LigneOption VALUES (7778,128); 
INSERT INTO LigneOption VALUES (7778,113); 
INSERT INTO LigneOption VALUES (7778,124); 
INSERT INTO LigneOption VALUES (7778,104); 
INSERT INTO LigneOption VALUES (7778,114); 
INSERT INTO LigneOption VALUES (7778,107); 
INSERT INTO LigneOption VALUES (7778,117); 
INSERT INTO LigneOption VALUES (7778,108); 
INSERT INTO LigneOption VALUES (7778,109); 
INSERT INTO LigneOption VALUES (7778,123); 
INSERT INTO LigneOption VALUES (7778,110); 
INSERT INTO LigneOption VALUES (7779,111); 
INSERT INTO LigneOption VALUES (7779,112); 
INSERT INTO LigneOption VALUES (7779,132); 
INSERT INTO LigneOption VALUES (7779,128); 
INSERT INTO LigneOption VALUES (7779,113); 
INSERT INTO LigneOption VALUES (7779,124); 
INSERT INTO LigneOption VALUES (7779,104); 
INSERT INTO LigneOption VALUES (7779,114); 
INSERT INTO LigneOption VALUES (7779,121); 
INSERT INTO LigneOption VALUES (7779,103); 
INSERT INTO LigneOption VALUES (7779,102); 
INSERT INTO LigneOption VALUES (7779,101); 
INSERT INTO LigneOption VALUES (7789,103); 
INSERT INTO LigneOption VALUES (7789,102); 
INSERT INTO LigneOption VALUES (7789,101); 
INSERT INTO LigneOption VALUES (7789,116); 
INSERT INTO LigneOption VALUES (7789,131); 
INSERT INTO LigneOption VALUES (7789,106); 
INSERT INTO LigneOption VALUES (7789,122); 
INSERT INTO LigneOption VALUES (7789,107); 
INSERT INTO LigneOption VALUES (7789,117); 
INSERT INTO LigneOption VALUES (7789,108); 
INSERT INTO LigneOption VALUES (7789,109); 
INSERT INTO LigneOption VALUES (7789,123); 
INSERT INTO LigneOption VALUES (7789,110); 
INSERT INTO LigneOption VALUES (7790,111); 
INSERT INTO LigneOption VALUES (7790,112); 
INSERT INTO LigneOption VALUES (7790,132); 
INSERT INTO LigneOption VALUES (7790,128); 
INSERT INTO LigneOption VALUES (7790,113); 
INSERT INTO LigneOption VALUES (7790,124); 
INSERT INTO LigneOption VALUES (7790,104); 
INSERT INTO LigneOption VALUES (7790,114); 
INSERT INTO LigneOption VALUES (7790,108); 
INSERT INTO LigneOption VALUES (7790,109); 
INSERT INTO LigneOption VALUES (7805,115); 
INSERT INTO LigneOption VALUES (7805,127); 
INSERT INTO LigneOption VALUES (7805,130); 
INSERT INTO LigneOption VALUES (7805,105); 
INSERT INTO LigneOption VALUES (7805,100); 
INSERT INTO LigneOption VALUES (7805,118); 
INSERT INTO LigneOption VALUES (7805,116); 
INSERT INTO LigneOption VALUES (7805,131); 
INSERT INTO LigneOption VALUES (7805,106); 
INSERT INTO LigneOption VALUES (7805,122); 
INSERT INTO LigneOption VALUES (7805,107); 
INSERT INTO LigneOption VALUES (7805,117); 
INSERT INTO LigneOption VALUES (7805,108); 
INSERT INTO LigneOption VALUES (7805,109); 
INSERT INTO LigneOption VALUES (7805,123); 
INSERT INTO LigneOption VALUES (7805,110); 
INSERT INTO LigneOption VALUES (7806,111); 
INSERT INTO LigneOption VALUES (7806,112); 
INSERT INTO LigneOption VALUES (7806,132); 
INSERT INTO LigneOption VALUES (7806,128); 
INSERT INTO LigneOption VALUES (7806,113); 
INSERT INTO LigneOption VALUES (7806,124); 
INSERT INTO LigneOption VALUES (7806,104); 
INSERT INTO LigneOption VALUES (7806,114); 
INSERT INTO LigneOption VALUES (7806,121); 
INSERT INTO LigneOption VALUES (7806,103); 
INSERT INTO LigneOption VALUES (7806,102); 
INSERT INTO LigneOption VALUES (7806,101); 
INSERT INTO LigneOption VALUES (7806,119); 
INSERT INTO LigneOption VALUES (7806,120); 
INSERT INTO LigneOption VALUES (7806,133); 
INSERT INTO LigneOption VALUES (7806,129); 
INSERT INTO LigneOption VALUES (7806,125); 
INSERT INTO LigneOption VALUES (7806,126); 
INSERT INTO LigneOption VALUES (7806,115); 
INSERT INTO LigneOption VALUES (7806,127); 
INSERT INTO LigneOption VALUES (7806,130); 
INSERT INTO LigneOption VALUES (7806,105); 
INSERT INTO LigneOption VALUES (7806,100); 
INSERT INTO LigneOption VALUES (7806,118); 
INSERT INTO LigneOption VALUES (7806,116); 
INSERT INTO LigneOption VALUES (7814,102); 
INSERT INTO LigneOption VALUES (7814,101); 
INSERT INTO LigneOption VALUES (7814,119); 
INSERT INTO LigneOption VALUES (7814,120); 
INSERT INTO LigneOption VALUES (7814,133); 
INSERT INTO LigneOption VALUES (7814,129); 
INSERT INTO LigneOption VALUES (7814,125); 
INSERT INTO LigneOption VALUES (7814,126); 
INSERT INTO LigneOption VALUES (7814,115); 
INSERT INTO LigneOption VALUES (7814,127); 
INSERT INTO LigneOption VALUES (7814,130); 
INSERT INTO LigneOption VALUES (7814,105); 
INSERT INTO LigneOption VALUES (7814,100); 
INSERT INTO LigneOption VALUES (7814,118); 
INSERT INTO LigneOption VALUES (7814,116); 
INSERT INTO LigneOption VALUES (7814,131); 
INSERT INTO LigneOption VALUES (7814,106); 
INSERT INTO LigneOption VALUES (7814,122); 
INSERT INTO LigneOption VALUES (7814,107); 
INSERT INTO LigneOption VALUES (7814,117); 
INSERT INTO LigneOption VALUES (7814,108); 
INSERT INTO LigneOption VALUES (7816,100); 
INSERT INTO LigneOption VALUES (7816,118); 
INSERT INTO LigneOption VALUES (7817,121); 
INSERT INTO LigneOption VALUES (7817,103); 
INSERT INTO LigneOption VALUES (7817,102); 
INSERT INTO LigneOption VALUES (7817,101); 
INSERT INTO LigneOption VALUES (7817,119); 
INSERT INTO LigneOption VALUES (7817,120); 
INSERT INTO LigneOption VALUES (7817,133); 
INSERT INTO LigneOption VALUES (7817,129); 
INSERT INTO LigneOption VALUES (7817,125); 
INSERT INTO LigneOption VALUES (7817,126); 
INSERT INTO LigneOption VALUES (7817,115); 
INSERT INTO LigneOption VALUES (7817,127); 
INSERT INTO LigneOption VALUES (7817,130); 
INSERT INTO LigneOption VALUES (7817,105); 
INSERT INTO LigneOption VALUES (7817,100); 
INSERT INTO LigneOption VALUES (7822,133); 
INSERT INTO LigneOption VALUES (7822,129); 
INSERT INTO LigneOption VALUES (7822,125); 
INSERT INTO LigneOption VALUES (7822,126); 
INSERT INTO LigneOption VALUES (7822,115); 
INSERT INTO LigneOption VALUES (7822,127); 
INSERT INTO LigneOption VALUES (7822,130); 
INSERT INTO LigneOption VALUES (7822,105); 
INSERT INTO LigneOption VALUES (7822,100); 
INSERT INTO LigneOption VALUES (7822,118); 
INSERT INTO LigneOption VALUES (7822,116); 
INSERT INTO LigneOption VALUES (7822,131); 
INSERT INTO LigneOption VALUES (7822,106); 
INSERT INTO LigneOption VALUES (7822,122); 
INSERT INTO LigneOption VALUES (7822,107); 
INSERT INTO LigneOption VALUES (7822,117); 
INSERT INTO LigneOption VALUES (7822,108); 
INSERT INTO LigneOption VALUES (7822,109); 
INSERT INTO LigneOption VALUES (7833,125); 
INSERT INTO LigneOption VALUES (7833,126); 
INSERT INTO LigneOption VALUES (7833,115); 
INSERT INTO LigneOption VALUES (7833,127); 
INSERT INTO LigneOption VALUES (7833,130); 
INSERT INTO LigneOption VALUES (7833,105); 
INSERT INTO LigneOption VALUES (7833,100); 
INSERT INTO LigneOption VALUES (7833,118); 
INSERT INTO LigneOption VALUES (7833,116); 
INSERT INTO LigneOption VALUES (7833,131); 
INSERT INTO LigneOption VALUES (7833,106); 
INSERT INTO LigneOption VALUES (7833,122); 
INSERT INTO LigneOption VALUES (7833,107); 
INSERT INTO LigneOption VALUES (7833,117); 
INSERT INTO LigneOption VALUES (7833,108); 
INSERT INTO LigneOption VALUES (7833,109); 
INSERT INTO LigneOption VALUES (7833,123); 
INSERT INTO LigneOption VALUES (7833,110); 
INSERT INTO LigneOption VALUES (7834,111); 
INSERT INTO LigneOption VALUES (7834,112); 
INSERT INTO LigneOption VALUES (7834,132); 
INSERT INTO LigneOption VALUES (7834,128); 
INSERT INTO LigneOption VALUES (7834,113); 
INSERT INTO LigneOption VALUES (7834,124); 
INSERT INTO LigneOption VALUES (7834,104); 
INSERT INTO LigneOption VALUES (7834,114); 
INSERT INTO LigneOption VALUES (7834,121); 
INSERT INTO LigneOption VALUES (7834,103); 
INSERT INTO LigneOption VALUES (7834,102); 
INSERT INTO LigneOption VALUES (7834,101); 
INSERT INTO LigneOption VALUES (7834,119); 
INSERT INTO LigneOption VALUES (7834,120); 
INSERT INTO LigneOption VALUES (7834,133); 
INSERT INTO LigneOption VALUES (7834,129); 
INSERT INTO LigneOption VALUES (7834,125); 
INSERT INTO LigneOption VALUES (7834,126); 
INSERT INTO LigneOption VALUES (7834,115); 
INSERT INTO LigneOption VALUES (7834,127); 
INSERT INTO LigneOption VALUES (7834,130); 
INSERT INTO LigneOption VALUES (7834,105); 
INSERT INTO LigneOption VALUES (7834,100); 
INSERT INTO LigneOption VALUES (7834,118); 
INSERT INTO LigneOption VALUES (7834,116); 
INSERT INTO LigneOption VALUES (7834,131); 
INSERT INTO LigneOption VALUES (7834,106); 
INSERT INTO LigneOption VALUES (7834,122); 
INSERT INTO LigneOption VALUES (7842,124); 
INSERT INTO LigneOption VALUES (7842,104); 
INSERT INTO LigneOption VALUES (7842,114); 
INSERT INTO LigneOption VALUES (7842,121); 
INSERT INTO LigneOption VALUES (7842,103); 
INSERT INTO LigneOption VALUES (7842,102); 
INSERT INTO LigneOption VALUES (7842,101); 
INSERT INTO LigneOption VALUES (7842,119); 
INSERT INTO LigneOption VALUES (7842,120); 
INSERT INTO LigneOption VALUES (7842,133); 
INSERT INTO LigneOption VALUES (7842,129); 
INSERT INTO LigneOption VALUES (7842,125); 
INSERT INTO LigneOption VALUES (7842,126); 
INSERT INTO LigneOption VALUES (7842,115); 
INSERT INTO LigneOption VALUES (7842,127); 
INSERT INTO LigneOption VALUES (7842,130); 
INSERT INTO LigneOption VALUES (7842,105); 
INSERT INTO LigneOption VALUES (7842,100); 
INSERT INTO LigneOption VALUES (7842,118); 
INSERT INTO LigneOption VALUES (7842,116); 
INSERT INTO LigneOption VALUES (7842,131); 
INSERT INTO LigneOption VALUES (7842,106); 
INSERT INTO LigneOption VALUES (7842,122); 
INSERT INTO LigneOption VALUES (7842,107); 
INSERT INTO LigneOption VALUES (7842,117); 
INSERT INTO LigneOption VALUES (7842,108); 
INSERT INTO LigneOption VALUES (7842,109); 
INSERT INTO LigneOption VALUES (7842,123); 
INSERT INTO LigneOption VALUES (7842,110); 
INSERT INTO LigneOption VALUES (7843,111); 
INSERT INTO LigneOption VALUES (7843,112); 
INSERT INTO LigneOption VALUES (7843,132); 
INSERT INTO LigneOption VALUES (7843,128); 
INSERT INTO LigneOption VALUES (7843,113); 
INSERT INTO LigneOption VALUES (7843,124); 
INSERT INTO LigneOption VALUES (7843,104); 
INSERT INTO LigneOption VALUES (7843,114); 
INSERT INTO LigneOption VALUES (7843,121); 
INSERT INTO LigneOption VALUES (7843,103); 
INSERT INTO LigneOption VALUES (7843,102); 
INSERT INTO LigneOption VALUES (7843,101); 
INSERT INTO LigneOption VALUES (7843,119); 
INSERT INTO LigneOption VALUES (7843,120); 
INSERT INTO LigneOption VALUES (7843,133); 
INSERT INTO LigneOption VALUES (7843,129); 
INSERT INTO LigneOption VALUES (7843,125); 
INSERT INTO LigneOption VALUES (7843,126); 
INSERT INTO LigneOption VALUES (7843,115); 
INSERT INTO LigneOption VALUES (7843,127); 
INSERT INTO LigneOption VALUES (7843,130); 
INSERT INTO LigneOption VALUES (7843,105); 
INSERT INTO LigneOption VALUES (7843,100); 
INSERT INTO LigneOption VALUES (7843,118); 
INSERT INTO LigneOption VALUES (7843,116); 
INSERT INTO LigneOption VALUES (7843,131); 
INSERT INTO LigneOption VALUES (7843,106); 
INSERT INTO LigneOption VALUES (7843,122); 
INSERT INTO LigneOption VALUES (7843,107); 
INSERT INTO LigneOption VALUES (7843,117); 
INSERT INTO LigneOption VALUES (7843,108); 
INSERT INTO LigneOption VALUES (7843,109); 
INSERT INTO LigneOption VALUES (7843,123); 
INSERT INTO LigneOption VALUES (7843,110); 
INSERT INTO LigneOption VALUES (7844,111); 
INSERT INTO LigneOption VALUES (7844,112); 
INSERT INTO LigneOption VALUES (7844,132); 
INSERT INTO LigneOption VALUES (7844,128); 
INSERT INTO LigneOption VALUES (7844,113); 
INSERT INTO LigneOption VALUES (7844,124); 
INSERT INTO LigneOption VALUES (7844,104); 
INSERT INTO LigneOption VALUES (7844,114); 
INSERT INTO LigneOption VALUES (7852,112); 
INSERT INTO LigneOption VALUES (7852,132); 
INSERT INTO LigneOption VALUES (7852,128); 
INSERT INTO LigneOption VALUES (7852,113); 
INSERT INTO LigneOption VALUES (7852,124); 
INSERT INTO LigneOption VALUES (7852,104); 
INSERT INTO LigneOption VALUES (7852,114); 
INSERT INTO LigneOption VALUES (7852,121); 
INSERT INTO LigneOption VALUES (7852,103); 
INSERT INTO LigneOption VALUES (7852,102); 
INSERT INTO LigneOption VALUES (7852,101); 
INSERT INTO LigneOption VALUES (7852,119); 
INSERT INTO LigneOption VALUES (7852,120); 
INSERT INTO LigneOption VALUES (7852,133); 
INSERT INTO LigneOption VALUES (7852,129); 
INSERT INTO LigneOption VALUES (7852,125); 
INSERT INTO LigneOption VALUES (7852,126); 
INSERT INTO LigneOption VALUES (7852,115); 
INSERT INTO LigneOption VALUES (7852,127); 
INSERT INTO LigneOption VALUES (7852,130); 
INSERT INTO LigneOption VALUES (7852,105); 
INSERT INTO LigneOption VALUES (7852,100); 
INSERT INTO LigneOption VALUES (7852,118); 
INSERT INTO LigneOption VALUES (7852,116); 
INSERT INTO LigneOption VALUES (7852,131); 
INSERT INTO LigneOption VALUES (7852,106); 
INSERT INTO LigneOption VALUES (7852,122); 
INSERT INTO LigneOption VALUES (7852,107); 
INSERT INTO LigneOption VALUES (7852,117); 
INSERT INTO LigneOption VALUES (7852,108); 
INSERT INTO LigneOption VALUES (7852,109); 
INSERT INTO LigneOption VALUES (7852,123); 
INSERT INTO LigneOption VALUES (7852,110); 
INSERT INTO LigneOption VALUES (7853,111); 
INSERT INTO LigneOption VALUES (7853,112); 
INSERT INTO LigneOption VALUES (7853,132); 
INSERT INTO LigneOption VALUES (7853,128); 
INSERT INTO LigneOption VALUES (7853,113); 
INSERT INTO LigneOption VALUES (7853,124); 
INSERT INTO LigneOption VALUES (7853,104); 
INSERT INTO LigneOption VALUES (7853,114); 
INSERT INTO LigneOption VALUES (7853,121); 
INSERT INTO LigneOption VALUES (7853,103); 
INSERT INTO LigneOption VALUES (7853,102); 
INSERT INTO LigneOption VALUES (7853,101); 
INSERT INTO LigneOption VALUES (7853,119); 
INSERT INTO LigneOption VALUES (7853,120); 
INSERT INTO LigneOption VALUES (7853,133); 
INSERT INTO LigneOption VALUES (7853,129); 
INSERT INTO LigneOption VALUES (7853,125); 
INSERT INTO LigneOption VALUES (7853,126); 
INSERT INTO LigneOption VALUES (7853,115); 
INSERT INTO LigneOption VALUES (7853,127); 
INSERT INTO LigneOption VALUES (7853,130); 
INSERT INTO LigneOption VALUES (7853,105); 
INSERT INTO LigneOption VALUES (7853,100); 
INSERT INTO LigneOption VALUES (7853,118); 
INSERT INTO LigneOption VALUES (7853,116); 
INSERT INTO LigneOption VALUES (7853,131); 
INSERT INTO LigneOption VALUES (7853,106); 
INSERT INTO LigneOption VALUES (7853,122); 
INSERT INTO LigneOption VALUES (7853,107); 
INSERT INTO LigneOption VALUES (7853,117); 
INSERT INTO LigneOption VALUES (7853,108); 
INSERT INTO LigneOption VALUES (7853,109); 
INSERT INTO LigneOption VALUES (7853,123); 
INSERT INTO LigneOption VALUES (7853,110); 
INSERT INTO LigneOption VALUES (7854,111); 
INSERT INTO LigneOption VALUES (7854,112); 
INSERT INTO LigneOption VALUES (7854,132); 
INSERT INTO LigneOption VALUES (7854,128); 
INSERT INTO LigneOption VALUES (7854,113); 
INSERT INTO LigneOption VALUES (7854,124); 
INSERT INTO LigneOption VALUES (7854,104); 
INSERT INTO LigneOption VALUES (7854,114); 
INSERT INTO LigneOption VALUES (7854,121); 
INSERT INTO LigneOption VALUES (7854,103); 
INSERT INTO LigneOption VALUES (7854,102); 
INSERT INTO LigneOption VALUES (7854,101); 
INSERT INTO LigneOption VALUES (7854,119); 
INSERT INTO LigneOption VALUES (7854,120); 
INSERT INTO LigneOption VALUES (7854,133); 
INSERT INTO LigneOption VALUES (7854,129); 
INSERT INTO LigneOption VALUES (7854,125); 
INSERT INTO LigneOption VALUES (7854,126); 
INSERT INTO LigneOption VALUES (7854,115); 
INSERT INTO LigneOption VALUES (7854,127); 
INSERT INTO LigneOption VALUES (7854,130); 
INSERT INTO LigneOption VALUES (7854,105); 
INSERT INTO LigneOption VALUES (7854,100); 
INSERT INTO LigneOption VALUES (7854,118); 
INSERT INTO LigneOption VALUES (7854,116); 
INSERT INTO LigneOption VALUES (7854,131); 
INSERT INTO LigneOption VALUES (7854,106); 
INSERT INTO LigneOption VALUES (7854,122); 
INSERT INTO LigneOption VALUES (7854,107); 
INSERT INTO LigneOption VALUES (7854,117); 
INSERT INTO LigneOption VALUES (7854,108); 
INSERT INTO LigneOption VALUES (7854,109); 
INSERT INTO LigneOption VALUES (7854,123); 
INSERT INTO LigneOption VALUES (7854,110); 
INSERT INTO LigneOption VALUES (7855,111); 
INSERT INTO LigneOption VALUES (7855,112); 
INSERT INTO LigneOption VALUES (7855,132); 
INSERT INTO LigneOption VALUES (7855,128); 
INSERT INTO LigneOption VALUES (7855,113); 
INSERT INTO LigneOption VALUES (7855,124); 
INSERT INTO LigneOption VALUES (7855,104); 
INSERT INTO LigneOption VALUES (7855,114); 
INSERT INTO LigneOption VALUES (7855,121); 
INSERT INTO LigneOption VALUES (7855,103); 
INSERT INTO LigneOption VALUES (7855,102); 
INSERT INTO LigneOption VALUES (7855,101); 
INSERT INTO LigneOption VALUES (7855,119); 
INSERT INTO LigneOption VALUES (7855,120); 
INSERT INTO LigneOption VALUES (7855,133); 
INSERT INTO LigneOption VALUES (7855,129); 
INSERT INTO LigneOption VALUES (7855,125); 
INSERT INTO LigneOption VALUES (7855,126); 
INSERT INTO LigneOption VALUES (7855,115); 
INSERT INTO LigneOption VALUES (7855,127); 
INSERT INTO LigneOption VALUES (7855,130); 
INSERT INTO LigneOption VALUES (7855,105); 
INSERT INTO LigneOption VALUES (7855,100); 
INSERT INTO LigneOption VALUES (7855,118); 
INSERT INTO LigneOption VALUES (7855,116); 
INSERT INTO LigneOption VALUES (7855,131); 
INSERT INTO LigneOption VALUES (7855,106); 
INSERT INTO LigneOption VALUES (7855,122); 
INSERT INTO LigneOption VALUES (7855,107); 
INSERT INTO LigneOption VALUES (7855,117); 
INSERT INTO LigneOption VALUES (7855,108); 
INSERT INTO LigneOption VALUES (7855,109); 
INSERT INTO LigneOption VALUES (7855,123); 
INSERT INTO LigneOption VALUES (7855,110); 
INSERT INTO LigneOption VALUES (7856,111); 
INSERT INTO LigneOption VALUES (7856,112); 
INSERT INTO LigneOption VALUES (7856,132); 
INSERT INTO LigneOption VALUES (7856,128); 
INSERT INTO LigneOption VALUES (7856,113); 
INSERT INTO LigneOption VALUES (7856,124); 
INSERT INTO LigneOption VALUES (7856,104); 
INSERT INTO LigneOption VALUES (7856,114); 
INSERT INTO LigneOption VALUES (7856,121); 
INSERT INTO LigneOption VALUES (7856,103); 
INSERT INTO LigneOption VALUES (7856,102); 
INSERT INTO LigneOption VALUES (7856,101); 
INSERT INTO LigneOption VALUES (7856,119); 
INSERT INTO LigneOption VALUES (7856,120); 
INSERT INTO LigneOption VALUES (7856,133); 
INSERT INTO LigneOption VALUES (7856,129); 
INSERT INTO LigneOption VALUES (7856,125); 
INSERT INTO LigneOption VALUES (7856,126); 
INSERT INTO LigneOption VALUES (7856,115); 
INSERT INTO LigneOption VALUES (7856,127); 
INSERT INTO LigneOption VALUES (7856,130); 
INSERT INTO LigneOption VALUES (7856,105); 
INSERT INTO LigneOption VALUES (7856,100); 
INSERT INTO LigneOption VALUES (7856,118); 
INSERT INTO LigneOption VALUES (7856,116); 
INSERT INTO LigneOption VALUES (7856,131); 
INSERT INTO LigneOption VALUES (7856,106); 
INSERT INTO LigneOption VALUES (7856,122); 
INSERT INTO LigneOption VALUES (7856,107); 
INSERT INTO LigneOption VALUES (7856,117); 
INSERT INTO LigneOption VALUES (7856,108); 
INSERT INTO LigneOption VALUES (7856,109); 
INSERT INTO LigneOption VALUES (7856,123); 
INSERT INTO LigneOption VALUES (7856,110); 
INSERT INTO LigneOption VALUES (7857,111); 
INSERT INTO LigneOption VALUES (7857,112); 
INSERT INTO LigneOption VALUES (7857,132); 
INSERT INTO LigneOption VALUES (7857,128); 
INSERT INTO LigneOption VALUES (7857,113); 
INSERT INTO LigneOption VALUES (7857,124); 
INSERT INTO LigneOption VALUES (7857,104); 
INSERT INTO LigneOption VALUES (7857,114); 
INSERT INTO LigneOption VALUES (7857,121); 
INSERT INTO LigneOption VALUES (7857,103); 
INSERT INTO LigneOption VALUES (7857,102); 
INSERT INTO LigneOption VALUES (7857,101); 
INSERT INTO LigneOption VALUES (7857,119); 
INSERT INTO LigneOption VALUES (7857,120); 
INSERT INTO LigneOption VALUES (7857,133); 
INSERT INTO LigneOption VALUES (7857,129); 
INSERT INTO LigneOption VALUES (7857,125); 
INSERT INTO LigneOption VALUES (7857,126); 
INSERT INTO LigneOption VALUES (7857,115); 
INSERT INTO LigneOption VALUES (7857,127); 
INSERT INTO LigneOption VALUES (7857,130); 
INSERT INTO LigneOption VALUES (7857,105); 
INSERT INTO LigneOption VALUES (7857,100); 
INSERT INTO LigneOption VALUES (7857,118); 
INSERT INTO LigneOption VALUES (7857,116); 
INSERT INTO LigneOption VALUES (7857,131); 
INSERT INTO LigneOption VALUES (7857,106); 
INSERT INTO LigneOption VALUES (7857,122); 
INSERT INTO LigneOption VALUES (7857,107); 
INSERT INTO LigneOption VALUES (7857,117); 
INSERT INTO LigneOption VALUES (7857,108); 
INSERT INTO LigneOption VALUES (7857,109); 
INSERT INTO LigneOption VALUES (7857,123); 
INSERT INTO LigneOption VALUES (7857,110); 
INSERT INTO LigneOption VALUES (7858,111); 
INSERT INTO LigneOption VALUES (7858,112); 
INSERT INTO LigneOption VALUES (7858,132); 
INSERT INTO LigneOption VALUES (7858,128); 
INSERT INTO LigneOption VALUES (7858,113); 
INSERT INTO LigneOption VALUES (7858,124); 
INSERT INTO LigneOption VALUES (7858,104); 
INSERT INTO LigneOption VALUES (7858,114); 
INSERT INTO LigneOption VALUES (7858,121); 
INSERT INTO LigneOption VALUES (7858,103); 
INSERT INTO LigneOption VALUES (7858,102); 
INSERT INTO LigneOption VALUES (7858,101); 
INSERT INTO LigneOption VALUES (7858,119); 
INSERT INTO LigneOption VALUES (7858,120); 
INSERT INTO LigneOption VALUES (7858,133); 
INSERT INTO LigneOption VALUES (7858,129); 
INSERT INTO LigneOption VALUES (7858,125); 
INSERT INTO LigneOption VALUES (7858,126); 
INSERT INTO LigneOption VALUES (7858,115); 
INSERT INTO LigneOption VALUES (7858,127); 
INSERT INTO LigneOption VALUES (7858,130); 
INSERT INTO LigneOption VALUES (7858,105); 
INSERT INTO LigneOption VALUES (7858,100); 
INSERT INTO LigneOption VALUES (7858,118); 
INSERT INTO LigneOption VALUES (7858,116); 
INSERT INTO LigneOption VALUES (7858,131); 
INSERT INTO LigneOption VALUES (7858,106); 
INSERT INTO LigneOption VALUES (7858,122); 
INSERT INTO LigneOption VALUES (7858,107); 
INSERT INTO LigneOption VALUES (7858,117); 
INSERT INTO LigneOption VALUES (7858,108); 
INSERT INTO LigneOption VALUES (7858,109); 
INSERT INTO LigneOption VALUES (7858,123); 
INSERT INTO LigneOption VALUES (7858,110); 
INSERT INTO LigneOption VALUES (7859,111); 
INSERT INTO LigneOption VALUES (7859,112); 
INSERT INTO LigneOption VALUES (7859,132); 
INSERT INTO LigneOption VALUES (7859,128); 
INSERT INTO LigneOption VALUES (7859,113); 
INSERT INTO LigneOption VALUES (7859,124); 
INSERT INTO LigneOption VALUES (7859,104); 
INSERT INTO LigneOption VALUES (7859,114); 
INSERT INTO LigneOption VALUES (7859,121); 
INSERT INTO LigneOption VALUES (7859,103); 
INSERT INTO LigneOption VALUES (7859,102); 
INSERT INTO LigneOption VALUES (7859,101); 
INSERT INTO LigneOption VALUES (7859,119); 
INSERT INTO LigneOption VALUES (7859,120); 
INSERT INTO LigneOption VALUES (7859,133); 
INSERT INTO LigneOption VALUES (7859,129); 
INSERT INTO LigneOption VALUES (7859,125); 
INSERT INTO LigneOption VALUES (7859,126); 
INSERT INTO LigneOption VALUES (7859,115); 
INSERT INTO LigneOption VALUES (7859,127); 
INSERT INTO LigneOption VALUES (7859,130); 
INSERT INTO LigneOption VALUES (7859,105); 
INSERT INTO LigneOption VALUES (7859,100); 
INSERT INTO LigneOption VALUES (7859,118); 
INSERT INTO LigneOption VALUES (7859,116); 
INSERT INTO LigneOption VALUES (7859,131); 
INSERT INTO LigneOption VALUES (7859,106); 
INSERT INTO LigneOption VALUES (7859,122); 
INSERT INTO LigneOption VALUES (7859,107); 
INSERT INTO LigneOption VALUES (7859,117); 
INSERT INTO LigneOption VALUES (7859,108); 
INSERT INTO LigneOption VALUES (7859,109); 
INSERT INTO LigneOption VALUES (7859,123); 
INSERT INTO LigneOption VALUES (7859,110); 
INSERT INTO LigneOption VALUES (7860,111); 
INSERT INTO LigneOption VALUES (7860,112); 
INSERT INTO LigneOption VALUES (7860,132); 
INSERT INTO LigneOption VALUES (7860,128); 
INSERT INTO LigneOption VALUES (7860,113); 
INSERT INTO LigneOption VALUES (7860,124); 
INSERT INTO LigneOption VALUES (7860,104); 
INSERT INTO LigneOption VALUES (7860,114); 
INSERT INTO LigneOption VALUES (7860,121); 
INSERT INTO LigneOption VALUES (7860,103); 
INSERT INTO LigneOption VALUES (7860,102); 
INSERT INTO LigneOption VALUES (7860,101); 
INSERT INTO LigneOption VALUES (7860,119); 
INSERT INTO LigneOption VALUES (7860,120); 
INSERT INTO LigneOption VALUES (7860,133); 
INSERT INTO LigneOption VALUES (7860,129); 
INSERT INTO LigneOption VALUES (7860,125); 
INSERT INTO LigneOption VALUES (7860,126); 
INSERT INTO LigneOption VALUES (7860,115); 
INSERT INTO LigneOption VALUES (7860,127); 
INSERT INTO LigneOption VALUES (7860,130); 
INSERT INTO LigneOption VALUES (7860,105); 
INSERT INTO LigneOption VALUES (7860,100); 
INSERT INTO LigneOption VALUES (7860,118); 
INSERT INTO LigneOption VALUES (7860,116); 
INSERT INTO LigneOption VALUES (7860,131); 
INSERT INTO LigneOption VALUES (7860,106); 
INSERT INTO LigneOption VALUES (7860,122); 
INSERT INTO LigneOption VALUES (7860,107); 
INSERT INTO LigneOption VALUES (7860,117); 
INSERT INTO LigneOption VALUES (7860,108); 
INSERT INTO LigneOption VALUES (7860,109); 
INSERT INTO LigneOption VALUES (7860,123); 
INSERT INTO LigneOption VALUES (7860,110); 
INSERT INTO LigneOption VALUES (7861,111); 
INSERT INTO LigneOption VALUES (7861,112); 
INSERT INTO LigneOption VALUES (7861,132); 
INSERT INTO LigneOption VALUES (7861,128); 
INSERT INTO LigneOption VALUES (7861,113); 
INSERT INTO LigneOption VALUES (7861,124); 
INSERT INTO LigneOption VALUES (7861,104); 
INSERT INTO LigneOption VALUES (7861,114); 
INSERT INTO LigneOption VALUES (7861,121); 
INSERT INTO LigneOption VALUES (7861,103); 
INSERT INTO LigneOption VALUES (7861,102); 
INSERT INTO LigneOption VALUES (7861,101); 
INSERT INTO LigneOption VALUES (7861,119); 
INSERT INTO LigneOption VALUES (7861,120); 
INSERT INTO LigneOption VALUES (7861,133); 
INSERT INTO LigneOption VALUES (7861,129); 
INSERT INTO LigneOption VALUES (7861,125); 
INSERT INTO LigneOption VALUES (7861,126); 
INSERT INTO LigneOption VALUES (7861,115); 
INSERT INTO LigneOption VALUES (7861,127); 
INSERT INTO LigneOption VALUES (7861,130); 
INSERT INTO LigneOption VALUES (7861,105); 
INSERT INTO LigneOption VALUES (7861,100); 
INSERT INTO LigneOption VALUES (7861,118); 
INSERT INTO LigneOption VALUES (7861,116); 
INSERT INTO LigneOption VALUES (7861,131); 
INSERT INTO LigneOption VALUES (7861,106); 
INSERT INTO LigneOption VALUES (7861,122); 
INSERT INTO LigneOption VALUES (7861,107); 
INSERT INTO LigneOption VALUES (7861,117); 
INSERT INTO LigneOption VALUES (7861,108); 
INSERT INTO LigneOption VALUES (7861,109); 
INSERT INTO LigneOption VALUES (7861,123); 
INSERT INTO LigneOption VALUES (7861,110); 
INSERT INTO LigneOption VALUES (7862,111); 
INSERT INTO LigneOption VALUES (7862,112); 
INSERT INTO LigneOption VALUES (7862,132); 
INSERT INTO LigneOption VALUES (7862,128); 
INSERT INTO LigneOption VALUES (7862,113); 
INSERT INTO LigneOption VALUES (7862,124); 
INSERT INTO LigneOption VALUES (7862,104); 
INSERT INTO LigneOption VALUES (7862,114); 
INSERT INTO LigneOption VALUES (7862,121); 
INSERT INTO LigneOption VALUES (7862,103); 
INSERT INTO LigneOption VALUES (7862,102); 
INSERT INTO LigneOption VALUES (7862,101); 
INSERT INTO LigneOption VALUES (7862,119); 
INSERT INTO LigneOption VALUES (7862,120); 
INSERT INTO LigneOption VALUES (7862,133); 
INSERT INTO LigneOption VALUES (7862,129); 
INSERT INTO LigneOption VALUES (7862,125); 
INSERT INTO LigneOption VALUES (7862,126); 
INSERT INTO LigneOption VALUES (7862,115); 
INSERT INTO LigneOption VALUES (7862,127); 
INSERT INTO LigneOption VALUES (7862,130); 
INSERT INTO LigneOption VALUES (7862,105); 
INSERT INTO LigneOption VALUES (7862,100); 
INSERT INTO LigneOption VALUES (7862,118); 
INSERT INTO LigneOption VALUES (7862,116); 
INSERT INTO LigneOption VALUES (7862,131); 
INSERT INTO LigneOption VALUES (7862,106); 
INSERT INTO LigneOption VALUES (7862,122); 
INSERT INTO LigneOption VALUES (7862,107); 
INSERT INTO LigneOption VALUES (7862,117); 
INSERT INTO LigneOption VALUES (7862,108); 
INSERT INTO LigneOption VALUES (7862,109); 
INSERT INTO LigneOption VALUES (7862,123); 
INSERT INTO LigneOption VALUES (7862,110); 
INSERT INTO LigneOption VALUES (7863,111); 
INSERT INTO LigneOption VALUES (7863,112); 
INSERT INTO LigneOption VALUES (7863,132); 
INSERT INTO LigneOption VALUES (7863,128); 
INSERT INTO LigneOption VALUES (7863,113); 
INSERT INTO LigneOption VALUES (7863,124); 
INSERT INTO LigneOption VALUES (7863,104); 
INSERT INTO LigneOption VALUES (7863,114); 
INSERT INTO LigneOption VALUES (7863,121); 
INSERT INTO LigneOption VALUES (7863,103); 
INSERT INTO LigneOption VALUES (7863,102); 
INSERT INTO LigneOption VALUES (7863,101); 
INSERT INTO LigneOption VALUES (7863,119); 
INSERT INTO LigneOption VALUES (7863,120); 
INSERT INTO LigneOption VALUES (7863,133); 
INSERT INTO LigneOption VALUES (7863,129); 
INSERT INTO LigneOption VALUES (7863,125); 
INSERT INTO LigneOption VALUES (7863,126); 
INSERT INTO LigneOption VALUES (7863,115); 
INSERT INTO LigneOption VALUES (7863,127); 
INSERT INTO LigneOption VALUES (7863,130); 
INSERT INTO LigneOption VALUES (7863,105); 
INSERT INTO LigneOption VALUES (7863,100); 
INSERT INTO LigneOption VALUES (7863,118); 
INSERT INTO LigneOption VALUES (7863,116); 
INSERT INTO LigneOption VALUES (7863,131); 
INSERT INTO LigneOption VALUES (7863,106); 
INSERT INTO LigneOption VALUES (7863,122); 
INSERT INTO LigneOption VALUES (7863,107); 
INSERT INTO LigneOption VALUES (7863,117); 
INSERT INTO LigneOption VALUES (7863,108); 
INSERT INTO LigneOption VALUES (7863,109); 
INSERT INTO LigneOption VALUES (7863,123); 
INSERT INTO LigneOption VALUES (7863,110); 
INSERT INTO LigneOption VALUES (7864,111); 
INSERT INTO LigneOption VALUES (7864,112); 
INSERT INTO LigneOption VALUES (7864,132); 
INSERT INTO LigneOption VALUES (7864,128); 
INSERT INTO LigneOption VALUES (7864,113); 
INSERT INTO LigneOption VALUES (7864,124); 
INSERT INTO LigneOption VALUES (7864,104); 
INSERT INTO LigneOption VALUES (7864,114); 
INSERT INTO LigneOption VALUES (7864,121); 
INSERT INTO LigneOption VALUES (7864,103); 
INSERT INTO LigneOption VALUES (7864,102); 
INSERT INTO LigneOption VALUES (7864,101); 
INSERT INTO LigneOption VALUES (7864,119); 
INSERT INTO LigneOption VALUES (7864,120); 
INSERT INTO LigneOption VALUES (7864,133); 
INSERT INTO LigneOption VALUES (7864,129); 
INSERT INTO LigneOption VALUES (7864,125); 
INSERT INTO LigneOption VALUES (7864,126); 
INSERT INTO LigneOption VALUES (7864,115); 
INSERT INTO LigneOption VALUES (7864,127); 
INSERT INTO LigneOption VALUES (7864,130); 
INSERT INTO LigneOption VALUES (7864,105); 
INSERT INTO LigneOption VALUES (7864,100); 
INSERT INTO LigneOption VALUES (7864,118); 
INSERT INTO LigneOption VALUES (7864,116); 
INSERT INTO LigneOption VALUES (7864,131); 
INSERT INTO LigneOption VALUES (7864,106); 
INSERT INTO LigneOption VALUES (7864,122); 
INSERT INTO LigneOption VALUES (7864,107); 
INSERT INTO LigneOption VALUES (7864,117); 
INSERT INTO LigneOption VALUES (7864,108); 
INSERT INTO LigneOption VALUES (7864,109); 
INSERT INTO LigneOption VALUES (7864,123); 
INSERT INTO LigneOption VALUES (7864,110); 
INSERT INTO LigneOption VALUES (7865,111); 
INSERT INTO LigneOption VALUES (7865,112); 
INSERT INTO LigneOption VALUES (7865,132); 
INSERT INTO LigneOption VALUES (7865,128); 
INSERT INTO LigneOption VALUES (7865,113); 
INSERT INTO LigneOption VALUES (7865,124); 
INSERT INTO LigneOption VALUES (7865,104); 
INSERT INTO LigneOption VALUES (7865,114); 
INSERT INTO LigneOption VALUES (7865,121); 
INSERT INTO LigneOption VALUES (7865,103); 
INSERT INTO LigneOption VALUES (7865,102); 
INSERT INTO LigneOption VALUES (7865,101); 
INSERT INTO LigneOption VALUES (7865,119); 
INSERT INTO LigneOption VALUES (7865,120); 
INSERT INTO LigneOption VALUES (7865,133); 
INSERT INTO LigneOption VALUES (7865,129); 
INSERT INTO LigneOption VALUES (7865,125); 
INSERT INTO LigneOption VALUES (7865,126); 
INSERT INTO LigneOption VALUES (7865,115); 
INSERT INTO LigneOption VALUES (7865,127); 
INSERT INTO LigneOption VALUES (7865,130); 
INSERT INTO LigneOption VALUES (7865,105); 
INSERT INTO LigneOption VALUES (7865,100); 
INSERT INTO LigneOption VALUES (7865,118); 
INSERT INTO LigneOption VALUES (7865,116); 
INSERT INTO LigneOption VALUES (7865,131); 
INSERT INTO LigneOption VALUES (7865,106); 
INSERT INTO LigneOption VALUES (7865,122); 
INSERT INTO LigneOption VALUES (7865,107); 
INSERT INTO LigneOption VALUES (7865,117); 
INSERT INTO LigneOption VALUES (7865,108); 
INSERT INTO LigneOption VALUES (7865,109); 
INSERT INTO LigneOption VALUES (7865,123); 
INSERT INTO LigneOption VALUES (7865,110); 
INSERT INTO LigneOption VALUES (7866,111); 
INSERT INTO LigneOption VALUES (7866,112); 
INSERT INTO LigneOption VALUES (7866,132); 
INSERT INTO LigneOption VALUES (7866,128); 
INSERT INTO LigneOption VALUES (7866,113); 
INSERT INTO LigneOption VALUES (7866,124); 
INSERT INTO LigneOption VALUES (7866,104); 
INSERT INTO LigneOption VALUES (7866,114); 
INSERT INTO LigneOption VALUES (7866,121); 
INSERT INTO LigneOption VALUES (7866,103); 
INSERT INTO LigneOption VALUES (7866,102); 
INSERT INTO LigneOption VALUES (7866,101); 
INSERT INTO LigneOption VALUES (7866,119); 
INSERT INTO LigneOption VALUES (7866,120); 
INSERT INTO LigneOption VALUES (7866,133); 
INSERT INTO LigneOption VALUES (7866,129); 
INSERT INTO LigneOption VALUES (7866,125); 
INSERT INTO LigneOption VALUES (7866,126); 
INSERT INTO LigneOption VALUES (7866,115); 
INSERT INTO LigneOption VALUES (7866,127); 
INSERT INTO LigneOption VALUES (7866,130); 
INSERT INTO LigneOption VALUES (7866,105); 
INSERT INTO LigneOption VALUES (7866,100); 
INSERT INTO LigneOption VALUES (7866,118); 
INSERT INTO LigneOption VALUES (7866,116); 
INSERT INTO LigneOption VALUES (7866,131); 
INSERT INTO LigneOption VALUES (7866,106); 
INSERT INTO LigneOption VALUES (7866,122); 
INSERT INTO LigneOption VALUES (7866,107); 
INSERT INTO LigneOption VALUES (7866,117); 
INSERT INTO LigneOption VALUES (7866,108); 
INSERT INTO LigneOption VALUES (7866,109); 
INSERT INTO LigneOption VALUES (7866,123); 
INSERT INTO LigneOption VALUES (7866,110); 
INSERT INTO LigneOption VALUES (7867,111); 
INSERT INTO LigneOption VALUES (7867,112); 
INSERT INTO LigneOption VALUES (7867,132); 
INSERT INTO LigneOption VALUES (7867,128); 
INSERT INTO LigneOption VALUES (7867,113); 
INSERT INTO LigneOption VALUES (7867,124); 
INSERT INTO LigneOption VALUES (7867,104); 
INSERT INTO LigneOption VALUES (7867,114); 
INSERT INTO LigneOption VALUES (7867,121); 
INSERT INTO LigneOption VALUES (7867,103); 
INSERT INTO LigneOption VALUES (7867,102); 
INSERT INTO LigneOption VALUES (7867,101); 
INSERT INTO LigneOption VALUES (7867,119); 
INSERT INTO LigneOption VALUES (7867,120); 
INSERT INTO LigneOption VALUES (7867,133); 
INSERT INTO LigneOption VALUES (7867,129); 
INSERT INTO LigneOption VALUES (7867,125); 
INSERT INTO LigneOption VALUES (7867,126); 
INSERT INTO LigneOption VALUES (7867,115); 
INSERT INTO LigneOption VALUES (7867,127); 
INSERT INTO LigneOption VALUES (7867,130); 
INSERT INTO LigneOption VALUES (7867,105); 
INSERT INTO LigneOption VALUES (7867,100); 
INSERT INTO LigneOption VALUES (7867,118); 
INSERT INTO LigneOption VALUES (7867,116); 
INSERT INTO LigneOption VALUES (7867,131); 
INSERT INTO LigneOption VALUES (7867,106); 
INSERT INTO LigneOption VALUES (7867,122); 
INSERT INTO LigneOption VALUES (7867,107); 
INSERT INTO LigneOption VALUES (7867,117); 
INSERT INTO LigneOption VALUES (7867,108); 
INSERT INTO LigneOption VALUES (7867,109); 
INSERT INTO LigneOption VALUES (7867,123); 
INSERT INTO LigneOption VALUES (7867,110); 
INSERT INTO LigneOption VALUES (7868,111); 
INSERT INTO LigneOption VALUES (7868,112); 
INSERT INTO LigneOption VALUES (7868,132); 
INSERT INTO LigneOption VALUES (7868,128); 
INSERT INTO LigneOption VALUES (7868,113); 
INSERT INTO LigneOption VALUES (7868,124); 
INSERT INTO LigneOption VALUES (7868,104); 
INSERT INTO LigneOption VALUES (7868,127); 
INSERT INTO LigneOption VALUES (7868,130); 
INSERT INTO LigneOption VALUES (7868,105); 
INSERT INTO LigneOption VALUES (7868,100); 
INSERT INTO LigneOption VALUES (7868,118); 
INSERT INTO LigneOption VALUES (7868,116); 
INSERT INTO LigneOption VALUES (7868,131); 
INSERT INTO LigneOption VALUES (7868,106); 
INSERT INTO LigneOption VALUES (7868,122); 
INSERT INTO LigneOption VALUES (7868,107); 
INSERT INTO LigneOption VALUES (7868,117); 
INSERT INTO LigneOption VALUES (7868,108); 
INSERT INTO LigneOption VALUES (7868,109); 
INSERT INTO LigneOption VALUES (7868,123); 
INSERT INTO LigneOption VALUES (7868,110); 
INSERT INTO LigneOption VALUES (7870,118); 
INSERT INTO LigneOption VALUES (7870,116); 
INSERT INTO LigneOption VALUES (7870,131); 
INSERT INTO LigneOption VALUES (7870,106); 
INSERT INTO LigneOption VALUES (7872,113); 
INSERT INTO LigneOption VALUES (7872,124); 
INSERT INTO LigneOption VALUES (7872,104); 
INSERT INTO LigneOption VALUES (7872,114); 
INSERT INTO LigneOption VALUES (7872,121); 
INSERT INTO LigneOption VALUES (7872,103); 
INSERT INTO LigneOption VALUES (7872,102); 
INSERT INTO LigneOption VALUES (7872,101); 
INSERT INTO LigneOption VALUES (7872,110); 
INSERT INTO LigneOption VALUES (7873,111); 
INSERT INTO LigneOption VALUES (7873,112); 
INSERT INTO LigneOption VALUES (7873,132); 
INSERT INTO LigneOption VALUES (7873,128); 
INSERT INTO LigneOption VALUES (7873,113); 
INSERT INTO LigneOption VALUES (7873,118); 
INSERT INTO LigneOption VALUES (7873,116); 
INSERT INTO LigneOption VALUES (7873,131); 
INSERT INTO LigneOption VALUES (7873,106); 
INSERT INTO LigneOption VALUES (7873,122); 
INSERT INTO LigneOption VALUES (7873,107); 
INSERT INTO LigneOption VALUES (7873,117); 
INSERT INTO LigneOption VALUES (7873,108); 
INSERT INTO LigneOption VALUES (7873,109); 
INSERT INTO LigneOption VALUES (7873,123); 
INSERT INTO LigneOption VALUES (7873,110); 
INSERT INTO LigneOption VALUES (7874,111); 
INSERT INTO LigneOption VALUES (7874,112); 
INSERT INTO LigneOption VALUES (7874,132); 
INSERT INTO LigneOption VALUES (7874,128); 
INSERT INTO LigneOption VALUES (7874,113); 
INSERT INTO LigneOption VALUES (7874,100); 
INSERT INTO LigneOption VALUES (7874,118); 
INSERT INTO LigneOption VALUES (7874,116); 
INSERT INTO LigneOption VALUES (7874,131); 
INSERT INTO LigneOption VALUES (7874,106); 
INSERT INTO LigneOption VALUES (7874,122); 
INSERT INTO LigneOption VALUES (7874,107); 
INSERT INTO LigneOption VALUES (7874,117); 
INSERT INTO LigneOption VALUES (7874,108); 
INSERT INTO LigneOption VALUES (7874,109); 
INSERT INTO LigneOption VALUES (7874,123); 
INSERT INTO LigneOption VALUES (7874,110); 
INSERT INTO LigneOption VALUES (7875,111); 
INSERT INTO LigneOption VALUES (7875,112); 
INSERT INTO LigneOption VALUES (7875,132); 
INSERT INTO LigneOption VALUES (7875,115); 
INSERT INTO LigneOption VALUES (7875,127); 
INSERT INTO LigneOption VALUES (7875,130); 
INSERT INTO LigneOption VALUES (7875,105); 
INSERT INTO LigneOption VALUES (7875,100); 
INSERT INTO LigneOption VALUES (7875,118); 
INSERT INTO LigneOption VALUES (7875,116); 
INSERT INTO LigneOption VALUES (7875,131); 
INSERT INTO LigneOption VALUES (7875,106); 
INSERT INTO LigneOption VALUES (7875,122); 
INSERT INTO LigneOption VALUES (7875,107); 
INSERT INTO LigneOption VALUES (7875,117); 
INSERT INTO LigneOption VALUES (7875,108); 
INSERT INTO LigneOption VALUES (7875,109); 
INSERT INTO LigneOption VALUES (7875,123); 
INSERT INTO LigneOption VALUES (7875,110); 
INSERT INTO LigneOption VALUES (7876,111); 
INSERT INTO LigneOption VALUES (7876,112); 
INSERT INTO LigneOption VALUES (7876,132); 
INSERT INTO LigneOption VALUES (7876,128); 
INSERT INTO LigneOption VALUES (7876,113); 
INSERT INTO LigneOption VALUES (7876,124); 
INSERT INTO LigneOption VALUES (7876,104); 
INSERT INTO LigneOption VALUES (7876,114); 
INSERT INTO LigneOption VALUES (7876,130); 
INSERT INTO LigneOption VALUES (7876,105); 
INSERT INTO LigneOption VALUES (7876,100); 
INSERT INTO LigneOption VALUES (7876,118); 
INSERT INTO LigneOption VALUES (7876,116); 
INSERT INTO LigneOption VALUES (7876,131); 
INSERT INTO LigneOption VALUES (7876,106); 
INSERT INTO LigneOption VALUES (7876,122); 
INSERT INTO LigneOption VALUES (7876,107); 
INSERT INTO LigneOption VALUES (7876,117); 
INSERT INTO LigneOption VALUES (7876,108); 
INSERT INTO LigneOption VALUES (7876,109); 
INSERT INTO LigneOption VALUES (7876,123); 
INSERT INTO LigneOption VALUES (7876,110); 
INSERT INTO LigneOption VALUES (7877,111); 
INSERT INTO LigneOption VALUES (7877,112); 
INSERT INTO LigneOption VALUES (7884,114); 
INSERT INTO LigneOption VALUES (7884,121); 
INSERT INTO LigneOption VALUES (7884,103); 
INSERT INTO LigneOption VALUES (7884,102); 
INSERT INTO LigneOption VALUES (7884,101); 
INSERT INTO LigneOption VALUES (7884,100); 
INSERT INTO LigneOption VALUES (7884,118); 
INSERT INTO LigneOption VALUES (7884,116); 
INSERT INTO LigneOption VALUES (7884,131); 
INSERT INTO LigneOption VALUES (7884,106); 
INSERT INTO LigneOption VALUES (7884,122); 
INSERT INTO LigneOption VALUES (7884,107); 
INSERT INTO LigneOption VALUES (7884,117); 
INSERT INTO LigneOption VALUES (7884,108); 
INSERT INTO LigneOption VALUES (7884,109); 
INSERT INTO LigneOption VALUES (7884,123); 
INSERT INTO LigneOption VALUES (7884,110); 
INSERT INTO LigneOption VALUES (7885,111); 
INSERT INTO LigneOption VALUES (7885,112); 
INSERT INTO LigneOption VALUES (7885,132); 
INSERT INTO LigneOption VALUES (7885,128); 
INSERT INTO LigneOption VALUES (7885,113); 
INSERT INTO LigneOption VALUES (7885,124); 
INSERT INTO LigneOption VALUES (7885,104); 
INSERT INTO LigneOption VALUES (7885,114); 
INSERT INTO LigneOption VALUES (7885,121); 
INSERT INTO LigneOption VALUES (7885,103); 
INSERT INTO LigneOption VALUES (7885,102); 
INSERT INTO LigneOption VALUES (7885,109); 
INSERT INTO LigneOption VALUES (7885,123); 
INSERT INTO LigneOption VALUES (7885,110); 
INSERT INTO LigneOption VALUES (7886,111); 
INSERT INTO LigneOption VALUES (7886,112); 
INSERT INTO LigneOption VALUES (7886,132); 
INSERT INTO LigneOption VALUES (7886,128); 
INSERT INTO LigneOption VALUES (7886,113); 
INSERT INTO LigneOption VALUES (7886,124); 
INSERT INTO LigneOption VALUES (7886,104); 
INSERT INTO LigneOption VALUES (7886,114); 
INSERT INTO LigneOption VALUES (7886,121); 
INSERT INTO LigneOption VALUES (7886,103); 
INSERT INTO LigneOption VALUES (7886,102); 
INSERT INTO LigneOption VALUES (7886,101); 
INSERT INTO LigneOption VALUES (7886,119); 
INSERT INTO LigneOption VALUES (7886,120); 
INSERT INTO LigneOption VALUES (7886,133); 
INSERT INTO LigneOption VALUES (7886,129); 
INSERT INTO LigneOption VALUES (7886,125); 
INSERT INTO LigneOption VALUES (7886,126); 
INSERT INTO LigneOption VALUES (7886,115); 
INSERT INTO LigneOption VALUES (7886,127); 
INSERT INTO LigneOption VALUES (7886,130); 
INSERT INTO LigneOption VALUES (7886,105); 
INSERT INTO LigneOption VALUES (7886,100); 
INSERT INTO LigneOption VALUES (7886,118); 
INSERT INTO LigneOption VALUES (7886,116); 
INSERT INTO LigneOption VALUES (7886,131); 
INSERT INTO LigneOption VALUES (7886,106); 
INSERT INTO LigneOption VALUES (7886,122); 
INSERT INTO LigneOption VALUES (7886,107); 
INSERT INTO LigneOption VALUES (7886,117); 
INSERT INTO LigneOption VALUES (7886,108); 
INSERT INTO LigneOption VALUES (7886,109); 
INSERT INTO LigneOption VALUES (7886,123); 
INSERT INTO LigneOption VALUES (7886,110); 
INSERT INTO LigneOption VALUES (7887,111); 
INSERT INTO LigneOption VALUES (7887,112); 
INSERT INTO LigneOption VALUES (7887,132); 
INSERT INTO LigneOption VALUES (7887,128); 
INSERT INTO LigneOption VALUES (7887,113); 
INSERT INTO LigneOption VALUES (7887,124); 
INSERT INTO LigneOption VALUES (7887,104); 
INSERT INTO LigneOption VALUES (7887,114); 
INSERT INTO LigneOption VALUES (7887,121); 
INSERT INTO LigneOption VALUES (7887,103); 
INSERT INTO LigneOption VALUES (7887,102); 
INSERT INTO LigneOption VALUES (7887,101); 
INSERT INTO LigneOption VALUES (7887,119); 
INSERT INTO LigneOption VALUES (7887,120); 
INSERT INTO LigneOption VALUES (7887,133); 
INSERT INTO LigneOption VALUES (7887,129); 
INSERT INTO LigneOption VALUES (7887,125); 
INSERT INTO LigneOption VALUES (7887,126); 
INSERT INTO LigneOption VALUES (7887,115); 
INSERT INTO LigneOption VALUES (7887,127); 
INSERT INTO LigneOption VALUES (7887,130); 
INSERT INTO LigneOption VALUES (7887,105); 
INSERT INTO LigneOption VALUES (7887,100); 
INSERT INTO LigneOption VALUES (7887,118); 
INSERT INTO LigneOption VALUES (7887,116); 
INSERT INTO LigneOption VALUES (7887,131); 
INSERT INTO LigneOption VALUES (7887,106); 
INSERT INTO LigneOption VALUES (7887,122); 
INSERT INTO LigneOption VALUES (7887,107); 
INSERT INTO LigneOption VALUES (7887,117); 
INSERT INTO LigneOption VALUES (7887,108); 
INSERT INTO LigneOption VALUES (7887,109); 
INSERT INTO LigneOption VALUES (7887,123); 
INSERT INTO LigneOption VALUES (7887,110); 
INSERT INTO LigneOption VALUES (7888,111); 
INSERT INTO LigneOption VALUES (7888,112); 
INSERT INTO LigneOption VALUES (7888,132); 
INSERT INTO LigneOption VALUES (7888,128); 
INSERT INTO LigneOption VALUES (7888,113); 
INSERT INTO LigneOption VALUES (7888,129); 
INSERT INTO LigneOption VALUES (7888,125); 
INSERT INTO LigneOption VALUES (7888,126); 
INSERT INTO LigneOption VALUES (7888,115); 
INSERT INTO LigneOption VALUES (7926,119); 
INSERT INTO LigneOption VALUES (7926,120); 
INSERT INTO LigneOption VALUES (7926,133); 
INSERT INTO LigneOption VALUES (7926,129); 
INSERT INTO LigneOption VALUES (7926,125); 
INSERT INTO LigneOption VALUES (7926,126); 
INSERT INTO LigneOption VALUES (7926,115); 
INSERT INTO LigneOption VALUES (7926,127); 
INSERT INTO LigneOption VALUES (7926,130); 
INSERT INTO LigneOption VALUES (7926,105); 
INSERT INTO LigneOption VALUES (7926,100); 
INSERT INTO LigneOption VALUES (7926,118); 
INSERT INTO LigneOption VALUES (7926,116); 
INSERT INTO LigneOption VALUES (7926,131); 
INSERT INTO LigneOption VALUES (7926,106); 
INSERT INTO LigneOption VALUES (7926,122); 
INSERT INTO LigneOption VALUES (7926,107); 
INSERT INTO LigneOption VALUES (7926,117); 
INSERT INTO LigneOption VALUES (7926,108); 
INSERT INTO LigneOption VALUES (7926,109); 

-- Trigger de Mise à jour du prix d'un Devis : Lorsqu'une option est ajoutée au devis : le prix est recalculé

delimiter //
CREATE TRIGGER maj_prix_devis
AFTER INSERT ON LigneOption FOR EACH ROW
BEGIN
	DECLARE v_prixOp float(8,2);
	SET @v_prixOp = (SELECT prixOption FROM Options WHERE idOption = NEW.idOption); 
	UPDATE Devis SET prixDevis = prixDevis + @v_prixOp WHERE idDevis = NEW.idDevis;
END;//
delimiter ;

/* Ce trigger sert à vérifier que les options sont à jours :
Lorsqu'une option est créée, on vérifie que le nom n'existe pas déjà en parcourant toutes les options existantes
Si elle existe déjà, on parcourt alors toutes les lignes d'options (des devis) qui la contiennent afin de remplacer l'id de l'option par celle qui vient d'être créée
En effet on considère que la seconde est une "mise à jour" de l'option déjà existante, devenue obsolète 
Dans le cas où le Devis est déjà en état "Validé", la modification n'est pas appliquée. C'est pour cela que l'on ne supprime pas de la base les 'anciennes' options */

delimiter //
CREATE TRIGGER check_exist_option_devis
AFTER INSERT ON Options FOR EACH ROW
BEGIN 
	DECLARE nomOpt varchar(50);   -- Prendra le nom de chacune des options présente dans la bd 
	DECLARE idOpt smallint(4); 		-- Prendra l'id de chacune des options présente dans la bd */
	DECLARE idLiOpt smallint(4);    -- Prendra l'id de chacune des options présente dans chacune des 'ligneOption' (correspondant à un devis) */
	DECLARE v_etat char(2);          -- Prendra l'état du devis pour vérifier si on modifie la ligne option ou pas
	DECLARE idDev smallint(4);       -- Prendra l'id du devis concerné par l'éventuelle modification de ligne option

	DECLARE done INTEGER DEFAULT FALSE;   -- Pour le curseur des options 
	DECLARE cursOpt CURSOR FOR SELECT idOption, nomOption FROM Options;  -- Curseur de parcours des options de la bd 
	DECLARE cursLigneOpt CURSOR FOR SELECT idOption, idDevis FROM ligneOption; 	-- Curseur de parcours des ligneOption 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;

	OPEN cursOpt;
	cursOpt_loop: LOOP       -- Bouble sur le curseur des options 
		FETCH cursOpt INTO idOpt, nomOpt;   
		IF done THEN 
			LEAVE cursOpt_loop;  -- Fin de la boucle si plus d'options 
		END IF;

		BLOCK2:BEGIN
			DECLARE finished INTEGER DEFAULT FALSE;  -- Pour le curseur des ligneOption 
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE ;
			IF UPPER(REPLACE(New.nomOption,' ','')) = UPPER(REPLACE(nomOpt,' ','')) THEN   -- Comparaison de chacun des noms d'options existants avec le nouveau en création 
				OPEN cursLigneOpt;
				cursLigneOpt_loop: LOOP    -- Si correspondance, on boucle sur les ligneOption pour les modifier */
					FETCH cursLigneOpt INTO idLiOpt, idDev;
					IF finished THEN
						CLOSE cursLigneOpt;
						LEAVE cursLigneOpt_loop;   -- Fin de la boucle si plus de lignes 
					END IF;
					IF idLiOpt = idOpt THEN 
						SET @v_etat = (SELECT idEtat FROM Devis WHERE idDevis = idDev);   -- Vérification que le devis concerné par la ligne option n'est pas déjà validé
						IF @v_etat <> 'VA' THEN
							UPDATE ligneOption SET idOption = New.idOption WHERE idOption = idOpt AND idDevis = idDev;  -- Modification de l'id Option de la ligne si correspondance avec l'option modifiée et si Devis pas validé
						END IF;
					END IF;
				END LOOP;
			END IF ;
		END BLOCK2;
	END LOOP;
	CLOSE cursOpt;	
END;//
delimiter ;

-- Trigger de Mise à jour du prix d'un Devis : Lorsque le prix d'une option est modifié, le prix total du devis est mis à jour

delimiter //
CREATE TRIGGER maj_prix_devis_after_update
AFTER UPDATE ON LigneOption FOR EACH ROW
BEGIN
	DECLARE v_NvprixOp float(8,2);   -- Nouveau prix
	DECLARE v_AncprixOp float(8,2);  -- Ancien prix
	SET @v_NvprixOp = (SELECT prixOption FROM Options WHERE idOption = NEW.idOption);
	SET @v_AncprixOp = (SELECT prixOption FROM Options WHERE idOption = OLD.idOption);
	UPDATE Devis SET prixDevis = prixDevis - @v_AncprixOp + @v_NvprixOp WHERE idDevis = NEW.idDevis;  -- On retire au prix total du devis l'ancien prix de l'option et on ajoute le nouveau
END;//
delimiter ;