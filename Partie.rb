# encoding: ISO-8859-1
# PARMENON Damien
# Partie.rb
# Implementation de la classe Partie

# La classe Partie est une m�thode abstraite m�re de PartieMonde et PartieLibre
class Partie

# Grille sur laquelle le joueur va jouer
	@grille
# Tableau des sauvegardes/hypoth�se que le joueur a fait
	@listeHypotheses
# Booleen informant si nous sommes dans un mode "hypoth�se"
	@hypothese
# Variable contenant le nombre de clic que l'utilisateur a fait pour terminer la grille, elle s'incr�mente durant la partie.
	@nbClics
# Variable contenant le temps que l'utilsateur a mis pour terminer la grille
	@temps
# Variable contenant le nombre de fois que l'utilisateur a utiliser l'aide
	@nbAides
# Variable contenant le nombre d'hypoth�se que l'utilisateur a fait pour terminer la grille
	@nbHypotheses
# Variable contenant le compte de l'utilisateur actuel
	@compte
# Variable contenant l'id de la grille
	@idGrille


	private_class_method :new

	attr_reader :nbClics, :temps, :nbAides, :nbHypotheses, :grille


# Constucteur d'une partie 
	def Partie.creer(unCompte, unIdGrille)
			new(unCompte, unId)
	end

# Constructeur permettant de charger une grille sauvegard�e
	def Partie.charger(unCompte)
			new(unCompte)
	end

# Initialise les variables d'instances
	def initialize(unCompte, unIdGrille)
		@listeHypotheses = Array.[]
		@hypothese = false
		initGrille(unIdGrille)
		@idGrille = idGrille
	end

# M�thode initialize du constructeur charger
	def initialize(unCompte)
		@compte = unCompte
		@nbHypotheses = BaseDeDonnees.getSauvegardeNbHypotheses(@compte.pseudo)
		@nbAides = BaseDeDonnees.getSauvegardeNbAides(@compte.pseudo)
		@nbClics = BaseDeDonnees.getSauvegardeNbClics(@compte.pseudo)
		@temps = BaseDeDonnees.getSauvegardeTemps(@compte.pseudo)
		@idGrille = BaseDeDonnees.getSauvegardeIdGrille(@compte.pseudo)
		matGrille = BaseDeDonnees.getSauvegardeGrilleSauvegardee(@compte.pseudo)
		@grille = Grille.creer(unIdGrille, matGrille)
	end

# M�thode permettant de cr�er une grille
	def initGrille(unIdGrille)
		@grille = Grille.creer(unIdGrille)
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
		BaseDeDonnees.setSauvegarde(@compte.pseudo(), @temps, @nbClics, @nbHypotheses, @nbAides, @idGrille, @listeHypotheses)
	end

# M�thode permettant d'entrer en mode hypoth�se
	def fairehypothese()
		@listeHypotheses.push(@grille)
		@hypothese = true
	end

# M�thode permettant de revenir au plus ancien �tat ou il n'y avait aucune hypoth�se
	def chargerPreHypo()
		@grille = @listeHypotheses[@listeHypotheses.length -1]
		@listeHypotheses.pop()
		@hypothese = false
	end
end
	

