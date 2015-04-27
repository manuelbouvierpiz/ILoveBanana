# Damien PARMENON

# == Classe PartieDidacticiel :
#		- est une Partie
#		- sait s'arrêter
class PartieDidacticiel < Partie 
	
	# * Méthode d'instance qui arrête la *PartieDidacticiel*
	# * Retourne *self*
	def arreteToi
		super()
		mettreEnPauseChronometre()
		return self
	end
	
end
