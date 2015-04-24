# encoding: utf-8

# Valentin CHAILLOU
# PartieSauvegarde.rb
# Implementation de la classe Options

# == Classe *PartieSauvegarde* :
#		- est une *Partie*
#		- sait se charger
class PartieSauvegarde < Partie

	@tempsSauvegarde

	def PartieSauvegarde.charger()
		new()
	end
	
	def initialize()
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
	
	# * Méthode d'instance qui "termine" la +Partie+
	# * Retourne +self+
	def gagner
		
		# On ne met à jour la BDD que si le score est meilleur
		unScore = calculerScore()
		if unScore > Compte.COMPTE.scorePourLaGrille(@grille)
			unNbEtoile = 0
		
			if unScore > BaseDeDonnees.getGrilleEtoileTroisScore(@grille.idGrille)
				unNbEtoile = 3
			elsif unScore > BaseDeDonnees.getGrilleEtoileDeuxScore(@grille.idGrille)
				unNbEtoile = 2
			elsif unScore > BaseDeDonnees.getGrilleEtoileUnScore(@grille.idGrille)
				unNbEtoile = 1
			end
	
			BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, unNbEtoile, @nbHypotheses, @nbAides, unScore)
		end
		return self
	end

	def lanceToi
		super()
		@debutChronometre -= @tempsSauvegarde
	end
	
	# * Méthode d'instance qui arrête la +PartieDidacticiel+
	def arreteToi
		super()
		arretChronometre()
	end
end
