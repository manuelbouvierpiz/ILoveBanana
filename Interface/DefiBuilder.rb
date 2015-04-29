# encoding: UTF-8

##
# Auteur : Kuang Nanzhem, Parmenon Damien
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe DefiBuilder :
#		- est un TakuzuBuilder
class DefiBuilder < TakuzuBuilder

	# Variables d'instance
	
	# * Variable d'instance accessible en lecture (un entier) qui représente l'ID de la *Grille*
	attr :IdGrille , false
	
	# * Variable d'instance accessible en lecture (un entier) qui représente le score du futur *Defi*
	attr :score , false
	
	# Méthode de classe
	
	# * Méthode de classe qui crée un nouveau *DefiBuilder*
	# * === Attributs 
	#		- unIdGrille : un entier qui représente l'unique ID de la Grille du Defi
	#		- unScore : un entier qui représente le score que le joueur a fait sur la Grille
    def DefiBuilder.creer(unIdGrille,unScore)
    	new(unIdGrille,unScore)
    end
	
	# Méthodes d'instance

	# Méthode d'instance qui initialise le DefiBuilder
    def initialize(unIdGrille, unScore)		# :nodoc:
        super(__FILE__)
        @IdGrille = unIdGrille
    	@score = unScore
    end
    
	# * Méthode d'instance qui crée le *Defi*
	# * Est automatiquement appelée par Gtk
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
	
	# * Méthode d'instance qui ouvre la fenêtre du menu principal
	# * Est automatiquement appelée par Gtk
	def on_annulerButton_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new())
	end

end
