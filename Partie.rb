# PARMENON Damien
# Partie.rb
# Implementation de la classe Partie

# encoding: utf-8

# La classe Partie est une m�thode abstraite m�re de PartieMonde et PartieLibre
class Partie

# Grille sur laquelle le joueur va jouer
	@grille
# Tableau des sauvegardes/hypoth�se que le joueur a fait
	@listeSauvegardes
# Booleen informant si nous sommes dans un mode "hypoth�se"
	@hypothese
# Variable contenant notre base de donn�es
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

# M�thode permettant de cr�er une grille
	def initGrille(unIdGrille)

	end

# A modifier
	def lancer()
		while(!@grille.estTerminee?())

		end
	end


# M�thode retournant le score de la partie
	def calculerScore()
		return @grille.getClicMin * ( getDifficulte / ( temps * nbClics * 5 ) ) * ( 1 / ( 1 + nbAides) )
	end

# M�thode retournant la cha�ne de carac�re correspondant aux r�gles du jeu de takuzu
	def obtenirRegles()
		return "R�gles\n
		Il ne peut y avoir trois colonnes adjacentes de la m�me couleur.\n
		Les lignes et les colonnes sont constitu�s du m�me nombre de cellules rouges que de cellules bleues\n
		Il ne peut y avoir deux lignes ou deux colonnes identiques\n"
	end

# M�thode appelant la m�thode de m�me nom dans grille afin d'obtenir une aide
	def obtenirAide()
		@grille.obtenirAide()
	end

# M�thode permettant de passer en mode hypoth�se
	def sauvegarder()
		@hypothese = true
		@listeSauvegardes[@sauvegarde.length] = @grille
	end

# M�thode permettant de revenir au plus ancien �tat ou il n'y avait aucune hypoth�se
	def chargerPreHypo(uneSauvegarde)
		@grille = @listeSauvegardes[0]
		@listeSauvegardes = Array.[]
		@hypothese = false
	end

# M�thode permettant de charger l'�tat avant la derni�re hypoth�se faite
	def chargerDerniereSauvegarde()
		@grille = @listeSauvegardes[@listeSauvegardes.length -1]
		@listeSauvegardes.pop()
		if(listeSauvegardes.empty?)
			@listeSauvegardes = Array.[]
		end
		@hypothese = false
	end
end
	

