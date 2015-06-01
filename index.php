<?php
setcookie('idUser', '', time() + 365*24*3600, '/', null, false, true); // Cookie qui contiendra l'ID de l'utilisateur
setcookie('prenomUser', '', time() + 365*24*3600, '/', null, false, true); // Cookie qui contiendra le prénom de l'utilisateur
setcookie('tokenUser', '', time() + 365*24*3600, '/', null, false, true); // Cookie qui contiendra le token généré
require_once ("include/fonctions.php");
require_once ("include/class.pdoluxcar.php");
$pdo = PdoLxc::getPdoLxc();
include ("vues/v_entete.php");
include("vues/v_menu.php");
if(!isset($_REQUEST['uc'])) {
	$_REQUEST['uc'] = 'accueil';
}
$uc = $_REQUEST['uc'];
switch ($uc) {
	case 'accueil':{
		include("vues/v_accueil.html");
		break;
	}
	case 'connexion':{
		include("controleurs/c_connexion.php");
		break;
	}
	case 'catalogue':{
		include("controleurs/c_catalogue.php");
		break;
	}
	case 'inscription':{
		include("controleurs/c_inscription.php");
		break;
	}
	case 'devis':{
		include("controleurs/c_devis.php");
		break;
	}
	case 'administration':{
		include("controleurs/c_administration.php");
		break;
	}
	default:{
		include("vues/v_accueil.html");
		break;
	}
}
include("vues/v_pied.html");
?>

