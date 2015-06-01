<!-- Vue qui recense l'ensemble des options dans un tableau 
Affiche :
- Nom de l'option
- Description de l'option
- Prix de l'option
+ un bouton "Ajouter" dans le cas où un devis est sélectionné (juste après l'avoir créé) -->
<div class="row">
  <?php
  if (isset($_REQUEST['info']))
  { ?> <div class="information"> <?php 
    foreach($_REQUEST['info'] as $linfo)
    {
      echo '<h4 class="text-success">'.$linfo.'</h4>';
    }
  } ?> </div> <?php

  if (isset($_REQUEST['erreurs']))
  { ?> <div class="information"> <?php 
    foreach($_REQUEST['erreurs'] as $erreur)
    {
      echo '<h4 class="text-danger">'.$erreur.'</h4>';
    }
  ?> </div> <?php } 
  else{
    if(isset($crea)){    // On regarde si on est dans le cas où un devis est sélectionné
  ?></div>
      <form method="post" action ="index.php?uc=devis&amp;action=ajouterOption&amp;dev=<?php echo $crea ?>"> <?php } ?> <!-- si un devis est sélectionné : déclaration d'un formulaire pour permettre d'envoyer les options sélectionnées -->
        <table class="table table-bordered table-striped table-condensed">
          <caption>
           <h4>Options (<?php echo count($lesOptions);?>)</h4>
          </caption>
<!-- Contenu du tableau de présentation des options -->
          <tbody>
          <?php
          foreach($lesOptions as $uneOption)
          {
            $idOption = $uneOption['idOption'];
            $nomOption = $uneOption['nomOption'];
            $descrOption = $uneOption['descriptionOption'];
            $prixOption = $uneOption['prixOption'];
           ?>
            <tr>
              <td><?php echo $nomOption ?></td>
              <td><?php echo $descrOption ?></td>
              <td><?php echo $prixOption ?>€</td>
              <?php if (isset ($crea)){ ?>     <!-- cas d'ajout d'options : checkbox pour chaque option -->
                <td> <input type="checkbox" name="cbxoption[]" value="<?php echo $idOption ?>"></td>
              <?php
              } 
          }
              ?>
            </tr>
           </tbody>
        </table>
        <?php if (isset ($crea)){ ?>   <!-- Si $crea existe, elle contient la valeur d'un devis sélectionné ; on peut donc lui ajouter des options -->
          <input type="submit" name="ValiderLesOptions" value="Valider les Options" class="btn btn-primary"> <!-- Validation du formulaire -->
      </form>  <!-- Si le User se situait dans le cas d'ajout d'option depuis la vue "detailsDevis" (= modification d'un devis sélectionné) et qu'il veut annuler la modification -> retour à la vue -->
      </br><input type="button" name="Annuler" value="Annuler" <?php if (isset($_REQUEST['dt'])){?> onclick="self.location.href='index.php?uc=devis&amp;action=detailsDevis&amp;id=<?php echo $crea ?>'"<?php } else{?> onclick="self.location.href='index.php'"<?php }?> class="btn btn-primary"> 
        <?php 
        }
      if($_REQUEST['action'] == "ajouterOption" and isset($_REQUEST['dev'])){ ?>
            </br><input type="button" name="Mon Devis" value="Mon Devis" onclick="self.location.href='index.php?uc=devis&amp;action=detailsDevis&amp;id=<?php echo $_REQUEST['dev'] ?>'" class="btn btn-primary"> 
      <?php 
      } 
  }?>
</div>
