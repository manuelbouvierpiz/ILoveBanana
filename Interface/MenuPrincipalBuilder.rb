# encoding: UTF-8

##
# Auteur Alexandre Moutel (glade), Parmenon Damien (code ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe MenuPrincipalBuilder : 
#	- est un TakuzuBuilder
#   - Permet à l'utilisateur de pouvoir naviguer dans l'application en permettant l'accés aux différentes fonctionnalités de celle-ci
class MenuPrincipalBuilder < TakuzuBuilder

	# Méthodes d'instance

	# * Méthode d'instance qui initialise la fenêtre correspondante au *MenuPrincipalBuilder*
	def initialize 		# :nodoc:
        super(__FILE__)
	end

	# * Méthode d'instance qui ouvre la fenêtre de *TailleDifficulteBuilder* si l'utilisateur clique sur le bouton correspondant afin de lancer une *PartieLibre* (ou partie rapide)
	def on_partieRapideButton_clicked
		lesDefis = BaseDeDonnees.getDefis(Compte.COMPTE.pseudo)
		if(lesDefis.empty?)
			ouvrirFenetre(TailleDifficulteBuilder.new)
		else
			fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                      	  Gtk::MessageDialog::INFO,
                          Gtk::MessageDialog::BUTTONS_YES_NO,
                          "Vous avez un défi en attente de #{lesDefis[0].envoyeur}, souhaitez vous le relever ?")
  			fenetreInfo.run do |reponse|
  				case reponse
  					when Gtk::Dialog::RESPONSE_YES
  						ouvrirFenetre(PartieDefiBuilder.creer(lesDefis[0].relever))
  					when Gtk::Dialog::RESPONSE_NO
  						lesDefis[0].supprimer
  						fenetreInfo.destroy
  				end
  			end
  		end
	end

	# * Méthode d'instance qui ouvre la fenêtre de *ChoixMondeBuilder* (feneêtre de l'aventure) si l'utilisateur clique sur le bouton correspondant
	def on_aventureButton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre correspondant à une partie permettant d'apprendre à jouer (<b>PartieDidacticielBuilder</b>)
	def on_didacticielButton_clicked
		ouvrirFenetre(PartieDidacticielBuilder.creer(Jeu.JEU.didacticiel.didacticielDeBase))
	end
	
	# * Méthode d'instance qui ouvre la fenêtre de *OptionsBuilder* si l'utilisateur clique sur le bouton correspondant
	def on_optionButton_clicked
		ouvrirFenetre(OptionsBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre de *StatistiquesBuilder* si l'utilisateur clique sur le bouton correspondant
	def on_statistiquesButton_clicked
		Compte.COMPTE.succes.verifierTousLesSucces()
		ouvrirFenetre(StatistiquesBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre d'à propos (<b>AProposBuilder</b>) si l'utilisateur clique sur le bouton correspondant
	def on_aProposButton_clicked
		ouvrirFenetreNonFermante(AProposBuilder.new)
	end
	
	# * Méthode d'instance qui ouvre la fenêtre de Connexion (<b>ConnexionBuilder</b>) si l'utilisateur clique sur le bouton correspondant
	def on_retourButton_clicked
		Compte.COMPTE.reinitialiserAventure()
		ouvrirFenetre(ConnexionBuilder.new)
	end
	
	# * Méthode d'instance qui permet de fermer intégralement l'application
	def on_quitterButton_clicked
		Gtk.main_quit
	end
end
