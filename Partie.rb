# encoding: UTF-8
# PARMENON Damien
# Partie.rb
# Implementation de la classe Partie

# La classe Partie est une méthode abstraite mère de PartieMonde et PartieLibre
class Partie

# Grille sur laquelle le joueur va jouer
	@grille
# Tableau des sauvegardes/hypothèse que le joueur a fait
	@listeHypotheses
# Booleen informant si nous sommes dans un mode "hypothèse"
	@hypothese
# Variable contenant le nombre de clic que l'utilisateur a fait pour terminer la grille, elle s'incrémente durant la partie.
	@nbClics
# Variable contenant le temps que l'utilsateur a mis pour terminer la grille
	@temps
# Variable contenant le nombre de fois que l'utilisateur a utiliser l'aide
	@nbAides
# Variable contenant le nombre d'hypothèse que l'utilisateur a fait pour terminer la grille
	@nbHypotheses
# Variable contenant l'id de la grille
	@idGrille


	private_class_method :new

	attr_reader :nbClics, :temps, :nbAides, :nbHypotheses, :grille


# Constucteur d'une partie 
	def Partie.creer(unIdGrille)
			new(unId)
	end

# Constructeur permettant de charger une grille sauvegardée
	def Partie.charger()
			new()
	end

# Initialise les variables d'instances
	def initialize(unIdGrille)
		@listeHypotheses = Array.[]
		@hypothese = false
		initGrille(unIdGrille)
		@idGrille = idGrille
	end

# Méthode initialize du constructeur charger
	def initialize()
		@compte = unCompte
		@nbHypotheses = BaseDeDonnees.getSauvegardeNbHypotheses(Compte.COMPTE.pseudo)
		@nbAides = BaseDeDonnees.getSauvegardeNbAides(Compte.COMPTE.pseudo)
		@nbClics = BaseDeDonnees.getSauvegardeNbClics(Compte.COMPTE.pseudo)
		@temps = BaseDeDonnees.getSauvegardeTemps(Compte.COMPTE.pseudo)
		@idGrille = BaseDeDonnees.getSauvegardeIdGrille(Compte.COMPTE.pseudo)
		matGrille = BaseDeDonnees.getSauvegardeGrilleSauvegardee(Compte.COMPTE.pseudo)
		@grille = Grille.creer(unIdGrille, matGrille)
	end

# Méthode permettant de créer une grille
	def initGrille(unIdGrille)
		@grille = Grille.creer(unIdGrille)
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
		BaseDeDonnees.setSauvegarde(Compte.COMPTE.pseudo(), @temps, @nbClics, @nbHypotheses, @nbAides, @idGrille, @listeHypotheses)
	end

# Méthode permettant d'entrer en mode hypothèse
	def fairehypothese()
		@listeHypotheses.push(@grille)
		@hypothese = true
	end

# Méthode permettant de revenir au plus ancien état ou il n'y avait aucune hypothèse
	def chargerPreHypo()
		@grille = @listeHypotheses[@listeHypotheses.length -1]
		@listeHypotheses.pop()
		@hypothese = false
	end
	
	def lanceToi()
		@debutChronometre = Time.now
        	@tourne = true	
	end
	
	def arret()
        	@finChronometre = Time.now - @debutChronometre
        	@tourne = false
        	@fini = true
        	return @finChronometre.to_i
    	end

    	def mettreEnPause()
        	@pause = Time.now
        	@tourne = false
    	end

    	def reprise()
        	@debutChronometre += Time.now - @pause
        	@tourne = true
    	end

    	def getTempsChronometre()
        	tempsActuel = Time.now - @debutChronometre
        	return tempsActuel.to_i
    	end
end
	

