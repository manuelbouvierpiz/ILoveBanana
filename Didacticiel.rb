# encoding: UTF-8

class Didacticiel 
	attr :didacticielDeBase, false
	attr :didacticielAvance, false
	
	# Méthodes d'instance

	def initialize	# :nodoc:
	
		# Les valeurs 5 et  6 sont temporaires et servent juste pour illustrer que l'id des grilles sera connu en avance.
	
		@didacticielDeBase,@didacticielAvance = PartieDidacticiel.creer(5) , PartieDidacticiel.creer(6)
	end

	def estTermine?
		return (@didacticielDeBase.estTermine? && @didacticielAvance.estTermine?)
	end
end
