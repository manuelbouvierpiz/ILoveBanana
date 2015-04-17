# encoding: utf-8

# PARMENON Damien
# Options.rb
# Implementation de la classe Options

class Options

# Variable contenant le tableau des raccourcis clavier
	@tabRaccourciClavier

# Constucteur des options
	def Options.creer(unPseudo)
		new(unPseudo)
	end 

# Initialise la variable avec notre base de données
	def initialize(unPseudo)
		@tabRaccourciClavier = [RaccourciClavier.creer(1,"Pause",unPseudo),
								RaccourciClavier.creer(2,"ClicDroit",unPseudo),
								RaccourciClavier.creer(3,"ClicGauche",unPseudo),
								RaccourciClavier.creer(4,"Hypothèse",unPseudo)]
	end

# Méthode permettant de modifier le volume des bruitages
	def modifierVolumeBruitage(unVolume)
		BaseDeDonnees.setVolumeBruitage(Compte.COMPTE.pseudo, unVolume)
	end

	def getVolumeBruitage
		return BaseDeDonnees.getVolumeBruitage(Compte.COMPTE.pseudo)
	end

# Méthode permettant de modifier le volume de la musique
	def modifierVolumeMusique(unVolume)
		BaseDeDonnees.setVolumeMusique(Compte.COMPTE.pseudo, unVolume)
	end

	def getVolumeMusique
		return BaseDeDonnees.getVolumeMusique(Compte.COMPTE.pseudo)
	end

	def Options.premiereInitialisationOptions(unPseudo)
		BaseDeDonnees.setVolumeBruitage(unPseudo, 50)
		BaseDeDonnees.setVolumeMusique(unPseudo, 50)
		BaseDeDonnees.setCouleurUn(unPseudo, "#FFFF00000000")
		BaseDeDonnees.setCouleurDeux(unPseudo, "#00000000FFFF")
		RaccourciClavier.premiereInitialisationRaccourci(unPseudo)
	end
# Méthode permettant de réinitialiser intégralement les données du profil
	def resetProfil()
		BaseDeDonnees.ViderReussir(Compte.COMPTE.pseudo)
		BaseDeDonnees.viderFinir(Compte.COMPTE.pseudo)
	end

# Méthode permettant de modifier un raccourci clavier
	def changerRaccourci(unId, unRaccourci)
		@tabRaccourciClavier[unId-1].changerTouche(unRaccourci)
	end

	def getRaccourci(unId)
		return BaseDeDonnees.getRaccourci(Compte.COMPTE.pseudo, unId)
	end

	def resetOptions
		Options.premiereInitialisationOptions(Compte.COMPTE.pseudo)
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
