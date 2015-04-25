# encoding: UTF-8
# PARMENON Damien, CHAILLOU Valentin, YZEUX Ronan
# Partie.rb
# Implementation de la classe Partie


# La classe Partie est une méthode abstraite mère de PartieMonde et PartieLibre
# == Classe Partie :
#		- est considérée comme une classe abstraite
#		- connaît sa grille, sa liste d'hypothèses, son nombre de clics courant, son nombre d'aides, son nombre total d'hypothèses, le début du chronomètre, la fin du chronomètre, l'heure de la pause, si le chrono est fini et sa liste de mouvements arrière
#		- sait calculer son score, établir une hypothèse et revenir à son état précédent, gérer le temps, gagner, s'arrêter, jouer un coup et revenir en arrière
class Partie

	# * Variable d'instance accessible en lecture qui représente la *Grille* sur laquelle le joueur va jouer
	# * La grille va être modifiée au fur et à mesure de la *Partie*
	attr :grille, false
	
	# * Variable d'instance non accessible (un <b>Array</b>) représentant une pile hétérogène utilisée pour les hypothèses de la *Partie*
	# * Sont empilés dans ce sens : la *Grille*, le nombre de clics, et le temps courant
	@listeHypotheses
	
	# * Variable d'instance accessible en lecture (un entier) représentant le nombre de clic que l'utilisateur a fait
	# * Elle s'incrémente durant la partie
	attr :nbClics, false
	
	# * Variable d'instance non accessible (un entier) qui représente le nombre de fois que l'utilisateur a utilisé l'aide pendant la *Partie*
	@nbAides
	
	# * Variable d'instance accessible en lecture (un entier) qui représente le nombre d'hypothèse que l'utilisateur a fait pendant la *Partie*
	@nbHypotheses
	
	# * Variable d'instance non accessible (<b>Time</b>) représentant l'heure de début du lancement du chronometre de la *Partie*
	@debutChronometre
	
	# * Variable d'instance non accessible (<b>Time</b>) contenant la différence entre l'heure actuelle et le début du chronomètre de la *Partie*
	@finChronometre
	
	# * Variable d'instance non accessible (<b>Time</b>) contenant l'heure de début de la pause de la *Partie*
	@pause
	
	# * Variable d'instance accessible en lecture indiquant si le chronomètre de la *Partie* est actif ou non
	attr :tourne, false
	
	# * Variable non accessible indiquant si le chronomètre de la *Partie* est fini ou non
	@fini

	# * Variable d'instance non accessible (un <b>Array</b>) représentant la pile de mouvements pour les retours arrière
	# * Les retours arrière sont des <b>String</b> à exécuter
	@mouvementsArriere

	# Méthode de classe

	# * Méthode de classe qui crée une nouvelle +Partie+
	# * === Attribut :
	#		- unIdGrille : un entier représentant l'unique ID de la Grille à utiliser
	# * === Attributs :
	#		- unIdGrille : un entier représentant l'unique ID de la Grille à utiliser
	#		- estHardCore : un booléen indiquant si la grille cherchée est une GrilleHardcore
	def Partie.creer(unIdGrille, estHardcore=false)
			new(unIdGrille, estHardcore)
	end
	
	private_class_method :new

	# Méthodes d'instance
	
	# Initialise les variables d'instances
	def initialize(unIdGrille, estHardcore=false)	# :nodoc:
		@nbHypotheses = 0
		@nbAides = 0
		@nbClics = 0
		if estHardcore
			@grille = GrilleHardcore.creer(unIdGrille)
		else
			@grille = Grille.creer(unIdGrille)
		end
		@fini = false
		@listeHypotheses = Array.[]
		@tourne = false
		@debutChronometre = nil
		@mouvementsArriere = []
	end

	# * Méthode d'instance qui calcule le score de la *Partie*
	# * Retourne un entier représentant le score de la *Partie*
	def calculerScore()
		return ((@grille.taille ** 5) * @grille.nbClicMin * ( 1.0 * @grille.difficulte / ( 1.0 * getTemps * @nbClics * 5 ) ) * ( 1.0 / ( 1 + @nbAides) ) * ( 1.0 / ( 1 + @nbHypotheses) ) ).to_i
	end

	# * Méthode d'instance qui donne une aide pour cette *Partie*
	# * Appelle la méthode du même nom de sa *Grille*
	# * Retourne un tableau contant un *String* représentant l'aide et les coordonnées de la *Case* (ou de la colonne/ligne) [String, x, y]
	def obtenirAide()
		@nbAides += 1
		@grille.obtenirAide()
	end

	# * Méthode d'instance qui pose une hypothèse
	# * Crée une copie de la *Grille* et l'insère dans sa pile, ainsi que le nombre de clics, le temps et la liste de mouvements arrière
	# * Retourne un entier représentant le nombre d'hypothèses effectués durant la *Partie*
	def faireHypothese()
		if @grille.difficulte < 8
			@listeHypotheses.push(Grille.creer(grille.idGrille, grille.matrice))			# on crée une copie de la Grille (un clone ne copie pas les attributs en profondeur)
		else
			@listeHypotheses.push(GrilleHardcore.creer(grille.idGrille, grille.matrice))	# on crée une copie de la Grille (un clone ne copie pas les attributs en profondeur)
		end
		
		@listeHypotheses.push(@nbClics)
		@listeHypotheses.push(getTemps)
		@listeHypotheses.push(@mouvementsArriere.clone)
		
		@nbHypotheses += 1
	end

	# * Méthode d'instance qui permet de charger la dernière *Grille* sauvegardée
	# * Retourne *elf*
	def chargerPreHypo()
		# /!\ @listeHypotheses est une pile, il faut dépiler dans le sens inverse
		@mouvementsArriere = @listeHypotheses.pop()
		@debutChronometre = Time.now - @listeHypotheses.pop()
		@nbClics = @listeHypotheses.pop()
		@grille = @listeHypotheses.pop()
		return self
	end

	# * Méthode d'instance permettant de lancer le chronomètre
	# * Retourne *self*
	def lanceToi()
		if @debutChronometre == nil
			@debutChronometre = Time.now
			@tourne = true	
		else
			repriseChronometre
		end
		return self
	end
	
	# * Méthode d'instance qui arrête la *Partie*
	# * Sauvegarde la *Partie* pour pouvoir la reprendre plus tard
	# * Retourne *self*
	def arreteToi
		sauvegarder
		return self
	end
	
	# * Méthode d'instance permettant d'arrêter commplètement le chronomètre
	# * Retourne *self*
	def arretChronometre()
		@finChronometre = Time.now - @debutChronometre
		@tourne = false
		@fini = true
		return self
	end

	# * Méthode d'instance permettant de mettre en pause le chronomètre
	# * Retourne +self+
	def mettreEnPauseChronometre()
		@pause = Time.now
		@tourne = false
		return self
	end

	# * Méthode d'instance permettant la reprise du chronomètre après une pause
	# * Retourne *self*
	def repriseChronometre()
		@debutChronometre += Time.now - @pause
		@tourne = true
	end

	# * Méthode permettant de renvoyer le temps actuel de la partie en seconde
	# * Retourne un entier représentant le nombre de secondes écoulées durant la *Partie*
	def getTemps()
		if(@tourne)
			tempsActuel = Time.now - @debutChronometre
			return tempsActuel.to_i
		end
        	
		if(@fini)
			return @finChronometre.to_i
		end
        	
		tempsActuel = @pause - @debutChronometre
		return tempsActuel.to_i
	end

	# * Méthode permettant de renvoyer le temps actuel de la partie en chaine de caractère pour l'affichage
	# * Si la *Grille* de la *Partie* n'est pas une <b>GrilleHardcore</b>, l'affichage est de la forme ##:##
	# * Si la *Grille* de la *Partie* est une <b>GrilleHardcore</b>, l'affichage est de la forme ##:##/##:##
	# * Retourne un *String* représentant le temps de la *Partie*
	def getTempsString()
		unTemps = self.getTemps
		minute = sprintf("%02i", (unTemps % 3600) / 60)
		seconde = sprintf("%02i", unTemps % 60)
		if @grille.difficulte < 8	# Grille non-hardcore
			return "#{minute}:#{seconde}"
		else
			unTempsMax = @grille.tempsMax
			minuteMax = sprintf("%02i", (unTempsMax % 3600) / 60)
			secondeMax = sprintf("%02i", unTempsMax % 60)
			return "#{minute}:#{seconde}/#{minuteMax}:#{secondeMax}"
		end
	end
	
	# * Méthode d'instance qui permet de jouer usr la +Grille+
	# * === Attributs :
	#		- unX : un entier représentant l'abscisse de la Case
	#		- unY : un entier représentant l'ordonnée de la Case
	# * Retourne un entier représentant le nombre de clics de la *Partie*
	def jouer(unX, unY)
		if @grille.matriceDepart[unX][unY].estVide?
			if @grille.matrice[unX][unY].estVide?
				@mouvementsArriere.push("@grille.jouer(#{unX},#{unY}, \"v\")")
				@grille.jouer(unX, unY, "r")
			elsif @grille.matrice[unX][unY].estRouge?
				@mouvementsArriere.push("@grille.jouer(#{unX},#{unY}, \"r\")")
				@grille.jouer(unX, unY, "b")
			else #elsif @grille.matrice[unX][unY].estBleu?
				@mouvementsArriere.push("@grille.jouer(#{unX},#{unY}, \"b\")")
				@grille.jouer(unX, unY, "v")
			end
			@nbClics += 1
		end
		return @nbClics
	end
	
	# * Méthode d'instance qui permet de savoir si la *Partie* peut continuer en fonction de son temps
	# * Retourne *true* si elle peut continuer, *false* sinon
	def verifierTempsMax?
		unResultat = true
		if @grille.difficulte >= 8 && getTemps > @grille.tempsMax
			unResultat = false
		end
		return unResultat
	end
	
	# * Méthode d'instance qui permet de savoir si la *Partie* peut continuer en fonction de son nombre de clics
	# * Retourne *true* si elle peut continuer, *false* sinon
	def verifierNbClicsMax?
		unResultat = true
		if @grille.difficulte >= 8 && @nbClics > @grille.nbClicsMax
			unResultat = false
		end
		return unResultat
	end
	
	# * Méthode d'instance qui "termine" la *Partie*
	# * Retourne *self*
	def gagner
	
		# On ne met à jour la BDD que si le score est meilleur
		unScore = calculerScore()
		if unScore > Compte.COMPTE.scorePourLaGrille(@grille)
			BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, 0, @nbHypotheses, @nbAides, unScore)
		end
		return self
	end
	
	# * Méthode d'instance qui renvoie un String représentant le nombre de clics de la *Partie*
	# * Retourne un *String* décrivant le nombre de clics de la *Partie*
	def nbClicsString
		if @grille.difficulte < 8	# Grille non-hardcore
			return @nbClics.to_s
		else
			return @nbClics.to_s + "/" + @grille.nbClicsMax.to_s
		end
	end
	
	# * Méthode d'instance qui joue un coup en arrière
	# * Retourne *self*
	def	retourArriere
		if peutRetourArriere?
			eval(@mouvementsArriere.pop)
		end
		return self
	end
	
	# * Méthode d'instance qui indique si on peut jouer en arrière
	# * Retourne +true+ si on peut jouer en arrière, +false+ sinon
	def peutRetourArriere?
		return !@mouvementsArriere.empty?
	end
	
	# * Méthode d'instance qui sauvegarde la *Partie* dans la BDD
	# * return *self*
	def sauvegarder
		#self.mettreEnPauseChronometre		# Normalement, le chrono doit déjà être en pause quand cette méthode est appelée
		if Compte.COMPTE.aUneSauvegarde?
			Compte.COMPTE.supprimeSauvegarde()	# Une seule sauvegarde dans la BDD
		end
		BaseDeDonnees.setSauvegarde(Compte.COMPTE.pseudo, self.getTemps, @nbClics, @nbHypotheses, @nbAides, @grille.idGrille, @grille.matrice)
		return self
	end
	
	# * Méthode d'instance qui remet à zéro la *Partie*
	# * Retourne *self*
	def remiseAZero
		@nbHypotheses = 0
		@nbAides = 0
		@nbClics = 0
		if @grille.difficulte >= 8
			@grille = GrilleHardcore.creer(@grille.idGrille)
		else
			@grille = Grille.creer(@grille.idGrille)
		end
		@tempsSauvegarde = 0
		@fini = false
		@listeHypotheses = Array.[]
		@tourne = false
		@debutChronometre = nil
		@mouvementsArriere = []
		return self
	end
end
	

