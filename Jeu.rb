# == Classe Jeu :
#		- connaît le Didactitiel ,l'Aventure et les Parties
class Jeu
	
	# * Variable de classe qui représente l'unique *Jeu* en cours
	# * Accessible en lecture via la méthode Jeu.JEU
	@@JEU

	# * Variable d'instance représentant le *Didactitiel*
	# * Accessible en lecture uniquement
	# * Est intialisée lors de la création de *Jeu*
	attr :didacticiel, false
	
	# * Variable d'instance représentant l' *Aventure*
	# * Accessible en lecture uniquement
	# * Est intialisée lors de la création de *Jeu*
	attr :aventure, false
	
	# * Variable d'instance représentant les *Partie*
	# * Accessible en lecture et en eciture
	attr :partie, true

	# Méthodes de classe
	
	private_class_method :new
	
	# * Méthode de classe qui permet d'accéder au *Jeu* en lecture
	# * Retourne la variable de classe JEU
	def Jeu.JEU
		return @@JEU
	end
	
	# Méthode d'instance

	# Méthode d'instance qui initialise l'*Aventure* et le *Didactitiel*
	def initialize()	# :nodoc
		@aventure = Aventure.new
		@didacticiel = Didacticiel.new
	end
	
	# Création du JEU
	@@JEU = new
	
end