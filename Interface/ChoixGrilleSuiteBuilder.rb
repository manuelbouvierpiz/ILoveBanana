#JOUSSE Wilfried

# encoding: UTF-8


# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class ChoixGrilleSuiteBuilder < TakuzuBuilder

    #A bessoin de Monde.rb
    
    @monde #Monde actuel

     def initialize(monde)
      super(__FILE__,"Choix de la Grille")   
      @monde=monde
      @NomMonde.set_text(@monde.nom)
    end
 def on_niveauBouton_clicked w
      i=w.label.to_i
      #Recupere la taille de la grille pour ensuite lancer la bonne interface
      t=@monde.tableauParties[i].@grille.taille

      case t
      when t=6
        ouvriFenetre(Partie_6Builder.new)
      when t=8
        ouvriFenetre(Partie_8Builder.new)
      when t=10
        ouvriFenetre(Partie_10Builder.new)
      when t=12
        ouvriFenetre(Partie_12Builder.new)
      end
    
    end

    def on_precendentBouton_clicked
      ouvriFenetrePrecedente()
    end
  
end
