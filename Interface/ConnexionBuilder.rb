# encoding: UTF-8

##
# Auteur VALENTIN CHAILLOU
# Version 0.1 : Date : Fri Apr 03 13:54:21 CEST 2015
#
require 'gtk2'

#load 'Compte.rb'
load 'TakuzuBuilder.rb'
load 'OptionsBuilder.rb'

class ConnexionBuilder < TakuzuBuilder

    def initialize 
		super(__FILE__, "Connexion")
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
		ouvrirFenetre(OptionsBuilder.new())
    end

    Gtk.init
    builder = ConnexionBuilder.new()
    Gtk.main
    
end
