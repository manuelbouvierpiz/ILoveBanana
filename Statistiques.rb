# PARMENON Damien
# Statistiques.rb
# Implementation de la classe Statistiques

# encoding: utf-8

# La classe Statistiques permet d'obtenir toute les statistiques dans la base de données
class Statistiques
	
	@compte

	def Statistiques.creer(unCompte)
		new(unCompte)
	end

	def initialize(unCompte)
		@compte = unCompte
	end

	def score(uneTaille)
		return BaseDeDonnees.getScoreTotal(@compte.pseudo, uneTaille)
	end

	def tempsTotalJeu()
		return BaseDeDonnees.getTempsTotal(@compte.pseudo)
	end

	def scoreDifficulte(uneTaille, uneDifficulte)
		return BaseDeDonnees.getScoreDifficulte(@compte.pseudo, uneTaille, uneDifficulte)
	end

	def classement(uneTaille, uneDifficulte)
		return BaseDeDonnees.getClassement(@compte.pseudo, uneTaille, uneDifficulte)
	end

	def miseAJour(unePartie)
		
	end
		
end