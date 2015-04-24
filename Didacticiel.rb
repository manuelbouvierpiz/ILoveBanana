# encoding: UTF-8

class Didacticiel 
	attr :didacticielDeBase, false
	
	# Méthodes d'instance

	def initialize	# :nodoc:
	
		# Les valeurs 5 et  6 sont temporaires et servent juste pour illustrer que l'id des grilles sera connu en avance.
	
		@didacticielDeBase= PartieDidacticiel.creer(1009)
	end
end
