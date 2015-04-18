# encoding: UTF-8

##
# Auteur Alexandre Moutel (glade), Parmenon Damien (code ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class MenuPrincipalBuilder < TakuzuBuilder

	def initialize 
        super(__FILE__, "Menu Principal")
	end

	def on_partieRapideButton_clicked
		ouvrirFenetre(TailleDifficulteBuilder.new)
	end

	def on_aventureButton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
	
	def on_didacticielButton_clicked
		ouvrirFenetre(PartieBuilder.new())
	end
	
	def on_optionButton_clicked
		ouvrirFenetre(OptionsBuilder.new)
	end
	
	def on_statistiquesButton_clicked
		Compte.COMPTE.succes.verifierTousLesSucces()
		ouvrirFenetre(StatistiquesBuilder.new)
	end
	
	def on_aProposButton_clicked
		ouvrirFenetre(AProposBuilder.new)
	end
	
	def on_retourButton_clicked
		ouvrirFenetre(ConnexionBuilder.new)
	end
	
	def on_quitterButton_clicked
		Gtk.main_quit
	end
end
