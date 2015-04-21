

class PartieDidacticiel < Partie 
	
	private_class_method :charger
	
	# * Méthode d'instance qui arrête la +PartieDidacticiel+
	def arreteToi
		super()
		mettreEnPauseChronometre()
	end
	
	# * Méthode d'instance qui retourne le nombre d'étoiles gagné lors de la +Partie+
	# * Retourne 0 par défaut
	def nbEtoile()
		super()
		unResultat = -1
	end
	
end
