# PARMENON Damien
# Partie.rb
# Implementation de la classe Partie

# encoding: utf-8

# La classe Partie est une méthode abstraite mère de PartieMonde et PartieLibre
class Partie

# Grille sur laquelle le joueur va jouer
	@grille
# Tableau des sauvegardes/hypothèse que le joueur a fait
	@listeSauvegardes
# Booleen informant si nous sommes dans un mode "hypothèse"
	@hypothese
# Variable contenant notre base de données
	@baseDeDonnees

	@nbClics

	@temps

	@nbAides

	@nbHypotheses

	private_class_method :new

	attr_reader :nbClics, :temps, :nbAides, :nbHypotheses, :grille


# Constucteur d'une partie 
	def Partie.creer(uneBaseDeDonnees)
			new(uneBaseDeDonnees)
	end

# Initialise les variables d'instances
	def initialize(uneBaseDeDonnees)
		@listeSauvegardes = Array.[]
		@hypothese = false
		@baseDeDonnees = uneBaseDeDonnees
	end

# Méthode permettant de créer une grille
	def initGrille(unIdGrille)

	end

# A modifier
	def lancer()
		while(!@grille.estTerminee?())

		end
	end


# Méthode retournant le score de la partie
	def calculerScore()
		return @grille.getClicMin * ( getDifficulte / ( temps * nbClics * 5 ) ) * ( 1 / ( 1 + nbAides) )
	end

# Méthode retournant la chaîne de caracère correspondant aux règles du jeu de takuzu
	def obtenirRegles()
		return "Règles\n
		Il ne peut y avoir trois colonnes adjacentes de la même couleur.\n
		Les lignes et les colonnes sont constitués du même nombre de cellules rouges que de cellules bleues\n
		Il ne peut y avoir deux lignes ou deux colonnes identiques\n"
	end

# Méthode appelant la méthode de même nom dans grille afin d'obtenir une aide
	def obtenirAide()
		@grille.obtenirAide()
	end

# Méthode permettant de passer en mode hypothèse
	def sauvegarder()
		@hypothese = true
		@listeSauvegardes[@sauvegarde.length] = @grille
	end

# Méthode permettant de revenir au plus ancien état ou il n'y avait aucune hypothèse
	def chargerPreHypo(uneSauvegarde)
		@grille = @listeSauvegardes[0]
		@listeSauvegardes = Array.[]
		@hypothese = false
	end

# Méthode permettant de charger l'état avant la dernière hypothèse faite
	def chargerDerniereSauvegarde()
		@grille = @listeSauvegardes[@listeSauvegardes.length -1]
		@listeSauvegardes.pop()
		if(listeSauvegardes.empty?)
			@listeSauvegardes = Array.[]
		end
		@hypothese = false
	end
end
	

