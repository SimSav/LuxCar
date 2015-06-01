<?php
if(!isset($_REQUEST['action'])){
	$_REQUEST['action'] = 'consulterDevis';
}
$action = $_REQUEST['action'];
switch ($action) {
/* le User connecté souhaite créer un devis, après avoir sélectionné une marque et un modèle de voiture */
	case 'creerDevis':{
		if ($pdo->estConnecte()){
			if(isset($_REQUEST['mar']) and isset($_REQUEST['mod'])){     // Vérification que le User est connecté et qu'il a choisi marque et modèle
				$crea = $pdo->creerDevis($_REQUEST['mar'], $_REQUEST['mod']);
				if ($crea !=0){												// Vérification que le devis a bien été créé
					ajouterInfo("Félicitation, votre devis a bien été créé !","devis");
				}
				else {
					ajouterErreur("Erreur de création du devis","devis");   // Erreur si problème de création
				}
				$lesOptions = $pdo->getLesOptions();						// Affichage des options
				if(!is_array($lesOptions)){
					ajouterErreur("Erreur de chargement des options","devis");  // Erreur si pas d'options à afficher
				}
			}
			else {
				ajouterErreur("Il vous faut choisir une marque et un modèle de voiture pour créer un devis !","devis"); // Erreur si pas de marque et modèle sélectionnés
			}
		}
		else {
			ajouterErreur("Il vous faut être membre pour créer un devis : inscrivez-vous ou bien connectez-vous !","devis");  // Erreur si User pas connecté
		}
		include("vues/v_option.php");
		break;
	}
/* le User connecté souhaite consulter les devis qu'il a créés */
	case 'consulterDevis':{
		if($pdo->estConnecte()){    
			$user = $pdo->getUserConnecte();   // Récupération de l'ID du User connecté
			if(is_array($user)){
				$id = $user['idInscrit'];
				$lesDevis = $pdo->getLesDevisUser($id);   // Récupération des devis du User connecté
				if(!is_array($lesDevis)){
					ajouterInfo("Il n'y a aucun devis!","devis");
					$nbDevis = 0;	
					include("vues/v_devis.php");					
				}
				else {
					$nbDevis = count($lesDevis);   // Comptage du nombre de devis
					include("vues/v_devis.php");
				}
			}
			else{
				ajouterErreur("Erreur de récupération des données utilisateur","devis");   // Erreur de connexion utilisateur
				header('Refresh : 1; URL=index.php?uc=accueil');
				exit();
			}
		}
		else {
			ajouterErreur("Il vous faut être connecté pour consulter vos devis !","devis");  
			header('Refresh : 1; URL=index.php?uc=accueil');   // Redirection vers accueil si User pas connecté
			exit();
		}
	break;	
	}

/* le User connecté souhaite consulter un de ses devis en particulier (les détails) */
	case 'detailsDevis':{
		if($pdo->estConnecte()){
			if (isset($_REQUEST['id'])){
				$user = $pdo->getUserConnecte();   // Récupération du User connecté
				if(is_array($user)){
					$iddev = $_REQUEST['id'];
					$lesOptions = $pdo->getLesOptionsChoisies($iddev);   // Récupération des options choisies pour l'ID du devis sélectionné par le User
					if($pdo->estAdmin()){
						$leDevis = $pdo->getLeDevis($iddev);   // Si le User est Admin -> récupération des infos du devis grâce à  l'ID du devis sélectionné
					} else {
						$iduser = $user['idInscrit'];
						$leDevis = $pdo->getDetailsDevis($iddev,$iduser);	// Si le User n'est pas Admin, par sécurité on récupère le devis qui correspond à l'ID du devis ET l'ID du User connecyé afin qu'il ne puisse pas voir les devis de n'importe qui				
					}
					if(!is_array($leDevis)){
						ajouterErreur("Erreur de chargement du devis, veuillez vérifier sa référence","devis");  // Erreur s'il n'y a pas de devis
						header('Refresh : 1; URL=index.php?uc=accueil');
						exit();
					}
					else {
						include("vues/v_detailsDevis.php");
					}
				}
				else{
					ajouterErreur("Erreur de récupération des données utilisateur","devis"); // Erreur avec la connexion de l'utilisation
					header('Refresh : 1; URL=index.php?uc=accueil');
				}
			}	
			else {
				ajouterErreur("Il vous faut choisir un devis à consulter !","devis"); // Erreur si aucun devis sélectionné
				header('Refresh : 2; URL=index.php?uc=accueil');
				exit();
			}	
		}
		else {
			ajouterErreur("Il vous faut être connecté pour consulter vos devis !","devis"); // Erreur si User pas connecté
			header('Refresh : 2; URL=index.php?uc=accueil');
			exit();
		}
	if(isset($lesOptions)){
		if(count($lesOptions)>0){
			include("vues/v_option.php");   // Affichage du tableau d'options uniquement s'il y en a (nbOption >0)
		}
	}
	break;
	}
/* le User connecté souhaite ajouter une option pour le devis sélectionné */
	case 'ajouterOption':{
		if (isset($_POST['cbxoption'])){
			$options = $_POST['cbxoption'];    // Vérification qu'il a coché des checkbox (= choisi une/des option(s)). Chaque checkbox a l'id de l'option qu'elle concerne en tant que 'name'
			if (isset($_REQUEST['dev'])){
				$iddev = $_REQUEST['dev'];
				$lesIdOptions = $pdo->ajouterOption($iddev,$options);   // 'Essaye' d'ajouter les options au devis. Récupère le tableau des options qui ont été ajoutées. (Des options ne sont pas ajoutées si le devis les contient déjà)
				if(is_array($lesIdOptions)){
					ajouterInfo("Félicitation, vos options ont bien été ajoutées à votre devis ".$iddev." ","devis");
					$lesOptions = $pdo->getLesOptionsChoisies($iddev);    // Cas où au moins une option a été ajoutée : affichage récapitulatif du tableau d'options ajoutées
					include("vues/v_option.php");
				}
				else {
					include("vues/v_accueil.html");
				}
			}
			else {
				ajouterErreur("Il vous faut choisir un devis auquel ajouter une option !","devis");   // Erreur si pas de devis sélectionné
				include("vues/v_option.php");
			}	
		}
		else if(isset($_REQUEST['dt'])){   // dt existe si le User était précédemment dans le détail d'un devis et qu'il a cliqué sur "ajouter option"
			$crea = $_REQUEST['id'];       // Récupération de l'id du devis concerné
			$lesOptions = $pdo->getLesOptionsDispo($crea);  // Récupération des options disponibles pour le devis sélectionné (= options qui ne sont pas déjà incluses dans le devis)
			if (is_array($lesOptions)){
				include("vues/v_option.php");
			}
			else {
				ajouterErreur("Vous ne pouvez plus rajouter d'options, vous avez déjà sélectionné toutes les options disponibles","devis");
			}
		}
		else{
			header('Refresh : 0; URL=index.php?uc=accueil');  
			exit();
		}
		break;
	}
/* le User souhaite supprimer le devis qu'il consulte depuis le détail du devis (v_detailsDevis) */
	case 'supprimerDevis':{
		if($pdo->estConnecte()){
			if (isset($_REQUEST['id'])){
				$user = $pdo->getUserConnecte();   // Récupération du User connecté
				$iduser = $user['idInscrit'];
				if(is_array($user)){
					$iddev = $_REQUEST['id'];   // Récupération de l'id du devis à delete
					$ok = $pdo->deleteDevis($iddev, $iduser);  // Suppression du devis
					if ($ok){
						ajouterInfo("Le devis ".$iddev." a été supprimé.", "devis");
						header('Refresh : 2; URL=index.php?uc=devis&action=consulterDevis');  // Redirection vers la liste des devis si suppression effectuée
						exit();
					}
					else {
						ajouterErreur("Erreur : le devis".$iddev. " n'a pas pu être supprimé","devis");
						header('Refresh : 2; URL=index.php?uc=devis&action=detailsDevis&id='.$iddev);  // Redirection vers le devis si suppression échouée
						exit();
					}
				}
				else {
					ajouterErreur("Erreur de récupération des données utilisateur","devis"); // Erreur avec la connexion de l'utilisation
					header('Refresh : 1; URL=index.php?uc=accueil');
					exit();
				}
			}
			else {
				ajouterErreur("Il vous faut choisir un devis à supprimer !","devis"); // Erreur si aucun devis sélectionné
				header('Refresh : 2; URL=index.php?uc=accueil');
				exit();
			}	
		}
		else {
			ajouterErreur("Il vous faut être connecté pour supprimer un devis !","devis"); // Erreur si User pas connecté
			header('Refresh : 2; URL=index.php?uc=accueil');
			exit();
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