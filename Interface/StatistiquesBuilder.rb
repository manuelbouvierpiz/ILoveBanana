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

	def initialize
		super(__FILE__, "statistiques")
		@labelTempsJeu.set_text("Temps passé en jeu :" + "")#fonction permettant d'obtenir ce temps
		@labelPetitClic.set_text("Plus petit nombre de clics :" + "")#idem
		@labelGrandClic.set_text("Plus grand nombre de clics :" + "")#idem
		#Ajouter d'autres statistiques ici et dans le glade si besoin
    end

    def on_buttonClassement_clicked
    	ouvrirFenetreNonFermante(ClassementBuilder.new)
    end

    def on_buttonSucces_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end
end
