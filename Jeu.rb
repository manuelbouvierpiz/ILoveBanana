require 'singleton'

class Jeu
include Singleton

	@compte
	@aventure
	@didactitiel
	@partie

	private_class_method :new

	def Jeu.creer()
		new
	end

	def initialize()
		@compte = Compte.creer
		@aventure = Aventure.creer
		@didactitiel = Didactitiel.creer
		@partie = PartieLibre.creer
	end
	
	

end
