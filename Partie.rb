# encoding: UTF-8
# PARMENON Damien
# Partie.rb
# Implementation de la classe Partie


# La classe Partie est une méthode abstraite mère de PartieMonde et PartieLibre
class Partie

	# * Grille sur laquelle le joueur va jouer
	@grille
	
	# * Pile des sauvegardes temporaires (ou hypothèses) que le joueur a fait
	@listeHypotheses
	
	# * Variable contenant le nombre de clic que l'utilisateur a fait pour terminer la grille, elle s'incrémente durant la partie.
	@nbClics
	
	# * Variable contenant le nombre de fois que l'utilisateur a utiliser l'aide
	@nbAides
	
	# * Variable contenant le nombre d'hypothèse que l'utilisateur a fait pour terminer la grille
	@nbHypotheses
	
	# * Variable contenant l'heure de début du lancement du chronometre
	@debutChronometre
	
	# * Variable contenant la différence entre l'heure actuelle et le début du chronomètre
	@finChronometre
	
	# * Variable contenant l'heure de début de la pause
	@pause
	
	# * Variable indiquant si le chronomètre est actif ou non
	@tourne
	
	# * Variable indiquant si le chronomètre est fini 
	@fini

	# * Variable d'instance non accessible représentant la pile de mouvements pour le retour arrière
	@mouvementsArriere

	private_class_method :new

	attr_reader :nbClics, :nbAides, :grille


# Constucteur d'une partie 
	def Partie.creer(unIdGrille, estHardcore=false)
			new(unIdGrille, estHardcore)
	end

# Initialise les variables d'instances
	def initialize(unIdGrille, estHardcore=false)
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

# Méthode retournant le score de la partie
	def calculerScore()
		return ((@grille.taille ** 5) * @grille.nbClicMin * ( 1.0 * @grille.difficulte / ( 1.0 * getTemps * @nbClics * 5 ) ) * ( 1 / ( 1 + @nbAides) ) * ( 1 / ( 1 + @nbHypotheses) ) ).to_i
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

# Méthode permettant d'entrer en mode hypothèse
	def faireHypothese()
		if @grille.difficulte < 8
			@listeHypotheses.push(Grille.creer(grille.idGrille, grille.matrice))	# on crée une copie de la Grille (un Clone ne copie pas les attributs en profondeur)
		else
			@listeHypotheses.push(GrilleHardcore.creer(grille.idGrille, grille.matrice))	# on crée une copie de la Grille (un Clone ne copie pas les attributs en profondeur)
		end
		@nbHypotheses += 1
	end

# Méthode permettant de revenir au plus ancien état ou il n'y avait aucune hypothèse
	def chargerPreHypo()
		@grille = @listeHypotheses.pop()
	end

# Méthode permettant de lancer le chronomètre	
	def lanceToi()
		if @debutChronometre == nil
			@debutChronometre = Time.now
			@tourne = true	
		else
			repriseChronometre
		end
	end
	
	# * Méthode d'instance qui arrête la +Partie+
	def arreteToi
		sauvegarder
	end
	
# Méthode permettant de stopper commplètement le chronomètre
	def arretChronometre()
		@finChronometre = Time.now - @debutChronometre
		@tourne = false
		@fini = true
	end

# Méthode permettant de mettre en pause le chronomètre
	def mettreEnPauseChronometre()
		@pause = Time.now
		@tourne = false
	end

# Méthode permettant la reprise du chronomètre après une pause
	def repriseChronometre()
		@debutChronometre += Time.now - @pause
		@tourne = true
	end

# Méthode permettant de renvoyer le temps actuel de la partie en seconde
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

# Méthode permettant de renvoyer le temps actuel de la partie en chaine de caractère pour l'affichage    	
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
		
	# * Méthode d'instance qui permet de savoir si la +Partie+ est terminée
	# * Retourne +true+ si la +Partie+ est terminée, +false+ sinon
	def estTerminee?()
		@grille.estTerminee?
	end
	
	# * Méthode d'instance qui permet de jouer usr la +Grille+
	# ===== Attributs :
	#		- unX : un entier représentant l'abscisse de la Case
	#		- unY : un entier représentant l'ordonnée de la Case
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
	end
	
	# * Méthode d'instance qui permet de savoir si la +Partie+ peut continuer en fonction de son temps
	# * Retourne +true+ si elle peut continuer, +false+ sinon
	def verifierTempsMax?
		unResultat = true
		if @grille.difficulte >= 8 && getTemps > @grille.tempsMax
			unResultat = false
		end
		return unResultat
	end
	
	# * Méthode d'instance qui permet de savoir si la +Partie+ peut continuer en fonction de son nombre de clics
	# * Retourne +true+ si elle peut continuer, +false+ sinon
	def verifierNbClicsMax?
		unResultat = true
		if @grille.difficulte >= 8 && @nbClics > @grille.nbClicsMax
			unResultat = false
		end
		return unResultat
	end
	
	# * Méthode d'instance qui "termine" la +Partie+
	# * Retourne +self+
	def gagner
		BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, 0, @nbHypotheses, @nbAides, calculerScore())
		return self
	end
	
	# * Méthode d'instance qui renvoie un String contenant le nombre de clics de la +Partie+
	# * Retourne un String décrivant le nombre de clics
	def nbClicsString
		if @grille.difficulte < 8	# Grille non-hardcore
			return @nbClics.to_s
		else
			return @nbClics.to_s + "/" + @grille.nbClicsMax.to_s
		end
	end
	
	# * Méthode d'instance qui joue un coup en arrière
	def	retourArriere
		if peutRetourArriere?
			eval(@mouvementsArriere.pop)
		end
	end
	
	# * Méthode d'instance qui indique si on puet jouer en arrière
	# * Retourne +true+ si on peut jouer en arrière, +false+ sinon
	def peutRetourArriere?
		return !@mouvementsArriere.empty?
	end
	
	def sauvegarder
		#self.mettreEnPauseChronometre		# Normalement, le chrono doit déjà être en pause quand cette méthode est appelée
		if Compte.COMPTE.aUneSauvegarde?
			Compte.COMPTE.supprimeSauvegarde()	# Une seule sauvegarde dans la BDD
		end
		BaseDeDonnees.setSauvegarde(Compte.COMPTE.pseudo, self.getTemps, @nbClics, @nbHypotheses, @nbAides, @grille.idGrille, @grille.matrice)
		return self
	end
	
	# * Méthode d'instance qui remet à zéro la +PartieMonde+
	# * Retourne +self+
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
	

