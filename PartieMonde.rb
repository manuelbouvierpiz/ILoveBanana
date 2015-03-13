# Alexandre MOUTEL
# PartieMonde.rb
# Implementation de la classe PartieMonde

# == Classe PartieMonde 
#	- connait son id de niveau
#	- rendre la partie accessible (debloquer), savoir si elle est bloque (estDebloque?), connaitre le nombre d'étoile en fonction du score(nbEtoile), connaitre le score d'un joueur(scoreDuJoueur), réinitialiser la grille de la partie(initGrille)

class PartieMonde

	#Variables
	@idNiveau
	@etat

	#Méthodes

	def initialize()

	end

	# Méthode d'instance qui permet de donner l'accès à une partie dans un monde
	def debloquer()	
		if(@etat == false)
			@etat = true
		end
	end

	# Méthode d'instance qui permet de savoir si la Partie est accessible
	def estDebloque?()
		if(@etat)
			return true
		else
			return false
		end
	end

	# Méthode d'instance qui retourne un nombre d'étoile en fonction du score obtenu
	def nbEtoile(score)

	end

	# Méthode d'instance qui retourne le score d'un joueur
	def scoreDuJoueur(joueur)

	end

	# Méthode qui permet de réinitialiser la grille de la partie
	def initGrille()

	end

end
