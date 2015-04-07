# encoding: UTF-8


# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class Builder < Gtk::Builder

    #A bessoin de Monde.rb
    
    @monde #Monde actuel


    # A mofidier pour avoir le monde (necesite de modifier aussi choix du monde)
    def initialize 
        super()
        self.add_from_file(__FILE__.sub(".rb",".glade"))

        self['window1'].set_window_position Gtk::Window::POS_CENTER
        self['window1'].signal_connect('destroy') { Gtk.main_quit }
        self['window1'].show_all
		# Creation d'une variable d'instance par composant glade
		self.objects.each() { |p|
     		instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
		}
		
		self.connect_signals{ |handler| 
			puts handler
			method(handler) 
		}


   #Met le nom du monde en fonction du monde prit en parametre
   #
   #@NomMonde.set_text(@monde.nom)
    end

    def on_niveauBouton_clicked w
       i=w.label.to_i
       #Recupere la taille de la grille pour ensuite lancer la bonne interface
      # t=@monde.tableauParties[i].@grille.taille

       #
       #A faire
       #
       #Passer sur la page de jeu avec la bonne taille
       #
       #
       #
       #
       #
    
    end
    
    
    def on_precedentBouton_clicked
        #Passe a la fenetre ChoixGrille.glade
    
    end

    def on_retourBouton_clicked
        #Reviens au choix du monde
    end

    Gtk.init
    builder = Builder.new()
    
    Gtk.main
end