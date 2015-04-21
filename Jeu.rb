class Jeu
	
	# * Variable de classe qui représente l'unique +Jeu+ en cours
	# * Accessible en lecture via la méthode Jeu.JEU
	@@JEU

	attr :didacticiel, false
	attr :aventure, false

	# Méthodes de classe
	
	private_class_method :new
	
	# * Méthode de classe qui permet d'accéder au +JEU+ en lecture
	# * Retourne la variable de classe JEU
	def Jeu.JEU
		return @@JEU
	end
	
	# Méthode d'instance

	def initialize()
		@aventure = Aventure.new
		@didacticiel = Didacticiel.new
	end
	
	# * Méthode d'instance qui permet de créer une nouvelle partie libre
	def lancerPartieLibre()
		uneDifficulte = 7
		uneTaille = 12
		@partie = PartieLibre.creer(uneTaille, uneDifficulte)
	end
	
	# Création du JEU
	@@JEU = new
	
end