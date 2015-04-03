load 'Aventure.rb'
load 'Didacticiel.rb'


class Jeu

	@aventure
	@didacticiel
	@partie
	
	# * Variable de classe qui représente l'unique +Jeu+ en cours
	# * Accessible en lecture via la méthode Jeu.JEU
	@@JEU

	# Méthodes de classe
	
	# * Méthode de classe qui crée le jeu
	def Jeu.creer()
		new
	end
	
	private_class_method :new, :creer
	
	# Création du JEU
	@@JEU = creer()
	
	# * Méthode de classe qui permet d'accéder au +JEU+ en lecture
	# * Retourne la variable de classe JEU
	def Jeu.JEU
		return @@JEU
	end
	
	# Méthode d'instance

	def initialize()
		@aventure = Aventure.creer
		@didacticiel = Didacticiel.creer
	end
	
	# * Méthode d'instance qui permet de créer une nouvelle partie libre
	def lancerPartieLibre()
		uneDifficulte = 7
		uneTaille = 12
		@partie = PartieLibre.creer(uneTaille, uneDifficulte)
	end
	
end
