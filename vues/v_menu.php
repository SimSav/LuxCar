    <!-- Fixed navbar -->
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.php?uc=accueil">LuxCar</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Catalogue<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="index.php?uc=catalogue&amp;action=choisirMarque">Les Marque</a></li>
              <li><a href="index.php?uc=catalogue&amp;action=voirOptions">Les Options</a></li>
            </ul>
            </li>
            <?php if($pdo->estConnecte()){ ?>
            <li><a href="index.php?uc=devis&amp;action=consulterDevis">Mes Devis</a></li> <?php } if($pdo->estConnecte()==False){ ?>
            <li><a href="index.php?uc=inscription&amp;action=demandeInscription">Inscription</a></li>
            <?php } $user = $pdo->getUserConnecte();
      if(is_array($user)){
        if ($pdo->estAdmin()){ ?>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Administration<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="index.php?uc=administration&amp;action=consulterDevis">Les Devis Clients</a></li>
                <li><a href="index.php?uc=administration&amp;action=creerOption">Créer Option</a></li>
              </ul>
            </li>
            <?php }} ?>
          </ul>
          <form class="navbar-form navbar-right" method="POST" action="index.php?uc=connexion&amp;action=valideConnexion">
          <?php if(!$pdo->estConnecte()){ ;?>
            <div class="form-group">
              <input type="text" id="login" name="login" placeholder="Email" class="form-control">
            </div>
            <div class="form-group">
              <input type="password" id="mdp" name="mdp" placeholder="Password" class="form-control">
            </div>
            <button type="submit" name="subConnexion" class="btn btn-primary">Connexion</button> <?php } else { ?>
            <input type="button" name="Deconnexion" value="Deconnexion" onclick="self.location.href='index.php?uc=connexion&amp;action=deconnexion'" class="btn btn-primary">
            <?php } ?>
          </form>  
          <form class="navbar-form navbar-right ajustement" method="POST" action="index.php?uc=catalogue&amp;action=recherche">
            <div class="form-group">
              <input type="search" id="recherche" name="recherche" class="input-sm form-control" placeholder="Recherche">
              <button type="submit" name="subRecherche" class="btn btn-primary"><span class="glyphicon glyphicon-eye-open"></span> Chercher</button>
            </div>
          </form>    
        </div><!--/.nav-collapse -->
      </div>
    </nav>