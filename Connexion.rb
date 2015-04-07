# encoding: UTF-8

##
# Auteur VALENTIN CHAILLOU
# Version 0.1 : Date : Fri Apr 03 13:54:21 CEST 2015
#
require 'gtk2'

#load 'Compte.rb'
load 'TakuzuBuilder.rb'
load 'option.rb'

class ConnexionBuilder < TakuzuBuilder

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
		
		self['window1'].set_title("Hello Ruby")

    end

    def on_connexionButton_clicked
		unPseudo = @loginEntry
		unMotDePasse = @mdpEntry
		#if Compte.verifierMotDePasse?(unPseudo, unMotDePasse)
        #	Compte.login(unPseudo, unMotDePasse)
            # Ouvrir fenetre menu principal
        #else
            @erreurLabel.set_text("Identifiants incorrects")
        #end
    end

    def on_creationBouton_clicked
		@erreurLabel.set_text("Identifiant déjà pris")
		ouvrirFenetre(OptionBuilder.new())
    end

    Gtk.init
    builder = ConnexionBuilder.new()
    Gtk.main
    
end
