# encoding: UTF-8

##
# Auteur VALENTIN CHAILLOU
# Version 0.1 : Date : Fri Apr 03 13:54:21 CEST 2015
#

require 'gtk2'

# == Classe +ConnexionBuilder+ :
#	- sait connecter un utilisateur et créer un +Compte+
class ConnexionBuilder < TakuzuBuilder

    def initialize	# :nodoc:
		super(__FILE__, "Connexion")
    end

	# * Méthode d'instance qui permet de connecter un utilisateur après avoir cliqué sur le bouton de connexion
	# * Est automatiquement appelée par Gtk
    def on_connexionButton_clicked
		if Compte.verifierMotDePasse?(@loginEntry.text, @mdpEntry.text)
        	Compte.login(@loginEntry.text, @mdpEntry.text)
        	ouvrirFenetre(MenuPrincipalBuilder.new())
        else
            @erreurLabel.set_text("Identifiants incorrects")
        end
    end

	# * Méthode d'instance qui permet de créer un compte après avoir cliqué sur le bouton de création d'un compte
	# * Est automatiquement appelée par Gtk
    def on_creationBouton_clicked
		ouvrirFenetre(InscriptionBuilder.new)
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
