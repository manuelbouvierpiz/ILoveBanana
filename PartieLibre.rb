# PARMENON Damien
# Options.rb
# Implementation de la classe Options

# encoding: utf-8


class PartieLibre < Partie

	def PartieLibre.creer(uneTaille, uneDifficulte, estHardcore=false)
		new(uneTaille, uneDifficulte, estHardcore)
	end
	
	def initialize(unArgument, uneDifficulte=nil, estHardcore)
		unIdGrille = -1
		if uneDifficulte == nil		# unArgument = unIdGrille
			unIdGrille = unArgument
		else						# unArgument = uneTaille
			unIdGrille = BaseDeDonnees.getGrilleIdAleatoire(unArgument, uneDifficulte)
		end
		super(unIdGrille, estHardcore)
	end

	def listeDefis
		return BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
	end
	
	# * Méthode d'instance qui arrête la +PartieDidacticiel+
	def arreteToi
		super()
		arretChronometre()
	end
end
