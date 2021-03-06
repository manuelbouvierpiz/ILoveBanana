# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU, Damien PARMENON (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe PartieDidacticielBuilder :
#	- est un PartieBuilder
class PartieDidacticielBuilder < PartieBuilder

	# Variable d'instance

	# * Variable d'instance non accessible qui représente l'étape du didacticiel
	@etape
	
	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super(unePartie)
		
		@image1.set_file("Images/rien.png")
		@meilleurScore.set_text("")
		@etape = 0
		
		on_bouton_clicked(0,0)
	end
	
	# * Méthode d'instance qui permet de modifier l'état d'une *Case*
	# * === Attributs :
	#		- unX : un entier représentant l'abscisse d'une Case
	#		- unY : un entier représentant l'ordonnée d'une Case
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		case @etape
			when 0
  				fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Bienvenue dans le Tutoriel de Takuzu Avengers, le but ici est de vous initier aux règles de ce jeu, la première est: Il ne peut y avoir trois cellules adjacentes de la même couleur. Vous pouvez donc remplir à présent les deux cases blanches.")
  				fenetreInfo.run
  				fenetreInfo.destroy
				@etape = 1
					
				@bouton_3_1.set_style(@styleBoutonAide)
				@bouton_6_1.set_style(@styleBoutonAide)
			when 1
				if((unX == 2 && unY == 0) || (unX == 5 && unY == 0))
					super(unX, unY)
				else
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Remplissez les deux cases blanches à l'aide de la première règle qui est : Il ne peut y avoir trois cellules adjacentes de la même couleur. ")
  					fenetreInfo.run
  					fenetreInfo.destroy
					@etape = 1
					
					@bouton_3_1.set_style(@styleBoutonAide)
					@bouton_6_1.set_style(@styleBoutonAide)
				end

				if(Jeu.JEU.partie.grille.matrice[2][0].estRouge? && Jeu.JEU.partie.grille.matrice[5][0].estRouge?)
					@bouton_1_1.set_style(@styleBoutonAide)
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Félicitations, nous pouvons maintenant passer à la suite, une nouvelle case se colore en blanc, il est possible de déterminer sa couleur à l'aide de la première règle mais également avec la seconde qui est : Les lignes et les colonnes sont constituées du même nombre de cellules des deux couleurs.")
  					fenetreInfo.run
  					fenetreInfo.destroy
  					@etape = 2
  				end
  			when 2
  				if((unX == 0 && unY == 0))
					super(unX, unY)
				else
					@bouton_1_1.set_style(@styleBoutonAide)
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Remplissez la case blanche, il est possible de déterminer sa couleur à l'aide de la première règle mais également avec la seconde qui est : Les lignes et les colonnes sont constituées du même nombre de cellules des deux couleurs.")
  					fenetreInfo.run
  					fenetreInfo.destroy
				end

				if(Jeu.JEU.partie.grille.matrice[0][0].estBleu?)
					@bouton_3_6.set_style(@styleBoutonAide)
					@bouton_6_6.set_style(@styleBoutonAide)
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Et voilà pour les deux premières règles ! Histoire de vérifier si elles sont bien comprises, remplissez les deux prochaines cases blanches.")
  					fenetreInfo.run
  					fenetreInfo.destroy
  					@etape = 3
  				end
  			when 3
  				if((unX == 2 && unY == 5) || (unX == 5 && unY == 5))
					super(unX, unY)
				else
					@bouton_3_6.set_style(@styleBoutonAide)
					@bouton_6_6.set_style(@styleBoutonAide)
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Remplissez les deux cases blanches. \n(indice : la première règle)")
  					fenetreInfo.run
  					fenetreInfo.destroy
				end

				if(Jeu.JEU.partie.grille.matrice[2][5].estRouge? && Jeu.JEU.partie.grille.matrice[5][5].estRouge?)
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Rien de plus facile, il est temps de passer à la dernière règle, Il ne peut y avoir deux lignes ou deux colonnes identiques, vous pouvez donc remplir les deux nouvelles cases blanches en observant la première et dernière colonne.")
  					fenetreInfo.run
  					fenetreInfo.destroy
  					@etape = 4
					@bouton_1_6.set_style(@styleBoutonAide)
					@bouton_2_6.set_style(@styleBoutonAide)
  				end
  			when 4
  				if((unX == 0 && unY == 5) || (unX == 1 && unY == 5))
					super(unX, unY)
				else
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Remplissez les deux cases blanches à l'aide de la dernière règle : Il ne peut y avoir deux lignes ou deux colonnes identiques")
  					fenetreInfo.run
  					fenetreInfo.destroy
					@bouton_1_6.set_style(@styleBoutonAide)
					@bouton_2_6.set_style(@styleBoutonAide)
				end

				if(Jeu.JEU.partie.grille.matrice[0][5].estRouge? && Jeu.JEU.partie.grille.matrice[1][5].estBleu?)
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Et voilà, les trois règles n'ont plus aucun secret pour vous, il reste toutefois un dernier point à éclaircir, vous serez parfois amené à utiliser les hypothèses si aucune règle n'est applicable.\n
                              L'hypothèse est le bouton éponyme en dessous de la grille, il effectue une sauvegarde que vous pourrez récuperer si votre grille s'avère mauvaise en fin de compte, il suffit de cliquer sur l'hypothèse en question à gauche de la grille.\n
                              Il ne vous reste plus qu'à terminer la grille en sachant que le nombre de clics, d'aides, d'hypohèses et le temps influenceront négativement votre score final.")
  					fenetreInfo.run
  					fenetreInfo.destroy
  					@etape = 5
  				end
  			when 5
  				super(unX, unY)
  				if Jeu.JEU.partie.grille.estCorrecte?
					self['window1'].signal_handler_disconnect(@handlerArret)
					Jeu.JEU.partie.arretChronometre()
					fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                              Gtk::MessageDialog::INFO,
                              Gtk::MessageDialog::BUTTONS_CLOSE,
                              "Félicitations, la grille est terminée, vous avez connaissance de toutes les règles et technique dont vous aurez besoin. Bonne chance !")
  					fenetreInfo.run
  					fenetreInfo.destroy
					ouvrirFenetre(PartieDidacticielReussieBuilder.new)
				end
		end
	end

	# * Méthode d'instance qui vérifie le temps de la *PartieDidacticiel*
	# * Cette méthode n'est théoriquement jamais utilisée
	# * Retourne *true* si le temps n'a pas atteint le temps max, *false* sinon
	def verifierTemps?()
		if(super())
			return true
		end
		ouvrirFenetre(PartieEchecBuilder.new)
		return false
	end

	# * Méthode d'instance qui permet d'arrêter la *PartieDidacticiel* et de retourner au menu principal
	# * Est automatiquement appelée par Gtk
	def on_menu_clicked()
		if Jeu.JEU.partie.tourne
			unePartie = Jeu.JEU.partie
			super()		# Jeu.JEU.partie = nil
			unePartie.remiseAZero
		end
	end
end
