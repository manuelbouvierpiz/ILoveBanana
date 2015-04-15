# encoding: UTF-8

##
# Auteur Alexandre Moutel, Parmenon Damien (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'

class ClassementBuilder < TakuzuBuilder

	def initialize
		super(__FILE__, "Classement")
		
		tabNiveau = [1, 2, 3, 4, 5, 6, 7]
		tabNiveau.each_with_index do |e|
  			iter = @listeNiveaux.append
  			iter[0] = e
		end
		@combobox1.model=@listeNiveaux

		tabTaille = [6, 8, 10, 12]
		tabTaille.each_with_index do |e|
  			iter = @listeTaille.append
  			iter[0] = e
		end
		@combobox2.model=@listeTaille
    end

    def on_button2_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end

    def on_button3_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end
    Gtk.init
    ClassementBuilder.new
    Gtk.main

end
