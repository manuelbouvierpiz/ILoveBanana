

class PartieDidacticiel < Partie 
	
	# * Méthode d'instance qui arrête la *PartieDidacticiel*
	def arreteToi
		super()
		mettreEnPauseChronometre()
	end
	
	# * Méthode d'instance qui "termine" la *PartieDidacticiel*
	# * Retourne *self*
	def gagner
	
		# On ne met pas à jour la BDD pour le didacticiel (car la grille utilisée fait partie de l'aventure)
		return self
	end
	
end
