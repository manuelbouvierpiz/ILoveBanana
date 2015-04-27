# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8

# == Classe PartieLibre :
#		- est une Partie
#		- sait donner la liste de défis, s'arrêter, gagner
class PartieLibre < Partie
	
	# Méthode de classe

	# * Méthode de classe qui permet de créer une nouvelle *PartieLibre*
	# * === Attributs :
	#		- uneTaille : un entier représentant la taille de la *Grille* (ou <b>GrilleHardcore</b>) de la *PartieLibre*
	#		- uneDifficulte : un entier représentant la difficulte de la *Grille* (ou <b>GrilleHardcore</b>) de la *PartieLibre*
	def PartieLibre.creer(uneTaille, uneDifficulte)
		new(uneTaille, uneDifficulte)
	end
	
	# Méthodes d'instance
	
	# Méthode d'instance qui initialise la *PartieLibre*
	def initialize(unArgument, uneDifficulte=nil)	# :nodoc:
		unIdGrille = -1
		if uneDifficulte == nil		# unArgument = unIdGrille
			unIdGrille = unArgument
		else						# unArgument = uneTaille
			unIdGrille = BaseDeDonnees.getGrilleIdAleatoire(unArgument, uneDifficulte)
		end
		super(unIdGrille, uneDifficulte >= 8)
	end
	
	# * Méthode d'instance qui retourne la liste des défis du *Compte*
	# * Retourne un tableau de <b>Defi</b>s associés *Compte*
	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
	
	# * Méthode d'instance qui arrête la *PartieLibre*
	# * Retourne *self*
	def arreteToi
		super()
		arretChronometre()
		return self
	end
	
	# * Méthode d'instance qui "termine" la *PartieLibre*
	# * Retourne *self*
	def gagner
		# On ne met à jour la BDD que si le score est meilleur
		unScore = calculerScore()
		if unScore > Compte.COMPTE.scorePourLaGrille(@grille)
			BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, 0, @nbHypotheses, @nbAides, unScore)
		end
		return super()
	end
	
end
