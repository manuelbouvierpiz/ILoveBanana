

class PartieDidacticiel < Partie 
	
	private_class_method :charger
	
	def estTerminee?()
		@grille.estTerminee?
	end
end
