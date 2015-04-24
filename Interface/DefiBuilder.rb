# encoding: UTF-8

##
# Auteur : Kuang Nanzhem, Parmenon Damien
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

class DefiBuilder < TakuzuBuilder
	
	attr :IdGrille , false
	
	attr :score , false
	
    def DefiBuilder.creer(unIdGrille,unScore)
    	new(unIdGrille,unScore)
    end

    def initialize(unIdGrille, unScore)
        super(__FILE__)
        @IdGrille = unIdGrille
    	@score = unScore
    end
    
    def on_validerButton_clicked
      if(@pseudo.text == Compte.COMPTE.pseudo)
        fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                      Gtk::MessageDialog::INFO,
                      Gtk::MessageDialog::BUTTONS_CLOSE,
                      "Pseudo incorrect.")
        fenetreInfo.run
        fenetreInfo.destroy
      else  
		    leDefi = Defi.creer(@pseudo.text, Compte.COMPTE.pseudo, @IdGrille, @score)
        if(leDefi.envoyerDefi != -1)
		      fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                        Gtk::MessageDialog::INFO,
                        Gtk::MessageDialog::BUTTONS_CLOSE,
                        "Le défi a bien été envoyé, vous allez être redirigé vers le menu principal.")
    		  fenetreInfo.run
    		  fenetreInfo.destroy
   		    ouvrirFenetre(MenuPrincipalBuilder.new())
        else
          fenetreInfo = Gtk::MessageDialog.new(self['window1'], Gtk::Dialog::DESTROY_WITH_PARENT,
                        Gtk::MessageDialog::INFO,
                        Gtk::MessageDialog::BUTTONS_CLOSE,
                        "Pseudo incorrect.")
          fenetreInfo.run
          fenetreInfo.destroy
        end
      end
	  end
	
	#Methode de classe qui fermer le defi
	def on_annulerButton_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new())
	end

end
