<!-- Vue formulaire d'inscription User.
Champs à remplir : nom, prénom, adresse mail, mot de passe
-->

<div class="row">
	<div class="col-md-12 col-md-offset-2">
		<?php
		if (isset($_REQUEST['erreurs']))
		{
			foreach($_REQUEST['erreurs'] as $erreur)
			{
				echo '<h4 class="text-danger">'.$erreur.'</h4>';
			}
		}
		?>
		<form class="form-vertical" method="POST" action="index.php?uc=inscription&amp;action=valideInscription">
			<fieldset>
				<legend> Formulaire d'inscription : </legend>
				<div class="form-group">
					<label for="nom">Nom</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<input class="form-control" id="nom" type="text" name="nom" size="30" maxlength="45" placeholder="Nom" required>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="prenom">Prénom</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<input class="form-control" id="prenom" type="text" name="prenom" size="30" maxlength="45" placeholder="Prénom" required>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="nom">Adresse mail</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<input class="form-control" id="mail" type="email" name="mail" size="30" maxlength="45" placeholder="Adresse mail" required>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="mdp">Mot de passe</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<input class="form-control" id="mdp" type="password" name="mdp" size="30" maxlength="45" placeholder="Mot de passe" required>
						</div>
					</div>
				</div>
				<input type="hidden" name="urlPrec" value="<?php echo $_SERVER["HTTP_REFERER"] ?>"/>  <!-- permet de mémoriser l'url de la page précédente pour rediriger le User dessus après son inscription -->
				<button type="submit" class="btn btn-primary">Valider</button>
				<button type="reset" class="btn btn-primary">Annuler</button>
			</fieldset>
		</form>
	</div>
</div>