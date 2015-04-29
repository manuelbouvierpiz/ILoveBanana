# encoding: UTF-8

##
# Auteur Damien Parmenon et Valentin CHAILLOU
# Version 0.1 : Date : Fri Apr 03 17:52:21 CEST 2015
#

# == Classe OubliMotDePasseBuilder :
#		- est un TakuzuBuilder
class OubliMotDePasseBuilder < TakuzuBuilder

	# Méthodes d'instance
	
	# Méthode d'instance qui initialise le OubliMotDePasseBuilder
    def initialize	# :nodoc:
		super(__FILE__, "Mot de passe oublié")
    end

	# * Méthode d'instance qui ouvre la fenêtre de *ConnexionBuilder*
	# * Est automatiquement appelée par Gtk
    def on_buttonRetour_clicked
    	ouvrirFenetre(ConnexionBuilder.new)
    end

	# * Méthode d'instance qui vérifie les informations et demande à *Compte* d'envoyer un mail
	# * Est automatiquement appelée par Gtk
    def on_buttonValider_clicked
    	if @entryMail.text != "" && @entryPseudo.text != ""
    		if Compte.verifierAdressePseudo?(@entryPseudo.text, @entryMail.text)
				Compte.recuperer(@entryMail.text, @entryPseudo.text)
        		@labelReussite.set_text("Un mail a été envoyé à " + @entryMail.text)
        		@buttonValider.set_visible(false)
       		else
        		@labelReussite.set_text("Informations incorrectes")
        	end
        else
        	@labelReussite.set_text("Tous les champs ne sont pas remplis")
        end
    end
end
