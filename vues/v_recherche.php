<!-- Vue de d'affichage de la requête de recherche
Affiche :
- Un message d'erreur si aucune donnée trouvée
- La marque ou le modèle trouvé -->

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
      <h4>Résultat de votre recherche : </h4>
<!-- Cas où le mot recherché ne correspond ni à une marque ni à un modèle -->
      <?php if(!isset($resRecherche['idModele']) and !isset($resRecherche['nomMarque'])){?>
        <h5>Aucune donnée correspondant à votre recherche n'a été trouvée.</h3> <?php } ?>
    </caption> 
    <?php if(isset($resRecherche['idModele'])){ echo "youou";?>

<!-- Contenu du tableau de présentation du résultat de la recherche s'il s'agit d'un modèle -->
    <tbody>
      <?php
        $idModele = $resRecherche['idModele'];
        $nomModele = $resRecherche['nomModele'];
        $imgModele = $resRecherche['imgModele'];
        $prixModele = $resRecherche['prixModele'];
        $marqueModele = $resRecherche['idMarque'];
      ?>
        <tr>   
          <td><img src="<?php echo $imgModele ?>" alt="Image modele <?php echo $nomModele ?>"></td>
          <td><?php echo $nomModele ?></td>
          <td><?php echo $prixModele ?> €</td>
          <td> <input type="button" name="Devis" value="Devis" onclick="self.location.href='index.php?uc=devis&amp;action=creerDevis&amp;mar=<?php echo $marqueModele ?>&amp;mod=<?php echo $idModele ?>'" class="btn btn-primary" <?php if(!$pdo->estConnecte()){?> disabled <?php } ?>> 
        </tr>
    </tbody>
    <?php } else if(isset($resRecherche['nomMarque'])){ ?>

<!-- Contenu du tableau de présentation du résultat de la recherche s'il s'agit d'une marque -->
    <tbody>
      <?php
        $idMarque = $resRecherche['idMarque'];
        $nomMarque = $resRecherche['nomMarque'];
        $logoMarque = $resRecherche['logoMarque'];
      ?>
        <tr>   
          <td><a href="index.php?uc=catalogue&amp;action=choisirModele&amp;mar=<?php echo $idMarque ?>"><img src="<?php echo $logoMarque ?>" alt="Logo <?php echo $nomMarque ?>"></a></td>
          <td><?php echo $nomMarque ?></td>
        </tr>
    </tbody>
    <?php } ?>
  </table>
  <?php }?>
</div>
