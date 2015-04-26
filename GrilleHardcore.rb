# Valentin CHAILLOU
# GrilleHardcore.rb
# 27/02/2015

# == Classe GrilleHardcore :
#		- est une Grille
#		- connaît son temps max et son nombrede clics max
#		- sait donner sa difficulté
class GrilleHardcore < Grille

	# Variables
	
	# * Variable d'instance représentant le temps maximum autorisé pour une *Partie* sur cette +GrilleHardcore+
	# * Accessible en lecture uniquement
	# * Est intialisée lors de la création de la *GrilleHardcore*
	attr :tempsMax, false
	
	# * Variable d'instance représentant le nombre maximum de clics autorisés sur cette *GrilleHardcore*
	# * Accessible en lecture uniquement
	# * Est initialisée lors de la création de la *GrilleHardcore*
	attr :nbClicsMax, false
	
	# Méthodes d'instance
	
	# Méthode d'instance qui initialise le temps maximum et le nombre maximum de clics associés à la *GrilleHardcore*
	def initialize(unIdGrille, uneMatrice)	# :nodoc
		super(unIdGrille, uneMatrice)
		@tempsMax = BaseDeDonnees.getGrilleTempsMax(@idGrille)
		@nbClicsMax = BaseDeDonnees.getGrilleNbClicsMax(@idGrille)
	end
	
	# * Méthode d'instance qui renvoie la difficulté de la *GrilleHardcore*
	# * Retourne 8
	def difficulte
		#super()	=> Trop lent (il y un accès inutile à la BDD dans le super)
		return 8
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères représentant le temps max de la *GrilleHardcore*
	# * Retourne un *String* de la forme "/##::##"
	def getTempsMaxString
		minuteMax = sprintf("%02i", (@tempsMax % 3600) / 60)
		secondeMax = sprintf("%02i", @tempsMax % 60)
		return super() + "/#{minuteMax}:#{secondeMax}"
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères représentant le nombre max de clics de la *GrilleHardcore*
	# * Retourne un *String* de la forme "/##"
	def nbClicsMaxString
		return super() + "/#{@nbClicsMax}"
	end
	
	# * Méthode d'instance qui permet de vérifier que le nombre de clics max de la *GrilleHardcore* n'est pas atteint
	# * === Attribut :
	#		- unNbClics : un entier représentant le nombre de clics de la *Partie*
	# * Retourne *true* si le nombre de clics est inférieur au nombre de clics max de la <b>GrilleHardcore</b>, *false* sinon
	def verifierNbClicsMax?(unNbClics)
		super(unNbClics)
		return unNbClics < @nbClicsMax
	end
	
	# * Méthode d'instance qui permet de vérifier que le temps max de la *GrilleHardcore* n'est pas atteint
	# * === Attribut :
	#		- unTemps : le temps de la *Partie*
	# * Retourne *true* si le temps est inférieur au temps max de la <b>GrilleHardcore</b>, *false* sinon
	def verifierTempsMax?(unTemps)
		super(unTemps)
		return unTemps < @tempsMax
	end

end
