#JOUSSE Wilfried, modifié par Parmenon Damien

# encoding: UTF-8

require 'gtk2'

class ChoixGrilleSuiteBuilder < TakuzuBuilder
    
  @monde

  def ChoixGrilleBuilder.creer(unMonde)
    new(unMonde)
  end

  def initialize(unMonde)
    super(__FILE__,"Choix de la Grille")   
    @monde=unMonde
    @nomMonde.set_text(@monde.nom)
  end

  def on_niveauBouton_clicked unLabel
    i=unLabel.label.to_i - 1
    laPartie = @monde.tableauParties[i]
    ouvrirFenetre(PartieBuilder.creer(laPartie, @monde))
  end

  def on_precedentBouton_clicked
    ouvrirFenetre(ChoixGrilleBuilder.creer(@monde))
  end
  
  def on_retourBouton_clicked
      ouvrirFenetre(ChoixMondeBuilder.new)
    end
end
