# encoding: UTF-8

##
# Auteur Alexandre Moutel, Damien Parmenon (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'
load 'Interface/ClassementBuilder.rb'
load 'Interface/SuccesBuilder.rb'

class StatistiquesBuilder < TakuzuBuilder

    @boolTaille

	def initialize
		super(__FILE__, "Statistiques")
		@labelTempsJeu.set_text("Temps passé en jeu :" + "#{Compte.COMPTE.tempsTotalJeu}")
		@labelPetitClic.set_text("Plus petit nombre de clics :" + "#{Compte.COMPTE.plusPetitNombreClic}")
		@labelGrandClic.set_text("Plus grand nombre de clics :" + "#{Compte.COMPTE.plusGrandNombreClic}")

        tabNiveau = [1, 2, 3, 4, 5, 6, 7]
        tabNiveau.each_with_index do |e|
            iter = @listeNiveaux.append
            iter[0] = e
        end
        @boxNiveau.model=@listeNiveaux

        tabTaille = [6, 8, 10, 12]
        tabTaille.each_with_index do |e|
            iter = @listeTaille.append
            iter[0] = e
        end
        @boxTaille.model=@listeTaille
		
    end

    def on_buttonClassement_clicked
    	ouvrirFenetre(ClassementBuilder.new)
    end

    def on_buttonSucces_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end

    def on_buttonMenuPrincipal_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new)
    end

    def on_boxNiveau_changed
        @boolNiveau = true
        print @boxNiveau.active_text
        if(@boolTaille == true)
            @labelResultat.set_text("#{Compte.COMPTE.scoreDifficulte(@boxTaille.active_text.to_i, @boxNiveau.active_text.to_i)}")
        end
    end

    def on_boxTaille_changed
        @boolTaille = true
        if(@boolNiveau == true)
            @labelResultat.set_text("#{Compte.COMPTE.scoreDifficulte(@boxTaille.active_text.to_i, @boxNiveau.active_text.to_i)}")
        end
    end
    Gtk.init
    StatistiquesBuilder.new()
    Gtk.main
end
