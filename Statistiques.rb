# PARMENON Damien
# Statistiques.rb
# Implementation de la classe Statistiques

# encoding: utf-8

# == Classe Statistiques permet d'obtenir toute les statistiques dans la base de données
# 	- donne le score total suivant une taille (scoreTaille), le score total suivant une difficulté et une taille , le temps de jeu total (tempsTotalJeu), le plus petit et le plus grand nombre de clics , le classement des joueurs sur une taille et une difficulté donnée , le nombre de defis gagné et le score Total
class Statistiques

# * Méthode d'instance retournant le score total du joueur
# * === Attributs :
#		- uneTaille	: un entier representant la taille de la Grille
# * Retourne un entier representant le score total dans la taille donnée
	def scoreTaille(uneTaille)
		return BaseDeDonnees.getScoreTotal(Compte.COMPTE.pseudo, uneTaille)
	end


# * Méthode d'instance retournant le temps total que le joueur a passé dans les résolutions de *Grille*
# * Retourne un entier representant le temps total en jeu
	def tempsTotalJeu()
		return BaseDeDonnees.getTempsTotal(Compte.COMPTE.pseudo)
	end

# * Méthode d'instance retournant le score total du joueur selon une taille et une difficulté
# * === Attributs :
#		- uneTaille	: un entier representant la taille de la Grille
# 		- uneDifficulte : un entier representant la difficulté de la Grille
# * Retourne un entier representant le score total dans la difficulté et la taille donnée
	def scoreDifficulte(uneTaille, uneDifficulte)
		return BaseDeDonnees.getScoreDifficulte(Compte.COMPTE.pseudo, uneTaille, uneDifficulte)
	end


# * Méthode d'instance retournant le plus petit nombre de clic utilisé pour finir une *Grille*
# * Retourne un entier representant le plus petit nombre de clic	
	def plusPetitNombreClic()
		return BaseDeDonnees.getPlusPetitNombreClic(Compte.COMPTE.pseudo)
	end
# * Méthode d'instance retournant le plus grand nombre de clic utilisé pour finir une *Grille*
# * Retourne un entier representant le plus grand nombre de clic
	def plusGrandNombreClic()
		return BaseDeDonnees.getPlusGrandNombreClic(Compte.COMPTE.pseudo)
	end
	
# * Méthode d'instance retournant le classement des joueurs en fonction du score total sur des grilles de taille et difficulté données
# * === Attributs :
#		- uneTaille	: un entier representant la taille de la Grille
# 		- uneDifficulte : un entier representant la difficulté de la Grille
# * Retourne un tableau contenant des tableaux du type [position dans le classement (entier), pseudo du joueur (<b>tring</b>), score du joueur (entier)]  representant le classement des joueurs
	def classement(uneTaille, uneDifficulte)
		return BaseDeDonnees.getClassement(uneTaille, uneDifficulte)
	end


# * Méthode d'instance retournant le nombre de *Defis* gagné
# * Retourne un entier
	def nbDefiGagne
		return BaseDeDonnees.getNbDefiGagne(Compte.COMPTE.pseudo)
	end
	

# * Méthode d'instance retournant le score total
# * Retourne un entier
	def scoreTotal
		return scoreTaille(6) + scoreTaille(8) + scoreTaille(10) + scoreTaille(12)
	end
end
