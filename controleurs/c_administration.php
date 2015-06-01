<?php

/* Seule une personne connectée en tant qu'Admin peut accéder à cette section*/
if(!isset($_REQUEST['action'])){
	$_REQUEST['action'] = 'consulterDevis';
}
if ($pdo->estConnecte()){   
	$user = $pdo->getUserConnecte();
	if ($user['idCategorie']=="AD"){   // Récupération du User connecté -> vérification qu'il s'agit bien d'un Admin (idCateg = AD)
		$action = $_REQUEST['action'];
		switch ($action) {
/* le User Admin souhaite consulter l'ensemble des devis existants */
			case 'consulterDevis':{    
				$lesDevis = $pdo->getLesDevis(); // Fonction qui renvoie tous les devis existants dans la base
				if(!is_array($lesDevis)){
					ajouterInfo("Il n'y a aucun devis!","devis");  // s'il n'y a aucun devis un message info l'indiquera
					$nbDevis = 0;
				} 
				else {
					$nbDevis = count($lesDevis); // récupération du nombre de devis
				}
				include("vues/v_devis.php");
				break;
			}
/* le User Admin consulte le devis d'un client et souhaite le valider */
			case 'validerDevis':{
				if(isset($_REQUEST['id'])){
					$req = $pdo->validerDevis($_REQUEST['id']);   // Modification de l'état du devis à : Validé
					if ($req){
						ajouterInfo("Le devis a bien été validé !","admin");
						$urlPrec = $_SERVER["HTTP_REFERER"] ;  // permet de mémoriser l'url de la page précédente pour rediriger le User dessus
						if (isset($urlPrec)){
							header('Refresh : 2; URL='.$urlPrec);  // Redirection vers le devis venant d'être validé
							exit();
						}
						else {
							header('Refresh : 2; Url=index.php?uc=administration&action=consulterDevis');
							exit();
						}
					}
					else {
						ajouterErreur("Erreur : vérifiez que ce devis peut bien être validé","admin"); // Erreur si echec de validation
					}
				}
				else {
					ajouterErreur("Erreur : il faut sélectionner un devis à valider","admin");   // Erreur si aucun devis sélectionné
				}
				$lesDevis = $pdo->getLesDevis();   // Affichage de l'ensemble des devis
				if(!is_array($lesDevis)){
					ajouterInfo("Il n'y a aucun devis!","devis");
					$nbDevis = 0;
				} 
				else {
					$nbDevis = count($lesDevis); // Récupération du nombre de devis
				}
				break;
/* le User Admin souhaite créer une option -> dirige vers un formulaire qui permettre d'insérer une option dans la base */
			}
			case 'creerOption':{
				include("vues/v_fromOption.php");
				break;
			}
/* le User Admin valide la création de son option depuis le formulaire adéquat */
			case 'valideCreationOption':{
				if(isset($_POST['nomOption']) and isset($_POST['descOption']) and isset($_POST['prixOption'])){
					$rs = $pdo->creerOption($_POST['nomOption'], $_POST['descOption'], $_POST['prixOption']);   // Insertion dans la base
					if($rs){
						ajouterInfo("Félicitation, l'option ".$_POST['nomOption']." a bien été créée !","admin");
						include("vues/v_fromOption.php");  
					}
					else{
						ajouterErreur("Erreur : un problème est survenu lors de la création de votre option. Vérifiez que les champs sont valides","admin"); // Erreur : option non créée dans la BD
						include("vues/v_fromOption.php");  
					}
				}
				else {
					ajouterErreur("Erreur : Tous les attributs pour votre option ne sont pas spécifiés","admin"); // Erreur : manque d'attributs pour l'option à créer
					include("vues/v_fromOption.php");   
				}
				break;
			}
		}
	}
/* Redirection si tentative d'accès par un User non Admin */
	else {
		ajouterErreur("Erreur : il faut être connecté en tant qu'administrateur !","admin");
		include ("vues/v_accueil.html");
		exit();
	}
}
else {
	ajouterErreur("Erreur : il faut être connecté en tant qu'administrateur !","admin");
	include ("vues/v_accueil.html");
	exit();
}


?>