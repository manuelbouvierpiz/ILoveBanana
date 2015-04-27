# PARMENON Damien

# encoding: utf-8

# == Classe PartieDefi :
#		- est une Partie
#		- sait s'attribuer un vainqueur
class PartieDefi < Partie

	attr :unIdGrille, false
	attr :unJoueur, false
	attr :unScore, false

	# Méthode de classe

	# * Méthode de classe qui permet de créer une nouvelle *PartieDefi*
	# * === Attributs :
	#		- unIdGrille : un entier représentant l'unique ID de la *Grille* (ou <b>GrilleHardcore</b>) de la *PartieDefi*
	#		- unJoueur : un *String* représentant le pseudo d'un joueur (ou <b>Compte</b>) qui a envoyé le défi
	#		- unScore : un entier représentant le score du joueur (ou <b>Compte</b>) qui a envoyé le défi
	def PartieDefi.creer(unIdGrille, unJoueur, unScore)
		new(unIdGrille, unJoueur, unScore)
	end
	
	# Méthodes d'instance
	
	# Méthode d'instance qui initialise la *PartieDefi*
	def initialize(unIdGrille, unJoueur,unScore)	# :nodoc:
		@unIdGrille = unIdGrille
		@unJoueur = unJoueur
		@unScore = unScore
		if(BaseDeDonnees.getGrilleDifficulte(unIdGrille) >= 8)
			super(unIdGrille, true)
		else
			super(unIdGrille)
		end
	end

	# * Méthode d'instance qui permet d'attribuer un vainqueur à la *PartieDefi*
	# * === Attributs :
	#		- unPseudo : un *String* représentant le pseudo du vainqueur
	#		- unScore : un entier représentant le score du vainqueur
	# * Retourne *self*
	def setVainqueur(unPseudo, unScore)
		BaseDeDonnees.setVainqueurDefi(Compte.COMPTE.pseudo, @unJoueur, @unIdGrille, unPseudo, unScore)
		return self
	end
	
end
