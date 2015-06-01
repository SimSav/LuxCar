<!-- Vue de l'ensemble des marques disponibles dans la BD 
Affiche :
- logo de la marque : en cliquant sur l'image, direction vers la page de sélection d'un modèle
- nom de la marque -->

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
      <h3>Nos marques disponibles</h3>
    </caption>
<!-- Contenu du tableau de présentation des marques -->
    <tbody>
      <?php
        foreach($lesMarques as $uneMarque)
        {
          $idMarque = $uneMarque['idMarque'];
          $nomMarque = $uneMarque['nomMarque'];
          $logoMarque = $uneMarque['logoMarque'];
      ?>
          <tr>   <!-- direction vers la page des modèles en fonction de la marque choisie -->
            <td><a href="index.php?uc=catalogue&amp;action=choisirModele&amp;mar=<?php echo $idMarque ?>"><img src="<?php echo $logoMarque ?>" alt="Logo <?php echo $nomMarque ?>"></a></td>
            <td><?php echo $nomMarque ?></td>
            <?php
        }
            ?>
          </tr>
    </tbody>
  </table>
  <?php } ?>
</div>
