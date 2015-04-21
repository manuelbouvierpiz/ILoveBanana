#JOUSSE Wilfried, Modifié par PARMENON Damien

# encoding: UTF-8

require 'gtk2'

class ChoixGrilleBuilder < TakuzuBuilder
    
    @monde #Monde actuel

    def ChoixGrilleBuilder.creer(unMonde)
      new(unMonde)
    end

    def initialize(unMonde)
      super(__FILE__,"Choix de la grille")   
      @monde = unMonde
      @nomMonde.set_text(@monde.nom)
      if(@monde.idMonde == 8)
        @button21.set_visible(false)
        @label1.set_text("Page 1/1")
      end
    end

    def on_niveauBouton_clicked unLabel
      i=unLabel.label.to_i - 1
      laPartie = @monde.tableauParties[i]
      ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
   end

    def on_suivantBouton_clicked
      ouvrirFenetre(ChoixGrilleSuiteBuilder.new(@monde))
    end

    def on_retourBouton_clicked
      ouvrirFenetre(ChoixMondeBuilder.new)
    end
  
end
