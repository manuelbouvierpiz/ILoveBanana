#JOUSSE Wilfried, modifié par Parmenon Damien

# encoding: UTF-8


class ChoixGrilleSuiteBuilder < TakuzuBuilder
    
  @monde

  def ChoixGrilleBuilder.creer(unMonde)
    new(unMonde)
  end

  def initialize(unMonde)
    super(__FILE__,"Choix de la Grille")   
    @monde=unMonde
    @nomMonde.set_text(@monde.nom)
    20.upto(39) do |i|
        @monde.tableauParties[i].initialiseEtat
    end
     @button1.set_sensitive(false) if(!@monde.tableauParties[20].estDebloque?)
     @button2.set_sensitive(false) if(!@monde.tableauParties[21].estDebloque?)
     @button3.set_sensitive(false) if(!@monde.tableauParties[22].estDebloque?)
     @button4.set_sensitive(false) if(!@monde.tableauParties[23].estDebloque?)
     @button5.set_sensitive(false) if(!@monde.tableauParties[24].estDebloque?)
     @button6.set_sensitive(false) if(!@monde.tableauParties[25].estDebloque?)
     @button7.set_sensitive(false) if(!@monde.tableauParties[26].estDebloque?)
     @button8.set_sensitive(false) if(!@monde.tableauParties[27].estDebloque?)
     @button9.set_sensitive(false) if(!@monde.tableauParties[28].estDebloque?)
     @button10.set_sensitive(false) if(!@monde.tableauParties[29].estDebloque?)
     @button11.set_sensitive(false) if(!@monde.tableauParties[30].estDebloque?)
     @button12.set_sensitive(false) if(!@monde.tableauParties[31].estDebloque?)
     @button13.set_sensitive(false) if(!@monde.tableauParties[32].estDebloque?)
     @button14.set_sensitive(false) if(!@monde.tableauParties[33].estDebloque?)
     @button15.set_sensitive(false) if(!@monde.tableauParties[34].estDebloque?)
     @button16.set_sensitive(false) if(!@monde.tableauParties[35].estDebloque?)
     @button17.set_sensitive(false) if(!@monde.tableauParties[36].estDebloque?)
     @button18.set_sensitive(false) if(!@monde.tableauParties[37].estDebloque?)
     @button19.set_sensitive(false) if(!@monde.tableauParties[38].estDebloque?)
     @button20.set_sensitive(false) if(!@monde.tableauParties[39].estDebloque?)
  end

  def on_niveauBouton_clicked unLabel
    i=unLabel.label.to_i - 1
    laPartie = @monde.tableauParties[i]
    ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
  end

  def on_precedentBouton_clicked
    ouvrirFenetre(ChoixGrilleBuilder.creer(@monde))
  end
  
  def on_retourBouton_clicked
      ouvrirFenetre(ChoixMondeBuilder.new)
    end
end
