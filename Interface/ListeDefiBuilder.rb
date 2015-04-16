# encoding: UTF-8

##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class ListeDefiBuilder < TakuzuBuilder
    def initialize
        super(__FILE__, "Liste des défis")
    end
    
    def on_lancerBouton_clicked
        
    end
    
    def on_supprimerBouton_clicked
        
    end
    
    def on_annulerBouton_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new())
    end
end
