#JOUSSE Wilfried, Modifié par PARMENON Damien

# encoding: UTF-8


class ChoixGrilleBuilder < TakuzuBuilder
    
    @monde #Monde actuel

    def ChoixGrilleBuilder.creer(unMonde)
      new(unMonde)
    end
	
	private_class_method :new

    def initialize(unMonde)
      super(__FILE__,"Choix de la grille")   
      @monde = unMonde
      @nomMonde.set_text(@monde.nom)
      if(@monde.idMonde == 8)
        @button21.set_visible(false)
        @label1.set_text("Page 1/1")
      end
      0.upto(19) do |i|
        @monde.partie(i).initialiseEtat
      end
      @button1.set_sensitive(false) if(!@monde.partie(0).estDebloque?)
      @button2.set_sensitive(false) if(!@monde.partie(1).estDebloque?)
      @button3.set_sensitive(false) if(!@monde.partie(2).estDebloque?)
      @button4.set_sensitive(false) if(!@monde.partie(3).estDebloque?)
      @button5.set_sensitive(false) if(!@monde.partie(4).estDebloque?)
      @button6.set_sensitive(false) if(!@monde.partie(5).estDebloque?)
      @button7.set_sensitive(false) if(!@monde.partie(6).estDebloque?)
      @button8.set_sensitive(false) if(!@monde.partie(7).estDebloque?)
      @button9.set_sensitive(false) if(!@monde.partie(8).estDebloque?)
      @button10.set_sensitive(false) if(!@monde.partie(9).estDebloque?)
      @button11.set_sensitive(false) if(!@monde.partie(10).estDebloque?)
      @button12.set_sensitive(false) if(!@monde.partie(11).estDebloque?)
      @button13.set_sensitive(false) if(!@monde.partie(12).estDebloque?)
      @button14.set_sensitive(false) if(!@monde.partie(13).estDebloque?)
      @button15.set_sensitive(false) if(!@monde.partie(14).estDebloque?)
      @button16.set_sensitive(false) if(!@monde.partie(15).estDebloque?)
      @button17.set_sensitive(false) if(!@monde.partie(16).estDebloque?)
      @button18.set_sensitive(false) if(!@monde.partie(17).estDebloque?)
      @button19.set_sensitive(false) if(!@monde.partie(18).estDebloque?)
      @button20.set_sensitive(false) if(!@monde.partie(19).estDebloque?)
    end

    def on_niveauBouton_clicked unLabel
      i=unLabel.label.to_i - 1
      laPartie = @monde.partie(i)
      ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
   end

    def on_suivantBouton_clicked
      ouvrirFenetre(ChoixGrilleSuiteBuilder.creer(@monde))
    end

    def on_retourBouton_clicked
      ouvrirFenetre(ChoixMondeBuilder.new)
    end
  
end
