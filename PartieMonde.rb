# Alexandre MOUTEL
# Modifications par Valentin CHAILLOU et Ronan YZEUX
# PartieMonde.rb
# Implementation de la classe PartieMonde

# == Classe PartieMonde 
#	- connait son état
#	- sait rendre la partie accessible (debloquer), si elle est bloque (estDebloque?), donner le nombre d'étoile(s) en fonction du score(nbEtoile), connaitre le score d'un joueur(scoreDuJoueur), réinitialiser la grille de la partie(initGrille)
class PartieMonde < Partie

	#Variables
	@etat
	
	#Méthodes d'instance

	# Méthode d'instance qui permet de donner l'accès à une partie dans un monde
	def debloquer()	
		if(@etat == false)
			@etat = true
		end
	end

	# Méthode d'instance qui permet de savoir si la +Partie+ est accessible
	def estDebloque?()
		if(@etat)
			return true
		else
			return false
		end
	end

	# * Méthode d'instance qui retourne un nombre d'étoiles gagnées lors de la +PartieMonde+
	def nbEtoile()
		return BaseDeDonnees.getNbEtoileObtenu(Compte.COMPTE.pseudo, @grille.idGrille)
	end
	
	# * Méthode d'instance qui arrête la +PartieDidacticiel+
	def arreteToi
		super()
		mettreEnPauseChronometre()
	end

	# * Méthode d'instance qui "termine" la +Partie+
	# * Retourne +self+
	def gagner
		# On ne met à jour la BDD que si le score est meilleur
		unScore = calculerScore()
		if unScore > Compte.COMPTE.scorePourLaGrille(@grille)
			unNbEtoile = 0
		
			if unScore >= BaseDeDonnees.getGrilleEtoileTroisScore(@grille.idGrille)
				unNbEtoile = 3
			elsif unScore >= BaseDeDonnees.getGrilleEtoileDeuxScore(@grille.idGrille)
				unNbEtoile = 2
			elsif unScore >= BaseDeDonnees.getGrilleEtoileUnScore(@grille.idGrille)
				unNbEtoile = 1
			end
	
			BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, unNbEtoile, @nbHypotheses, @nbAides, unScore)
		end
		return super()
	end

	def initialiseEtat
		numNiveau = BaseDeDonnees.getNumeroNiveau(@grille.idGrille)
		if(@grille.difficulte == 1 && numNiveau == 1)
			@etat = true
		else
			dernierMondeNiveau = BaseDeDonnees.dernierNiveauFini(Compte.COMPTE.pseudo)
			if(dernierMondeNiveau != -1)
				if(dernierMondeNiveau[1] == 40)
					dernierNiveauAccessible = 1
					dernierMondeAccessible = dernierMondeNiveau[0] + 1
				else
					dernierNiveauAccessible = dernierMondeNiveau[1] + 1
					dernierMondeAccessible = dernierMondeNiveau[0]
				end
				if((@grille.difficulte < dernierMondeAccessible))
					@etat = true
				else
					if((@grille.difficulte == dernierMondeAccessible) && (numNiveau <= dernierNiveauAccessible))
						@etat = true
					else
						@etat = false	
					end
				end
			else
				@etat = false
			end
		end
		return @etat
	end
	
end
