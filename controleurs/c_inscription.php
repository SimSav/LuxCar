<?php
if(!isset($_REQUEST['action'])){
	$_REQUEST['action'] = 'demandeInscription';
}
$action = $_REQUEST['action'];
switch ($action) {
/* le User souhaite s'inscrire -> envoi du formulaire d'inscription */
	case 'demandeInscription':{
		include ("vues/v_inscription.php");
		break;
	}
/* le User valide son inscription */
	case 'valideInscription':{        
		if(isset($_POST['nom']) and isset($_POST['prenom']) and isset($_POST['mail']) and isset($_POST['mdp'])){  // Vérification que les champs du formulaire sont remplis
			$nom = $_POST['nom'];
			$prenom = $_POST['prenom'];
			$mail = $_POST['mail'];
			$mdp = $_POST['mdp'];
			$utilisateur = $pdo->checkMail($mail);   // Vérification que l'email saisie n'existe pas déjà dans la BD
			if(is_array($utilisateur)){
				ajouterErreur("Cette adresse mail est déjà utilisée","inscription"); // Erreur si email déjà utilisé
				include ("vues/v_inscription.php");
			}
			else{
				$id=$pdo->creerNouvelUtilisateur($nom,$prenom,$mail,$mdp);   // Création du nouveau user dans la base
				if ($id > 0){
					ajouterInfo("Inscription réussie","inscription");
					$pdo->connecter($id);   // Connexion de l'utilisateur -> envoie des cookies, attribution d'un token dans la BD
					header('Refresh : 0; URL='.$_POST['urlPrec']);  // Redirection vers la page précédent l'inscription
					exit();
				}
				else{
					ajouterErreur("Echec de l'inscription","inscription");  // Problème au niveau de la création du user
					include ("vues/v_inscription.php");
				}
			}
		}
		else {
			ajouterErreur("Erreur : Toutes les informations nécessaires à votre inscription ne sont pas spécifiées !","inscription");  // Erreur : aucun identifiant récupéré
			include ("vues/v_inscription.php");
		}
		break;
	}
/* Pour les URL non reconnues ici */
		default:{
		echo '<h4 class="text-danger"> Erreur : la page demandée n\'existe pas. </h4>';
		header('Refresh : 2; URL=index.php?uc=accueil');  // Redirection vers la page d'accueil
		exit();
		break;
	}
}
?>