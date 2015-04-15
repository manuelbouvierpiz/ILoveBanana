# encoding: UTF-8

##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class SuccesBuilder < TakuzuBuilder

def initialize
		super(__FILE__, "Succès")
		#Affichage des succès ici
    end

    def on_buttonClassement_clicked
    	ouvrirFenetre(ClassementBuilder.new)
    end

    def on_buttonStatistiques_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end
end
