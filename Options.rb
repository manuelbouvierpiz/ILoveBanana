# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8

class Options

# Variable contenant le tableau des raccourcis clavier
	@tabRaccourciClavier

# Constucteur des options
	def Options.creer()
		new()
		
	end

# Initialise la variable avec notre base de données
	def initialize()
		@tabRaccourciClavier = [RaccourciClavier.new(1,"Bleu",Compte.COMPTE.pseudo),
								RaccourciClavier.new(2,"Rouge",Compte.COMPTE.pseudo),
								RaccourciClavier.new(3,"Pause",Compte.COMPTE.pseudo),
								RaccourciClavier.new(4,"Hypothèse",Compte.COMPTE.pseudo)]
	end

# Méthode permettant de modifier le volume des bruitages
	def modifierVolumeBruitage(unVolume)
		BaseDeDonnees.setVolumeBruitage(Compte.COMPTE.pseudo, unVolume)
	end

# Méthode permettant de modifier le volume de la musique
	def modifierVolumeMusique(unVolume)
		BaseDeDonnees.setVolumeBruitage(Compte.COMPTE.pseudo, unVolume)
	end

# Méthode permettant de réinitialiser intégralement les données du profil
	def resetProfil()
		BaseDeDonnees.ViderReussir(Compte.COMPTE.pseudo)
		BaseDeDonnees.viderFinir(Compte.COMPTE.pseudo)
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
		if(unOuDeux == 1)
			BaseDeDonnees.setCouleurUn(Compte.COMPTE.pseudo, uneCouleur)
		else
			BaseDeDonnees.setCouleurDeux(Compte.COMPTE.pseudo, uneCouleur)
		end
	end

# Méthode retournant soit l'une soit l'autre des deux couleurs choisies par l'utilisateur
	def couleur(unOuDeux)
		if(unOuDeux == 1)
			return BaseDeDonnees.getCouleurUn(Compte.COMPTE.pseudo)
		else
			return BaseDeDonnees.getCouleurDeux(Compte.COMPTE.pseudo)
		end
	end
end
