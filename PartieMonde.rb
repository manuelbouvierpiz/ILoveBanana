# Alexandre MOUTEL
# Modifications par Valentin CHAILLOU et Ronan YZEUX
# PartieMonde.rb
# Implementation de la classe PartieMonde

# == Classe PartieMonde 
#	- connait son état
#	- sait rendre la partie accessible (debloquer), si elle est bloquée (estDebloque?), donner le nombre d'étoile(s) en fonction du score(nbEtoile), connaitre le score d'un joueur(scoreDuJoueur), réinitialiser la grille de la partie(initGrille)
class PartieMonde < Partie

	# Variables
	
	# * Variable d'instance (un booléen) non accessible représentant l'état de la *PartieMonde*
	@etat
	
	attr_writer :etat
	
	# Méthodes d'instance

	# * Méthode d'instance qui permet de donner l'accès à la *PartieMonde*
	# * Retourne *self*
	def debloquer()	
		if(@etat == false)
			@etat = true
		end
		return self
	end

	# * Méthode d'instance qui permet de savoir si la *PartieMonde* est accessible
	# * Retourne *true* si elle est accessible, sinon *false*
	def estDebloque?()
		if(@etat)
			return true
		else
			return false
		end
	end

	# * Méthode d'instance qui retourne le nombre d'étoile(s) gagnées pour cette *PartieMonde*
	# * *ATTENTION* : le nombre d'étoiles est juste retourné, pas calculé (il est calculé dans la méthode gagner)
	# * Retourne un entier représentant le nombre d'étoile(s) gagnées pour cette *PartieMonde*
	def nbEtoile()
		return BaseDeDonnees.getNbEtoileObtenu(Compte.COMPTE.pseudo, @grille.idGrille)
	end
	
	# * Méthode d'instance qui arrête la *PartieMonde*
	# * Retourne *self*
	def arreteToi
		super()
		mettreEnPauseChronometre()
		return self
	end

	# * Méthode d'instance qui "termine" la *PartieMonde*
	# * Met à jour la base de données
	# * Retourne *self*
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

	# * Méthode d'instance qui initialise l'état (bloqué/débloqué) de la *PartieMonde*
	# * Retourne un booléen représentant l'état de la *PartieMonde* (<b>true</b> ou <b>false</b>)
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
