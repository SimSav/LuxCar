<!-- Vue que l'on obtient lorsque le User souhaite avoir le détail d'un devis particulier qu'il a sélectionné.
Affiche :
- Identité du détenteur du devis : nom, prénom, mail
- Informations générales du devis : Référence, date de création, état, prix total
- Contenu du devis : la marque et le modèle de la voiture ainsi que les options choisies -->

<div class="row">
<?php
if (isset($_REQUEST['erreurs']))
{
  foreach($_REQUEST['erreurs'] as $erreur)
  {
    echo '<h4 class="text-danger">'.$erreur.'</h4>';
  }
}
else{
?>
  <table class="table table-bordered table-striped table-condensed">
    <caption>
    <?php if (!$pdo->estAdmin()) { ?>
      <h4>Votre devis</h4>
    <?php } else { ?>
    <h4>Devis client</h4>
    <?php } ?> <h5><?php echo $leDevis['nomInscrit']." ".$leDevis['prenomInscrit']." : ".$leDevis['mailInscrit']?></h5>
    </caption>

<!-- Contenu du tableau de présentation du devis -->
    <tbody>
    <th> Référence</th>
    <th> Date</th>
    <th> Marque</th>
    <th> Modèle</th>
    <th> Prix TTC</th>
    <th> Etat Devis</th>
        <?php
        $idDevis = $leDevis['idDevis'];
        $idInscr = $leDevis['idInscrit'];
        $nomInscr = $leDevis['nomInscrit'];
        $prenomInscr = $leDevis['prenomInscrit'];
        $logoMar = $leDevis['logoMarque'];
        $imgMod = $leDevis['imgModele'];
        $mailInscr = $leDevis['mailInscrit'];
        $nomMarque = $leDevis['nomMarque'];
        $nomModele = $leDevis['nomModele'];
        $prixDevis = $leDevis['prixDevis'];
        $etatDevis = $leDevis['nomEtat'];
        $dateEn = $leDevis['dateDevis'];
        $dateFr = dateAnglaisVersFrancais($dateEn);
        ?>
        <tr>
          <td><?php echo $idDevis ?></td>
          <td><?php echo $dateFr ?></td>
          <td><?php echo $nomMarque ?></td>
          <td><?php echo $nomModele ?></td>
          <td><?php echo $prixDevis ?>€</td>
          <td><?php echo $etatDevis ?></td>
        </tr>
    </tbody>
  </table> 

<!-- Images marque et modèle -->
  <section class="row">
    <div class="col-lg-offset-2 col-xs-6 col-sm-3 col-md-2"><img src="<?php echo $logoMar ?>" alt="Image marque <?php echo $nomMarque;?>"></div>
    <div class="col-lg-offset-2 col-xs-6 col-sm-3 col-md-2"><img src="<?php echo $imgMod ?>" alt="Image modele <?php echo $nomModele;?>" ></div>
  </section>

<!-- Si le devis n'est pas validé et qu'il appartient bien au User qui le consulte, on peut cliquer sur "ajouter des options" -->
  <?php $user = $pdo->getUserConnecte();
  $idUser = $user['idInscrit'];
  if ($idInscr == $idUser and $leDevis['idEtat'] != "VA") { ?>
    </br><input type="button" name="Ajouter Options" value="Ajouter Options" onclick="self.location.href='index.php?uc=devis&amp;action=ajouterOption&amp;id=<?php echo $idDevis ?>&amp;dt=tr'" class="btn btn-primary"> 
    </br><input type="button" name="Supprimer Devis" value="Supprimer Devis" onclick="self.location.href='index.php?uc=devis&amp;action=supprimerDevis&amp;id=<?php echo $idDevis ?>&amp;dt=tr'" class="btn btn-primary"> 

  <?php } 

  // Si le devis est en état "AT" (en Attente) et que le User qui le consulte est Admin ; il peut cliquer sur "Valider" pour le passer en état validé.
   if ($pdo->estAdmin() and $leDevis['idEtat'] == "AT") { ?>
    </br><input type="button" name="Valider" value="Valider le Devis" onclick="self.location.href='index.php?uc=administration&amp;action=validerDevis&amp;id=<?php echo $idDevis ?>&amp;dt=tr'" class="btn btn-primary"> 
  <?php }} ?>
  </br><input type="button" name="Retour" value="Retour" <?php if (!$pdo->estAdmin()) { ?> onclick="self.location.href='index.php?uc=devis&amp;action=consulterDevis'" <?php } else { ?> onclick="self.location.href='index.php?uc=administration&amp;action=consulterDevis'" <?php } ?> class="btn btn-primary"> 

</div>