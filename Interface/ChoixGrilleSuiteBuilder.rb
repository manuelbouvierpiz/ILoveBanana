#JOUSSE Wilfried, modifié par Parmenon Damien

# encoding: UTF-8


class ChoixGrilleSuiteBuilder < TakuzuBuilder
    
  @monde

  def ChoixGrilleSuiteBuilder.creer(unMonde)
    new(unMonde)
  end
  
  private_class_method :new

  def initialize(unMonde)
    super(__FILE__,"Choix de la Grille")   
    @monde=unMonde
    @nomMonde.set_text(@monde.nom)
    20.upto(39) do |i|
        @monde.partie(i).initialiseEtat
    end
     @button1.set_sensitive(false) if(!@monde.partie(20).estDebloque?)
     @button2.set_sensitive(false) if(!@monde.partie(21).estDebloque?)
     @button3.set_sensitive(false) if(!@monde.partie(22).estDebloque?)
     @button4.set_sensitive(false) if(!@monde.partie(23).estDebloque?)
     @button5.set_sensitive(false) if(!@monde.partie(24).estDebloque?)
     @button6.set_sensitive(false) if(!@monde.partie(25).estDebloque?)
     @button7.set_sensitive(false) if(!@monde.partie(26).estDebloque?)
     @button8.set_sensitive(false) if(!@monde.partie(27).estDebloque?)
     @button9.set_sensitive(false) if(!@monde.partie(28).estDebloque?)
     @button10.set_sensitive(false) if(!@monde.partie(29).estDebloque?)
     @button11.set_sensitive(false) if(!@monde.partie(30).estDebloque?)
     @button12.set_sensitive(false) if(!@monde.partie(31).estDebloque?)
     @button13.set_sensitive(false) if(!@monde.partie(32).estDebloque?)
     @button14.set_sensitive(false) if(!@monde.partie(33).estDebloque?)
     @button15.set_sensitive(false) if(!@monde.partie(34).estDebloque?)
     @button16.set_sensitive(false) if(!@monde.partie(35).estDebloque?)
     @button17.set_sensitive(false) if(!@monde.partie(36).estDebloque?)
     @button18.set_sensitive(false) if(!@monde.partie(37).estDebloque?)
     @button19.set_sensitive(false) if(!@monde.partie(38).estDebloque?)
     @button20.set_sensitive(false) if(!@monde.partie(39).estDebloque?)
  end

  def on_niveauBouton_clicked unLabel
    i=unLabel.label.to_i - 1
    laPartie = @monde.partie(i)
    ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
  end

  def on_precedentBouton_clicked
    ouvrirFenetre(ChoixGrilleBuilder.creer(@monde))
  end
  
  def on_retourBouton_clicked
      ouvrirFenetre(ChoixMondeBuilder.new)
    end
end
