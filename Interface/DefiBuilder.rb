# encoding: UTF-8

##
# Auteur : Group 1
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

load 'Interface/TakuzuBuilder.rb'
load 'Interface/TailleDifficulteBuilder.rb'
load 'Defi.rb'

class DefiBuilder < TakuzuBuilder
    def initialize
        super(__FILE__, "Defi")
    end
    
    	def on_validerButton_clicked
		Defi.creer(labelPseudo,unDestinataire,uneGrille,unScore)
		#ouvrirFenetre(TailleDifficulteBuilder.new)
	end
	
	#Methode de classe qui fermer le defi
	def on_annulerButton_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new())
	end
	
	
	#Méthode de classse
	# * Méthode de classe qui lance l'interface graphique
	def DefiBuilder.lancer
		Gtk.init
		DefiBuilder.new()
		Gtk.main
    	end
end
