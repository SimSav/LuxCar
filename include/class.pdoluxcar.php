<?php
include_once ("fonctions.php");
/**
 * Classe d'accès aux données
 */


class PdoLxc{
	private static $serveur='mysql:host=127.0.0.1';
	private static $bd='dbname=LuxCar';
	private static $user='root';
	private static $mdp='';
	private static $monPdo;
	private static $monPdoLxc=null;

// Crée l'instance de PDO qui sera sollicitée pour toutes les méthodes de la classe */
	private function __construct(){
		try{
			PdoLxc::$monPdo = new PDO(PdoLxc::$serveur.';'.PdoLxc::$bd, PdoLxc::$user, PdoLxc::$mdp);
			PdoLxc::$monPdo->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
			PdoLxc::$monPdo->query("SET CHARACTER SET utf8");
		}
		catch (PDOException $e){
			echo "Erreur de connexion au serveur : ", $e->getMessage();
		}	
	}

	public function _destruct(){
		PdoLxc::$monPdo = null ;
	}

// Crée l'unique instance de la classe */
	public static function getPdoLxc(){
		if(PdoLxc::$monPdoLxc==null){
			PdoLxc::$monPdoLxc = new PdoLxc();
		}
		return PdoLxc::$monPdoLxc;
	}

// Enregistre dans une variable session le token d'un utilisateur
function connecter($id){
		setcookie('idUser',$id);             // affectation au cookie de l'ID du User qui se connecte
		$token = uniqid();
		setcookie('tokenUser',$token);       // affectation au cookie du token généré aléatoirement pour le User qui se connecte
		$req = 'UPDATE Inscrit SET token ="'.$token.'" WHERE idInscrit ='.$id;    // insertion du token dans la base pour le User qui se connecte
		$rs = PdoLxc::$monPdo->exec($req);
		$reqselec = 'SELECT prenomInscrit FROM Inscrit WHERE token ="'.$token.'" AND idInscrit ='.$id;   // récupération du prénom
		$rsselec = PdoLxc::$monPdo->query($reqselec);
		$user = $rsselec->fetch();
		$prenom = $user['prenomInscrit'];
		setcookie('prenomUser',$prenom);   // affectation au cookie du prénom du User
		return $rs;
}

// Déconnecte l'utilisateur
function deconnecter($id) {
		$req = 'UPDATE Inscrit SET token = NULL WHERE idInscrit='.$id;  // mise à jour de la base de données -> token à NULL
		$rs = PdoLxc::$monPdo->exec($req);
		setcookie('idUser','',-1);
		setcookie('tokenUser','',-1);			// destruction des cookies
		setcookie('prenomUser','',-1);
		setcookie('categorieUser','',-1);
		return $rs;
}

// Teste si un utilisateur est connecté. True si connecté, False sinon.
function estConnecte(){
	if (isset($_COOKIE['tokenUser']) and isset($_COOKIE['idUser'])){
		$id = $_COOKIE['idUser'];
		$token = $_COOKIE['tokenUser'];
		$req = 'SELECT idInscrit FROM Inscrit WHERE token="'.$token.'" and idInscrit='.$id; // Compare le contenu du cookie (token et idUser) avec la base de données
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetch();
		if(!is_array($ligne)){
			return False;
		}
		else {
			return True;
		}
	}
	else {
		return False;
	}
}

// Vérifie que le couple login/mot de passe est correct. Retourne l'ID du User si correct.
	public function checkUser($login,$mdp){
		$req = 'SELECT idInscrit from Inscrit where mailInscrit="'.$login.'" and pswInscrit= SHA1(CONCAT("LuxCar","'.$mdp.'","LuxCar"))';
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetch();
		return $ligne;
	}

// Vérifie si une adresse mail est déjà utilisée
	public function checkMail($mail){
			$req = 'SELECT mailInscrit FROM Inscrit WHERE mailInscrit="'.$mail.'"';
			$rs = PdoLxc::$monPdo->query($req);
			$ligne = $rs->fetch();
			return $ligne;
	}

// Créer un utilisateur qui s'inscrit. La catégorie sera de type "CL" (= Client)
	public function creerNouvelUtilisateur($nom,$prenom,$mail,$mdp){
		$req = 'INSERT INTO Inscrit (idCategorie, nomInscrit, prenomInscrit, mailInscrit, pswInscrit) VALUES ("CL","'.$nom.'","'.$prenom.'","'.$mail.'", SHA1(CONCAT("LuxCar","'.$mdp.'", "LuxCar")))';
		$prep = PdoLxc::$monPdo->prepare($req);
		$prep->execute(array());
		return PdoLxc::$monPdo->lastInsertId(); // récupère l'ID de l'utilisateur qui vient de s'inscrire
	}

// Récupère les marques existantes dans la bd
	public function getLesMarques(){
		$req = 'SELECT idMarque, nomMarque, logoMarque FROM Marque';
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
		return $ligne;
	}

// Récupère les modèles de la marque passée en paramètre
	public function getLesModeles($id_marque){
		$req = 'SELECT idModele, nomModele, imgModele, prixModele FROM Modele WHERE idMarque ='.$id_marque ;
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
		return $ligne;
	}


// Récupère les options existantes dans la bd
	public function getLesOptions(){
		$req = 'SELECT idOption, nomOption, descriptionOption, prixOption FROM Options ORDER BY nomOption';
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
		return $ligne;
	}

// Récupère les infos de l'utilisateur actuellement connecté (qui correspondent au couple token/id)
	public function getUserConnecte(){
		if (isset($_COOKIE['tokenUser']) and isset($_COOKIE['idUser'])){
			$req = 'SELECT idInscrit, nomInscrit, prenomInscrit, idCategorie from Inscrit where token="'.$_COOKIE['tokenUser'].'" AND idInscrit='.$_COOKIE['idUser'];
			$rs = PdoLxc::$monPdo->query($req);
			$ligne = $rs->fetch();
			return $ligne;
		}
	}

// Récupère le prix d'un modèle de voiture à partir de son ID passé en paramètre
	public function getPrixMod($id){
		$req = 'SELECT prixModele from Modele WHERE idModele ='.$id ;
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetch();
		return $ligne;
	}

// Crée un devis et retourne son ID
	public function creerDevis($mar, $mod){
		$user = $this->getUserConnecte();    
		$iduser = $user['idInscrit'];   // récupère l'ID du User connecté
		$lemodele = $this->getPrixMod($mod);
		$prix = $lemodele['prixModele'];  // récupère le prix du modèle choisi
		$req = 'INSERT INTO Devis (idInscrit, idMarque, idModele, dateDevis, prixDevis) VALUES ('.$iduser.','.$mar.','.$mod.','.date("Ymd").','.$prix.')';  // Création du devis avec la date du jour
		$prep = PdoLxc::$monPdo->prepare($req);
		$prep->execute(array());
		return PdoLxc::$monPdo->lastInsertId(); // pour récupérer l'ID du devis qui vient d'être créé
	}

// Récupère l'ensemble des devis d'un utilisateur dont l'id est passé en paramètre
	public function getLesDevisUser($id){
		$req = 'SELECT idDevis, idInscrit, nomMarque, nomModele,  nomEtat, dateDevis, prixDevis FROM Devis as d, Marque as ma, Modele as mo, Etat as e WHERE d.idMarque = ma.idMarque AND d.idModele = mo.idModele AND e.idEtat = d.idEtat AND d.idInscrit ='.$id.' ORDER BY d.idDevis';
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
		return $ligne;
	}

// Récupère le devis dont l'id est passé en paramètre, avec toutes les informations le concernant. Pour éviter que n'importe qui puisse regarder les devis de tout le monde : l'id du User actuellement connecté est nécessaure
	public function getDetailsDevis($iddev,$iduser){
		$req = 'SELECT d.idDevis, i.idInscrit, i.nomInscrit, i.prenomInscrit, i.mailInscrit, ma.nomMarque, mo.nomModele, d.idEtat, e.nomEtat, d.dateDevis, d.prixDevis, ma.logoMarque, mo.imgModele FROM Devis as d, Inscrit as i, Marque as ma, Modele as mo, Etat as e WHERE d.idInscrit = i.idInscrit AND d.idMarque = ma.idMarque AND d.idModele = mo.idModele AND d.idEtat = e.idEtat AND d.idDevis='.$iddev.' AND d.idInscrit ='.$iduser;
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetch();
		return $ligne;
	}	

// Récupère le devis dont l'id est passé en paramètre. Cette fonction est à utiliser par les admin pour pouvoir récupérer n'importe quel devis aisément, uniquement avec l'id du devis
	public function getLeDevis($iddev){
		$req = 'SELECT d.idDevis, i.idInscrit, i.nomInscrit, i.prenomInscrit, i.mailInscrit, ma.nomMarque, mo.nomModele, d.idEtat, e.nomEtat, d.dateDevis, d.prixDevis, ma.logoMarque, mo.imgModele FROM Devis as d, Inscrit as i, Marque as ma, Modele as mo, Etat as e WHERE d.idInscrit = i.idInscrit AND d.idMarque = ma.idMarque AND d.idModele = mo.idModele AND d.idEtat = e.idEtat AND d.idDevis='.$iddev;
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetch();
		return $ligne;
	}

// Récupère les options pour un devis précis, dont l'id est passé en paramètre
	public function getLesOptionsChoisies($iddev){
			$req = 'SELECT o.idOption, o.nomOption, o.descriptionOption, o.prixOption FROM LigneOption as l, Options as o WHERE l.idOption = o.idOption AND idDevis='.$iddev;
			$rs = PdoLxc::$monPdo->query($req);
			$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
			return $ligne;
	}

// Récupère les options disponibles pour le devis dont l'id est passé en paramètre (celles qu'il ne contient pas)
	public function getLesOptionsDispo($iddev){
		$req = 'SELECT * FROM Options WHERE idOption NOT IN (SELECT o.idOption FROM Options as o, LigneOption as l WHERE o.idOption=l.idOption AND l.idDevis = '.$iddev.')';
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
		return $ligne;
	}

// Ajoute un ensemble d'options à un devis
	public function ajouterOption($iddev, $lesOptions){
		$mesOptions = null ;  // mesOptions deviendra un tableau seulement si au moins une ligne est insérée dans la bd. Cela permet de tester si des options ont été ajouté et si c'est effectivement le cas, de les récupérer
		$ligne = null ;
		foreach ($lesOptions as $uneOption){
			$select = 'SELECT * FROM LigneOption WHERE idDevis='.$iddev.' AND idOption ='.$uneOption;
			$reqSelect = PdoLxc::$monPdo->query($select);
			$ligne = $reqSelect->fetch();
			if (!is_array($ligne)){
				$req = 'INSERT INTO LigneOption VALUES ('.$iddev.','.$uneOption.')';  // insertion de chacune des options (ID) une à une, pour le devis concerné
				$rs = PdoLxc::$monPdo->exec($req);
				$ligne = null ;
				if($rs){
					if(!isset($mesOptions)){
						$mesOptions = [];      // si au moins une option est ajoutée à la bd (succès), mesOptions devient un tableau
					}
					array_push($mesOptions, $uneOption);  // ajout de l'option ajoutée à la bd dans le tableau
				}
			}
		}
		return $mesOptions;  // retourne null (aucune option ajoutée) ou un tableau (contenant les options ajoutées)
	}


// Récupère l'ensemble des devis existants, de tous les utilisateurs (pour l'Admin uniquement)
	public function getLesDevis(){
		$req = 'SELECT d.idDevis, d.idInscrit, nomMarque, nomModele,  nomEtat, dateDevis, prixDevis, nomInscrit, prenomInscrit, mailInscrit  FROM Devis as d, Marque as ma, Modele as mo, Etat as e, Inscrit as i WHERE d.idMarque = ma.idMarque AND d.idModele = mo.idModele AND e.idEtat = d.idEtat  AND i.idInscrit = d.idInscrit ORDER BY idDevis';
		$rs = PdoLxc::$monPdo->query($req);
		$ligne = $rs->fetchAll(PDO::FETCH_ASSOC);
		return $ligne;
	}

// Test si l'utilisateur connecté est admin. Retourne True si admin, False sinon
	public function estAdmin(){
		if (isset($_COOKIE['tokenUser']) and isset($_COOKIE['idUser'])){
				$req = 'SELECT idInscrit, nomInscrit, prenomInscrit, idCategorie from Inscrit where token="'.$_COOKIE['tokenUser'].'" AND idInscrit='.$_COOKIE['idUser'];
				$rs = PdoLxc::$monPdo->query($req);
				$ligne = $rs->fetch();
				$categ = $ligne['idCategorie'];
				if ($categ == "AD"){
					return True;
				} 
				else {
					return False;
				}
		}
		else {
			return False;
		}
	}

// Valide un devis : change l'état à "VA"
	public function validerDevis($iddev){
		$req = 'UPDATE Devis SET idEtat ="VA" WHERE idDevis='.$iddev;
		$rs = PdoLxc::$monPdo->exec($req);
		return $rs;
	}
	
// Crée une option avec les paramètres choisis par l'utilisateur
	public function creerOption($nomOpt, $descOpt, $prixOpt){
		$req = 'INSERT INTO Options (nomOption, descriptionOption, prixOption) VALUES ("'.$nomOpt.'","'.$descOpt.'",'.$prixOpt.')';
		$rs = PdoLxc::$monPdo->exec($req);
		return $rs;
	}

// Supprimer le devis correspond à l'id devis et l'id user qui sont passés en paramètre
	public function deleteDevis($iddev, $iduser){
		$req = 'DELETE FROM Devis WHERE idDevis='.$iddev.' AND idInscrit ='.$iduser;
		$rs = PdoLxc::$monPdo->exec($req);
		return $rs;
	}

	public function rechercher($str){
		$reqMar = 'SELECT * FROM Marque WHERE nomMarque ="'.$str.'"';
		$rsMar = PdoLxc::$monPdo->query($reqMar);
		$ligneMar = $rsMar->fetch();
		if(is_array($ligneMar)){
			return $ligneMar;
		}
		else {
			$reqMod = 'SELECT * FROM Modele WHERE nomModele ="'.$str.'"';
			$rsMod = PdoLxc::$monPdo->query($reqMod);
			$ligneMod = $rsMod->fetch();
			if(is_array($ligneMod)){
				return $ligneMod;
			}
			else {
				$ligne = null;
				return $ligne;
			}
		}
	}
}