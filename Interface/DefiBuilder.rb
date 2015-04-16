# encoding: UTF-8

##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

load 'Interface/TakuzuBuilder.rb'

class DefiBuilder < TakuzuBuilder
    def initialize
        super(__FILE__, "Defi")
    end
    
    def on_validerButton_clicked
		#chercher le personne defi ( labelPseudo )
		
		#ouvrir le fenetre de defi
	end

	def on_annulerButton_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new())
	end

	def DefiBuilder.lancer
		Gtk.init
		DefiBuilder.new()
		Gtk.main
    	end
end
