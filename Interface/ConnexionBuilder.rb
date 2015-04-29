# encoding: UTF-8

##
# Auteur VALENTIN CHAILLOU
# Version 0.1 : Date : Fri Apr 03 13:54:21 CEST 2015
#


# == Classe ConnexionBuilder :
#	- est un TakuzuBuilder
#	- sait connecter un utilisateur et créer un Compte
class ConnexionBuilder < TakuzuBuilder

	# Méthodes d'instance

	# Méthode d'instance qui initialise le ConnexionBuilder
    def initialize	# :nodoc:
		super(__FILE__, "Connexion")
		@oubliMotDePasse.hide
		
		self['window1'].signal_connect("key-press-event") do |wdt, key|
			on_connexionButton_clicked if key.keyval == Gdk::Keyval::GDK_Return
		end
    end

	# * Méthode d'instance qui permet de connecter un utilisateur après avoir cliqué sur le bouton de connexion
	# * Est automatiquement appelée par Gtk
    def on_connexionButton_clicked
		if Compte.verifierMotDePasse?(@loginEntry.text, @mdpEntry.text)
        	Compte.login(@loginEntry.text, @mdpEntry.text)
			if Compte.COMPTE.aUneSauvegarde?
				ouvrirFenetre(ChargementSauvegardeBuilder.new())
			else
				ouvrirFenetre(MenuPrincipalBuilder.new())
			end
        else
            @erreurLabel.set_text("Identifiants incorrects")
			@oubliMotDePasse.show
        end
    end

	# * Méthode d'instance qui permet de créer un compte après avoir cliqué sur le bouton de création d'un compte
	# * Est automatiquement appelée par Gtk
    def on_creationBouton_clicked
		ouvrirFenetre(InscriptionBuilder.new)
    end

	# Méthode de classe

	# * Méthode de classe qui lance la fenêtre de *ConnexionBuilder*
	# * Est appelée depuis *TakuzuLanceur*
	def ConnexionBuilder.lancer
		Gtk.init
		ConnexionBuilder.new()
		Gtk.main
    end
	
	# * Méthode d'instance qui ouvre la fenêtre du mot de passe oublié
	# * Est automatiquement appelée par Gtk
	def on_oubliMotDePasse_clicked
		ouvrirFenetre(OubliMotDePasseBuilder.new)
	end
    
end
