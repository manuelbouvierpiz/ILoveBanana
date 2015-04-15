# encoding: UTF-8

##
# Auteur Alexandre Moutel, Parmenon Damien (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'

class ClassementBuilder < TakuzuBuilder

	@boolNiveau
	@boolTaille

	def initialize
		super(__FILE__, "Classement")
		
		tabNiveau = [1, 2, 3, 4, 5, 6, 7]
		tabNiveau.each_with_index do |e|
  			iter = @listeNiveaux.append
  			iter[0] = e
		end
		@boxTaille.model=@listeNiveaux

		tabTaille = [6, 8, 10, 12]
		tabTaille.each_with_index do |e|
  			iter = @listeTaille.append
  			iter[0] = e
		end
		@boxTaille.model=@listeTaille

		@labelRang.set_visible(false)
    	@labelPseudo.set_visible(false)
    	@labelScore.set_visible(false)
    end

    def on_button2_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end

    def on_button3_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end

    def on_boxNiveau_changed
    	@boolNiveau = true
    	if(@boolTaille == true)
    		@labelRang.set_visible(true)
    		@labelPseudo.set_visible(true)
    		@labelScore.set_visible(true)
    		# Remplissage a partir de la BDD des listes
    	end
    end

    def on_boxTaille_changed
    	@boolTaille = true
    	if(@boolNiveau == true)
    		@labelRang.set_visible(true)
    		@labelPseudo.set_visible(true)
    		@labelScore.set_visible(true)
    		# Remplissage a partir de la BDD des listes
    	end
    end

    Gtk.init
    ClassementBuilder.new
    Gtk.main

end
