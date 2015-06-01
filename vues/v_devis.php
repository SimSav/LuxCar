<!-- Vue que l'on obtient lorsque le User souhaite voir la liste des devis. (Soit les siens -> onglet "Mes Devis", soit l'ensemble des devis de la base -> onglet "Les Devis Client" en tant qu'admin)
Affiche :
- Référence du devis, date, état (+ id du User à qui il appartient dans le cas où on est dans l'administration)
- Marque choisie, modèle choisi, prix TTC et un bouton "Aperçu" offrant la possibilité de consulter le détail du devis (vues v_detailsDevis) -->

<div class="row">
<?php
if (isset($_REQUEST['info']))
{
  foreach($_REQUEST['info'] as $linfo)
  {
    echo '<h4 class="text-success">'.$linfo.'</h4>';
  }
}

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
<!-- Affichage "Mes Devis" ou "Liste des devis clients" selon le contexte + le nombre de devis -->
    <caption>
      <?php if ($_REQUEST['uc'] == "devis") { ?>
      <h4>Vos devis</h4>
      <?php } else { ?>
      <h4>Liste des devis clients</h4>
      <?php } if ($nbDevis > 0){ ?>
      <h5><?php if (!$pdo->estAdmin()) {
        echo "Vous avez ";
        } echo $nbDevis?> devis.</h5>
    </caption>

  <!-- Contenu du tableau de présentation des devis -->
    <tbody>
    <th> Référence</th>
    <?php if ($pdo->estAdmin() and ($_REQUEST['uc']=="administration")) {?><th>Id Inscrit</th><?php } ?>
    <th> Date</th>
    <th> Marque</th>
    <th> Modèle</th>
    <th> Prix TTC</th>
    <th> Etat Devis</th>
        <?php
        foreach($lesDevis as $unDevis)
        {
          $idDevis = $unDevis['idDevis'];
          if ($pdo->estAdmin() and ($_REQUEST['uc']=="administration")) {
            $idInscrit = $unDevis['idInscrit'];
          }
          $nomMarque = $unDevis['nomMarque'];
          $nomModele = $unDevis['nomModele'];
          $prixDevis = $unDevis['prixDevis'];
          $etatDevis = $unDevis['nomEtat'];
          $dateEn = $unDevis['dateDevis'];
          $dateFr = dateAnglaisVersFrancais($dateEn);
        ?>
        <tr>
          <td><?php echo $idDevis ?></td>
          <?php if ($pdo->estAdmin() and ($_REQUEST['uc']=="administration")) {?><td><?php echo $idInscrit ?></td><?php } ?>
          <td><?php echo $dateFr ?></td>
          <td><?php echo $nomMarque ?></td>
          <td><?php echo $nomModele ?></td>
          <td><?php echo $prixDevis ?>€</td>
          <td><?php echo $etatDevis ?></td>
          <td> <input type="button" name="Aperçu" id="Aperçu" value="Aperçu" onclick="self.location.href='index.php?uc=devis&amp;action=detailsDevis&amp;id=<?php echo $idDevis ?>'" class="btn btn-primary"> 
          <?php
         }
          ?>
        </tr>
    </tbody>
  </table>
<?php } else { ?>
<h5>Vous n'avez actuellement aucun devis</h5>
<?php }} ?>
</div>
