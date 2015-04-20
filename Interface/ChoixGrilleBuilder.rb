#JOUSSE Wilfried, Modifié par PARMENON Damien

# encoding: UTF-8

 
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class ChoixGrilleBuilder < TakuzuBuilder
    
    @monde #Monde actuel

    def ChoixGrilleBuilder.creer(unMonde)
      new(unMonde)
    end

    def initialize(unMonde)
      super(__FILE__,"Choix de la grille")   
      @monde = unMonde
      @NomMonde.set_text(@monde.nom)
    end

    def on_niveauBouton_clicked unLabel
      i=unLabel.label.to_i - 1
      laPartie = @monde.tableauParties[i]
      ouvrirFenetre(PartieBuilder.creer(laPartie, @monde))
   end

    def on_suivantBouton_clicked
      ouvrirFenetre(ChoixGrilleSuiteBuilder.new(@monde))
    end

    def on_retourBouton_clicked
      ouvrirFenetre(MenuPrincipalBuilder.new)
    end
  
end
