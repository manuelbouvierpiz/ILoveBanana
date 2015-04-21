class Jeu
	
	# * Variable de classe qui représente l'unique +Jeu+ en cours
	# * Accessible en lecture via la méthode Jeu.JEU
	@@JEU

	attr :didacticiel, false
	attr :aventure, false
	attr :partie, true

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
	
	# Création du JEU
	@@JEU = new
	
end