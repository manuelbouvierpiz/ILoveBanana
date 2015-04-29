# encoding: UTF-8

# == Classe Didacticiel
#		- connaît le didacticiel de base
class Didacticiel 

	# * Variable d'instance accessible en lecture représentant l'unique *PartieDidacticiel* du *Didacticiel*
	attr :didacticielDeBase, false
	
	# Méthode d'instance

	# Méthode qui initialise l'unique *PartieDidacticiel*
	def initialize	# :nodoc:
		@didacticielDeBase = PartieDidacticiel.creer(1009)
	end
end
