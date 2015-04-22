

class PartieDidacticiel < Partie 
	
	private_class_method :charger
	
	# * Méthode d'instance qui arrête la +PartieDidacticiel+
	def arreteToi
		super()
		mettreEnPauseChronometre()
	end
	
end
