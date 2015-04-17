# PARMENON Damien
# Statistiques.rb
# Implementation de la classe Statistiques

# encoding: utf-8

# La classe Statistiques permet d'obtenir toute les statistiques dans la base de données
class Statistiques

# Constructeur de la classe Statistique, elle est amené à être instanciée une seule fois
	def Statistiques.creer()
		new()
	end

# Méthode retournant le score total du joueur selon une taille
	def score(uneTaille)
		return BaseDeDonnees.getScoreTotal(Compte.COMPTE.pseudo, uneTaille)
	end

# Méthode retournant le temps total que le joueur a passé dans les résolutions de grille
	def tempsTotalJeu()
		return BaseDeDonnees.getTempsTotal(Compte.COMPTE.pseudo)
	end

# Méthode retournant le score total du joueur selon une taille et une difficulté
	def scoreDifficulte(uneTaille, uneDifficulte)
		return BaseDeDonnees.getScoreDifficulte(Compte.COMPTE.pseudo, uneTaille, uneDifficulte)
	end

	def plusPetitNombreClic()
		return BaseDeDonnees.getPlusPetitNombreClic(Compte.COMPTE.pseudo)
	end

	def plusGrandNombreClic()
		return BaseDeDonnees.getPlusGrandNombreClic(Compte.COMPTE.pseudo)
	end
	
# Méthode retournant le classement des joueurs en fonction du score total sur des grilles de taille et difficulté données
	def classement(uneTaille, uneDifficulte)
		return BaseDeDonnees.getClassement(uneTaille, uneDifficulte)
	end

# Méthode premettant de mettre à jour la base de données lorsqu'une partie est terminée
	def miseAJour(unePartie)
		setGrilleTerminee(Compte.COMPTE.pseudo, unePartie.temps, unePartie.nbClics, unePartie.grille.idGrille, unePartie.nbHypotheses, unePartie.nbAides, unePartie.calculerScore())
		return self
	end
		
end
