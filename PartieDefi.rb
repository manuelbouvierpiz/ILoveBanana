# PARMENON Damien

# encoding: utf-8


class PartieDefi < Partie

	attr :unIdGrille, false
	attr :unJoueur, false
	attr :unScore, false

	def PartieDefi.creer(unIdGrille, unJoueur, unScore)
		new(unIdGrille, unJoueur, unScore)
	end
	
	def initialize(unIdGrille, unJoueur,unScore)
		@unIdGrille = unIdGrille
		@unJoueur = unJoueur
		@unScore = unScore
		if(BaseDeDonnees.getGrilleDifficulte(unIdGrille) >= 8)
			super(unIdGrille, true)
		else
			super(unIdGrille)
		end
	end

	def setVainqueur(unPseudo, unScore)
		BaseDeDonnees.setVainqueurDefi(Compte.COMPTE.pseudo, @unJoueur, @unIdGrille, unPseudo, unScore)
	end
end
