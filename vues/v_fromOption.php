<!-- Vue formulaire de création d'option. Condition : être connecté en tant qu'admin.
Champs obligatoires : nom de l'option, prix de l'option (float)
Facultatif : description de l'option
-->

<div class="row">
	<div class="col-md-8 col-md-offset-2">
		<?php
		if (isset($_REQUEST['erreurs']))
		{
			foreach($_REQUEST['erreurs'] as $erreur)
			{
				echo '<h4 class="text-danger">'.$erreur.'</h4>';
			}
		}
		?>
		<form class="form-vertical" method="POST" action="index.php?uc=administration&amp;action=valideCreationOption">
			<fieldset>
				<legend> Définition de l'option à créer : </legend>
				<div class="form-group">
					<label for="nom">Nom de l'option</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<input class="form-control" id="nomOption" type="text" name="nomOption" size="30" maxlength="45" placeholder="Nom de l'option" required>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="nom">Description de l'option</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<textarea class="form-control" id="descOption" name="descOption" rows="3" cols="45" maxlenght="200" placeholder="Description de l'option"></textarea>  
						</div>
					</div>
				</div>
			<div class="form-group">
					<label for="nom">Prix de l'option</label>
					<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-4">
							<input class="form-control" id="prixOption" type="number" step="any" name="prixOption" max="999999.99" required>  <!-- Montant max = 999999.99. Flottants acceptés -->
						</div>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Valider</button>
				<button type="reset" class="btn btn-primary">Annuler</button>
			</fieldset>
		</form>
	</div>
</div>