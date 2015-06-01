<?php
if(!isset($_REQUEST['action'])){
	$_REQUEST['action'] = 'choisirMarque';
}
$action = $_REQUEST['action'];
switch ($action) {
	case 'choisirMarque':{
		$lesMarques = $pdo->getLesMarques();  // Récupération de l'ensemble des marques dans la BD
		if(!is_array($lesMarques)){
			ajouterErreur("Erreur de chargement des marques","catalogue");  // Erreur si aucune marque à afficher
		}
		include("vues/v_marque.php");
		break;
	}

	case 'choisirModele':{
		if(isset($_REQUEST['mar'])){     // Vérification qu'une marque a bien été sélectionnée
			$mar=$_REQUEST['mar'];
			$lesModeles = $pdo->getLesModeles($mar);  // Récupération des modèles pour la marque choisie
			if(!is_array($lesModeles)){
				ajouterErreur("Erreur de chargement des modèles","catalogue");  // MErreur si aucun modèle à afficher
			}
		}
		else{
			ajouterErreur("Erreur : vous devez au préalable sélectionner une marque","catalogue");  // Erreur si aucune marque sélectionnée préalablement
		}
		include("vues/v_modele.php");
		break;
	}

	case 'voirOptions':{
		$lesOptions = $pdo->getLesOptions();  // Récupération de l'ensemble des options dans la BD
		if(!is_array($lesOptions)){
			ajouterErreur("Erreur de chargement des options","catalogue"); // Erreur si aucune option à afficher
		}
		include("vues/v_option.php");
		break;
	}
/* L'utilisateur tappe un mot à rechercher dans la barre de recherche */
	case 'recherche':{
		if(isset($_POST['recherche'])){
			$resRecherche = $pdo->rechercher($_POST['recherche']);     // Recherche du terme soumis par User
			include ("vues/v_recherche.php");            
		}
		else {
			header('Refresh : 1; URL=index.php?uc=accueil'); // Redirection vers la page d'accueil si clique sur le bouton "Chercher" mais champ vide
			exit(); 
		}
		break;
	}
/* Pour les URL non reconnues ici */
	default:{
		echo '<h4 class="text-danger"> Erreur : la page demandée n\'existe pas. </h4>';
		header('Refresh : 1; URL=index.php?uc=accueil'); // Redirection vers la page d'accueil 
		exit(); 
		break; 
	}
}
?>