# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8

# == Classe +PartieSauvegarde+ :
#		- est une +Partie+
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
		
		Compte.COMPTE.supprimeSauvegarde()	# Maintenant qu'elle est chargée, on peut libérer la place
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
