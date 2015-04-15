# encoding: UTF-8

##
# Auteur VALENTIN CHAILLOU
# Version 0.1 : Date : Fri Apr 03 13:54:21 CEST 2015
#
require 'gtk2'

load 'Compte.rb'
load 'Interface/TakuzuBuilder.rb'
load 'Interface/OptionsBuilder.rb'

# == Classe +ConnexionBuilder+ :
#	- sait connecter un utilisateur et créer un +Compte+
class ConnexionBuilder < TakuzuBuilder

    def initialize	# :nodoc:
		super(__FILE__, "Connexion")
    end

	# * Méthode d'instance qui permet de connecter un utilisateur après avoir cliqué sur le bouton de connexion
	# * Est automatiquement appelée par Gtk
    def on_connexionButton_clicked
		if Compte.verifierMotDePasse?(@loginEntry, @mdpEntry)
        	Compte.login(@loginEntry, @mdpEntry)
            ouvrirFenetre(MenuPrincipal.new())
        else
            @erreurLabel.set_text("Identifiants incorrects")
        end
    end

	# * Méthode d'instance qui permet de créer un compte après avoir cliqué sur le bouton de création d'un compte
	# * Est automatiquement appelée par Gtk
    def on_creationBouton_clicked
		if Compte.verifierIdentifiant?(@loginEntry)
        	Compte.creer(@loginEntry, @mdpEntry, "takuzuavengers@gmail.com")	# Mail à changer
        	Compte.login(@loginEntry, @mdpEntry)
            ouvrirFenetre(MenuPrincipal.new())
        else
            @erreurLabel.set_text("Identifiants incorrects")
        end
    end

	# Méthode de classe

	# * Méthode de classe qui lance l'interface graphique
	# * Est appelée depuis +Jeu.rb+
	def ConnexionBuilder.lancer
		Gtk.init
		ConnexionBuilder.new()
		Gtk.main
    end
    
end
