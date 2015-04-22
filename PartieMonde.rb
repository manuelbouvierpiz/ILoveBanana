# Alexandre MOUTEL
# Modifications par Valentin CHAILLOU et Ronan YZEUX
# PartieMonde.rb
# Implementation de la classe PartieMonde

# == Classe PartieMonde 
#	- connait son id de niveau
#	- rendre la partie accessible (debloquer), savoir si elle est bloque (estDebloque?), connaitre le nombre d'étoile en fonction du score(nbEtoile), connaitre le score d'un joueur(scoreDuJoueur), réinitialiser la grille de la partie(initGrille)
class PartieMonde < Partie

	#Variables
	@idNiveau
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
		super()
		unScore = calculerScore
		
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

	# * Méthode d'instance qui "termine" la +Partie+
	# * Retourne +self+
	def gagner
		BaseDeDonnees.setGrilleTermine(Compte.COMPTE.pseudo, @grille.idGrille, getTemps, @nbClics, nbEtoile, @nbHypotheses, @nbAides, calculerScore())
		return self
	end

	def initialiseEtat
		if(@grille.difficulte == 1 && @idNiveau == 1)
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
				puts @idNiveau
				if((@grille.difficulte <= dernierMondeAccessible) && (@idNiveau <= dernierNiveauAccessible))
					@etat = true
				else
					@etat = false
				end
			else
				@etat = false
			end
		end
		return self
	end
	
	# * Méthode d'instance qui remet à zéro la +PartieMonde+
	# * Retourne +self+
	def remiseAZero
		@nbHypotheses = 0
		@nbAides = 0
		@nbClics = 0
		@idGrille = unIdGrille
		if @grille.difficulte >= 8
			@grille = GrilleHardcore.creer(unIdGrille)
		else
			@grille = Grille.creer(unIdGrille)
		end
		@fini = false
		@listeHypotheses = Array.[]
		@tourne = false
		@debutChronometre = nil
		return self
	end
	
end
