# encoding: utf-8

# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# == Classe Options
#		- connaît ses raccourcis claviers
#		- sait modifier le volume de la musique et du bruitage (non implémentés), changer les raccourcis, les couleurs et remettre à zéro le profil
class Options

	# Variable d'instance

	# * Variable d'instance non accessible représentant le tableau des <b>RaccourciClavier</b>s
	@tabRaccourciClavier
	
	# Méthodes de classe

	# * Méthode de classe qui permet de créer les *Options*
	# * === Attribut :
	#		- unPseudo : un *String* représentant un pseudo
	def Options.creer(unPseudo)
		new(unPseudo)
	end 
	
	private_class_method :new
	
	# * Méthode de classe qui permet d'initialiser les différents paramètres avec leurs valeurs par défaut
	# * === Attribut :
	#		- unPseudo : un *String* représentant un pseudo
	# * Retourne *self*
	def Options.premiereInitialisationOptions(unPseudo)
		BaseDeDonnees.setVolumeBruitage(unPseudo, 50)
		BaseDeDonnees.setVolumeMusique(unPseudo, 50)
		BaseDeDonnees.setCouleurUn(unPseudo, "#FFFF00000000")
		BaseDeDonnees.setCouleurDeux(unPseudo, "#00000000FFFF")
		RaccourciClavier.premiereInitialisationRaccourci(unPseudo)
		return self
	end
	
	# Méthodes d'instance

	# Initialise la variable avec notre base de données
	def initialize(unPseudo) # :nodoc
		@tabRaccourciClavier = [RaccourciClavier.creer(1,"Pause",unPseudo),
								RaccourciClavier.creer(2,"ClicDroit",unPseudo),
								RaccourciClavier.creer(3,"ClicGauche",unPseudo),
								RaccourciClavier.creer(4,"Hypothèse",unPseudo)]
	end

	# * Méthode d'instance permettant de modifier le volume des bruitages
	# * Les sons (bruitage et musique) ne sont pas implémentés
	# * === Attribut :
	#		- unVolume : un entier représentant le volume
	# * Retourne *self*
	def modifierVolumeBruitage(unVolume)
		BaseDeDonnees.setVolumeBruitage(Compte.COMPTE.pseudo, unVolume)
		return self
	end

	# * Méthode d'instance qui renvoie le volume des bruitages
	# * Retourne un entier qui représente le volume des bruitages
	def getVolumeBruitage
		return BaseDeDonnees.getVolumeBruitage(Compte.COMPTE.pseudo)
	end

	# * Méthode d'instance permettant de modifier le volume de la musique
	# * Les sons (bruitage et musique) ne sont pas implémentés
	# * === Attribut :
	#		- unVolume : un entier représentant le volume
	# * Retourne *self*
	def modifierVolumeMusique(unVolume)
		BaseDeDonnees.setVolumeMusique(Compte.COMPTE.pseudo, unVolume)
		return self
	end

	# * Méthode d'instance qui renvoie le volume de la musique
	# * Retourne un entier qui représente le volume de la musique
	def getVolumeMusique
		return BaseDeDonnees.getVolumeMusique(Compte.COMPTE.pseudo)
	end

	# * Méthode d'instance permettant de réinitialiser intégralement les *Options* du *Compte*
	# * <b>REMET A ZERO TOUTES LES INFORMATIONS DANS LA BASE DE DONNEES</b>
	# * Retourne *self*
	def resetProfil()
		BaseDeDonnees.ViderReussir(Compte.COMPTE.pseudo)
		BaseDeDonnees.viderFinir(Compte.COMPTE.pseudo)
		return self
	end

	# * Méthode d'instance permettant de modifier un *RaccourciClavier*
	# * === Attributs :
	#		- unId : un entier représentant l'id d'un *RaccourciClavier* (de 1 à 4)
	#		- unRaccourci : un *RaccourciClavier* par lequel le remplacer
	# * Retourne *self*
	def changerRaccourci(unId, unRaccourci)
		@tabRaccourciClavier[unId-1].changerTouche(unRaccourci)
	end

	# * Méthode d'instance qui renvoie un *RaccourciClavier*
	# * === Attribut :
	#		- unId : un entier représentant l'ID d'un *RaccourciClavier* (de 1 à 4)
	# * Retourne le *RaccourciClavier* correspondant à l'id
	def getRaccourci(unId)
		return BaseDeDonnees.getRaccourci(Compte.COMPTE.pseudo, unId)
	end

	# * Méthode d'instance qui remet à zéro les *Options*
	# * Retourne *self*
	def resetOptions
		Options.premiereInitialisationOptions(Compte.COMPTE.pseudo)
		return self
	end

	# * Méthode d'instance permettant de réinitialiser tout les <b>RaccourciClavier</b>s
	# * Retourne *self*
	def resetTouches()
		@tabRaccourciClavier.each do |touche|
			touche.resetTouche()
		end
		return self
	end

	# * Méthode d'instance qui permet de modifier les couleurs appliquées aux cases
	# * === Attributs :
	#		- unOuDeux : un entier qui indique si on modifie la première ou la seconde couleur (1 ou 2)
	#		- uneCouleur : un *String* de la forme "#RRRRGGGGBBBB" qui représente la couleur
	# * Retourne *self*
	def changerCouleur(unOuDeux, uneCouleur)
		if(unOuDeux == 1)
			BaseDeDonnees.setCouleurUn(Compte.COMPTE.pseudo, uneCouleur)
		else
			BaseDeDonnees.setCouleurDeux(Compte.COMPTE.pseudo, uneCouleur)
		end
		return self
	end

	# * Méthode d'instance retournant soit l'une soit l'autre des deux couleurs choisies par l'utilisateur
	# * === Attribut :
	#		- unOuDeux : un entier qui indique si on veut la première ou la seconde couleur (1 ou 2)
	# * Retourne un *String* de la forme "#RRRRGGGGBBBB" qui représente la couleur
	def couleur(unOuDeux)
		if(unOuDeux == 1)
			return BaseDeDonnees.getCouleurUn(Compte.COMPTE.pseudo)
		else
			return BaseDeDonnees.getCouleurDeux(Compte.COMPTE.pseudo)
		end
	end
end
