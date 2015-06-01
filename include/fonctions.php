<?php
/**
 * Fonctions pour l'application des devis de voitures
 */


// Affichage des erreurs
error_reporting(E_ALL | E_STRICT);
ini_set('display_errors',1);
ini_set('html_errors', 1);

// Récupère les erreurs survenue pour pouvoir les afficher par la suite
function ajouterErreur($msg,$form){
	if(!isset($_REQUEST['erreurs'])){
		$_REQUEST['erreurs'] = array();
		$_REQUEST['erreurForm'] = $form;
	}
	$_REQUEST['erreurs'][] = $msg ;
}

// Récupère une information qui sera affichée pour informer l'utilisateur
function ajouterInfo($msg,$form){
	if(!isset($_REQUEST['info'])){
		$_REQUEST['info'] = array();
		$_REQUEST['infoForm'] = $form;
	}
	$_REQUEST['info'][] = $msg ;
}

// Convertis une date format Anglais vers Français
function dateAnglaisVersFrancais($maDate){
   @list($annee,$mois,$jour)=explode('-',$maDate);
   $date=$jour."/".$mois."/".$annee;
   return $date;
}

?>