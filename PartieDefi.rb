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
	
	# * Méthode d'instance qui "termine" la *PartieDefi*
	# * Retourne *self*
	def gagner
	
		# On ne met pas à jour la BDD pour les défis (sinon, ça pourrait débloquer des niveaux du monde qui ne devraient pas être accessibles)
		return self
	end
end
