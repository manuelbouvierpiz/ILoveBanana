# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8

class Options

# Variable contenant notre base de données
	@baseDeDonnees

# Variable contenant le pseudo du joueur qui joue actuellement
	@joueur

# Variable contenant le tableau des raccourcis clavier
	@tabRaccourciClavier

# Constucteur des options
	def Options.creer(uneBaseDeDonnees, unCompte)
		new(uneBaseDeDonnees, unCompte)
		
	end

# Initialise la variable avec notre base de données
	def initialize(uneBaseDeDonnees, unCompte)
		@baseDeDonnees = uneBaseDeDonnees
		@joueur = unCompte
		@tabRaccourciClavier = [RaccourciClavier.new(1,"Bleu",@joueur.pseudo,@baseDeDonnees),
								RaccourciClavier.new(2,"Rouge",@joueur.pseudo,@baseDeDonnees),
								RaccourciClavier.new(3,"Pause",@joueur.pseudo,@baseDeDonnees),
								RaccourciClavier.new(4,"Hypothèse",@joueur.pseudo,@baseDeDonnees)]
	end

# Méthode permettant de modifier le volume des bruitages
	def modifierVolumeBruitage(unVolume)
		@baseDeDonnees.setVolumeBruitage(@joueur, unVolume)
	end

# Méthode permettant de modifier le volume de la musique
	def modifierVolumeMusique(unVolume)
		@baseDeDonnees.setVolumeBruitage(@joueur, unVolume)
	end

# Méthode permettant de réinitialiser intégralement les données du profil
	def resetProfil()
		@baseDeDonnees.ViderReussir(@pseudo)
		@baseDeDonnees.viderFinir(@pseudo)
	end

# Méthode permettant de modifier un raccourci clavier
	def changerRaccourci(unId)
		@tabRaccourciClavier.each do |touche|
			if(@tabRaccourciClavier[i].id == unId)
				@tabRaccourciClavier[i].changerTouche(unId)
			end
		end
	end

# Méthode permettant de réinitialiser tout les raccourcis clavier
	def resetTouches()
		@tabRaccourciClavier.each do |touche|
			touche.resetTouche()
		end
	end

# Méthode permettant de modifier les couleurs appliquées aux cases
	def changerCouleur(unOuDeux, uneCouleur)
		if(unOuDeux = 1)
			@baseDeDonnees.setCouleurUn(@joueur.pseudo, uneCouleur)
		else
			@baseDeDonnees.setCouleurDeux(@joueur.pseudo, uneCouleur)
		end
	end

# Méthode retournant soit l'une soit l'autre des deux couleurs choisies par l'utilisateur
	def couleur(unOuDeux)
		if(unOuDeux = 1)
			return @baseDeDonnees.getCouleurUn(@joueur.pseudo)
		else
			return @baseDeDonnees.getCouleurDeux(@joueur.pseudo)
		end
	end
end