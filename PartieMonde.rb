# Alexandre MOUTEL
# Modifications par Valentin CHAILLOU
# PartieMonde.rb
# Implementation de la classe PartieMonde

# == Classe PartieMonde 
#	- connait son id de niveau
#	- rendre la partie accessible (debloquer), savoir si elle est bloque (estDebloque?), connaitre le nombre d'étoile en fonction du score(nbEtoile), connaitre le score d'un joueur(scoreDuJoueur), réinitialiser la grille de la partie(initGrille)
class PartieMonde < Partie

	#Variables
	@idNiveau
	@etat

	#Méthodes

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

	# * Méthode d'instance qui retourne un nombre d'étoile en fonction du score obtenu
	# ===== Attribut :
	#	- unScore : un entier qui représente le score du joueur
	def nbEtoile(unScore)
		unResultat = 0
		
		if unScore > BaseDeDonnees.getGrilleEtoileTroisScore(@grille.idGrille)
			unResultat = 3
		elsif unScore > BaseDeDonnees.getGrilleEtoileDeuxScore(@grille.idGrille)
			unResultat = 2
		elsif unScore > BaseDeDonnees.getGrilleEtoileUnScore(@grille.idGrille)
			unResultat = 1
		end
		
		return unResultat
	end

	#  * Méthode d'instance qui retourne le score d'un joueur sur ce niveau
	def scoreDuJoueur()
		return BaseDeDonnees.getScore(Compte.COMPTE.pseudo, @grille.idGrille)
	end
	
	# * Méthode d'instance qui arrête la +PartieDidacticiel+
	def arreteToi
		super()
		mettreEnPauseChronometre()
	end

end
