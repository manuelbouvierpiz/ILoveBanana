# encoding: UTF-8

class Didacticiel 
	@didacticielDeBase
	@didacticielAvance
	
	# Méthode de classe

	# * Méthode de classe qui crée un nouveau didacticiel
	def Didacticiel.creer
		 new
	end
	
	private_class_method :new
	
	# Méthodes d'instance

	def initialize	# :nodoc:
	
		# Les valeurs 5 et  6 sont temporaires et servent juste pour illustrer que l'id des grilles sera connu en avance.
	
		@didacticielDeBase,@didacticielAvance = PartieDidacticiel.creer(5) , PartieDidacticiel.creer(6)
	end

	def estTermine?
		return (@didacticielDeBase.estTermine? && @didacticielAvance.estTermine?)
	end
end
