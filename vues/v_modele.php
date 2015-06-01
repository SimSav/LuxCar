<!-- Vue de l'ensemble des modèles disponibles dans la BD par rapport à la marque sélectionnée précédemment
Affiche :
- image du modèle
- nom du modèle
- prix du modèle
- Un bouton "Devis" permet de créer un devis pour le modèle désiré. Conditions : être inscrit et connecté -> le bouton est disabled si conditions non respectées.
-->

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
      <h3>Nos modèles disponibles</h3>
      <?php if(!$pdo->estConnecte()){
        echo "Vous devez vous inscrire ou vous connecter pour créer un devis.";
      } ?>
    </caption>
<!-- Contenu du tableau de présentation des modèles -->
    <tbody>
      <?php
      foreach($lesModeles as $unModele)
      {
        $idModele = $unModele['idModele'];
        $nomModele = $unModele['nomModele'];
        $imgModele = $unModele['imgModele'];
        $prixModele = $unModele['prixModele'];
      ?>
        <tr>
          <td><img src="<?php echo $imgModele ?>" alt="Image modele <?php echo $nomModele ?>"></td>
          <td><?php echo $nomModele ?></td>
          <td><?php echo $prixModele ?> €</td>
          <td> <input type="button" name="Devis" value="Devis" onclick="self.location.href='index.php?uc=devis&amp;action=creerDevis&amp;mar=<?php echo $_REQUEST['mar'] ?>&amp;mod=<?php echo $idModele ?>'" class="btn btn-primary" <?php if(!$pdo->estConnecte()){?> disabled <?php } ?>> 
          <?php
      }
          ?>
        </tr>
    </tbody>
  </table>
  <?php } ?>
</div>
