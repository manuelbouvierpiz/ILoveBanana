# encoding: utf-8

# Valentin CHAILLOU
# PartieSauvegarde.rb
# Implementation de la classe Options

# == Classe *PartieSauvegarde* :
#		- est une *Partie*
#		- connaît son temps sauvegardé
#		- sait se charger
class PartieSauvegarde < Partie
	
	# Variable d'instance

	# * Variable d'instance non accessible qui représente le temps sauvegardé de la *PartieSauvegarde*
	@tempsSauvegarde

	# * Méthode de classe

	# * Méthode de classe qui permet de créer une nouvelle *PartieSauvegarde*
	def PartieSauvegarde.charger()
		new()
	end
	
	# Méthodes d'instance
	
	# Méthode d'instance qui initialise la *PartieSauvegarde*
	def initialize()	# :nodoc:
		unIdGrille = BaseDeDonnees.getSauvegardeIdGrille(Compte.COMPTE.pseudo)
		super(unIdGrille)
		@nbHypotheses = BaseDeDonnees.getSauvegardeNbHypotheses(Compte.COMPTE.pseudo)
		@nbAides = BaseDeDonnees.getSauvegardeNbAides(Compte.COMPTE.pseudo)
		@nbClics = BaseDeDonnees.getSauvegardeNbClics(Compte.COMPTE.pseudo)
		@grille = Grille.creer(unIdGrille, BaseDeDonnees.getSauvegardeGrilleSauvegardee(Compte.COMPTE.pseudo))
		if @grille.difficulte >= 8
			@grille = GrilleHardcore.creer(unIdGrille, BaseDeDonnees.getSauvegardeGrilleSauvegardee(Compte.COMPTE.pseudo))
		end
		@tempsSauvegarde = BaseDeDonnees.getSauvegardeTemps(Compte.COMPTE.pseudo)
	end

	# * Méthode d'instance qui lance le chrono de la *PartieSauvegarde*
	# * Retourne *self*
	def lanceToi
		super()
		@debutChronometre -= @tempsSauvegarde
		return self
	end
	
	# * Méthode d'instance qui arrête la *PartieSauvegarde*
	# * Retourne *self*
	def arreteToi
		super()
		arretChronometre()
		return self
	end
	
	# * Méthode d'instance qui "termine" la *PartieSauvegarde*
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
