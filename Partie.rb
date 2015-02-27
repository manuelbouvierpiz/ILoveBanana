# PARMENON Damien
# Case.rb
# Implementation de la classe Partie

# encoding: utf-8

# La classe Partie est une m�thode abstraite m�re de PartieMonde et PartieLibre
class Partie

# On se servira dans cette classe du module baseDeDonnees
	include baseDeDonnee

# Grille sur laquelle le joueur va jouer
	@grille
# Tableau des sauvegardes/hypoth�se que le joueur a fait
	@listeSauvegardes
# Booleen informant si nous sommes dans un mode "hypoth�se"
	@hypothese

# Initialise les variables d'instances
	def initialize
		@listeSauvegardes = Array.[]
		@hypothese = false
	end

# M�thode permettant de cr�er une grille
	def initGrille()

	end

# A modifier
	def joue()
		while(!@grille.estTerminee?())

		end
	end


	def calculerScore()
		return @grille.getClicMin * ( getDifficulte / ( @grille.getTemps * @grille.getClics * 5 ) ) * ( 1 / ( 1 + getnbAide) )
	end

	def obtenirRegles()
		return "R�gles\n
		Il ne peut y avoir trois colonnes adjacentes de la m�me couleur.\n
		Les lignes et les colonnes sont constitu�s du m�me nombre de cellules rouges que de cellules bleues\n
		Il ne peut y avoir deux lignes ou deux colonnes identiques\n"
	end

	def obtenirAide()
		@grille.obtenirAide()
	end

	def sauvegarder()
		@hypothese = true
		@listeSauvegardes[@sauvegarde.length] = @grille
	end

	def chargerPreHypo(uneSauvegarde)
		@grille = @listeSauvegardes[0]
		@listeSauvegardes = Array.[]
		@hypothese = false
	end

	def chargerDerniereSauvegarde()
		@grille = @listeSauvegardes[@listeSauvegardes.length -1]
		@listeSauvegardes.pop()
		if(listeSauvegardes.empty?)
			@listeSauvegardes = Array.[]
		end
	end
end
	

