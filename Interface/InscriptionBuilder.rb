# encoding: UTF-8

##
# Auteur Damien Parmenon
# Version 0.1 : Date : Fri Apr 03 17:52:21 CEST 2015
#

require 'gtk2'

class InscriptionBuilder < TakuzuBuilder

    def initialize	# :nodoc:
		super(__FILE__, "Inscription")
    end

    def on_buttonRetour_clicked
    	ouvrirFenetre(ConnexionBuilder.new)
    end

    def on_buttonValider_clicked
    	if @entryNom.text != "" && @entryPrenom.text != "" && @entryMail.text != "" && @entryPseudo.text != "" && @entryPassword.text != ""
    		if Compte.verifierIdentifiant?(@entryPseudo.text) 
        		Compte.creer(@entryPseudo.text, @entryPassword.text, @entryMail.text, @entryPrenom.text, @entryNom.text)
        		@labelReussite.set_text("L'incription est bien prise en compte\nVous pouvez vous logguer !")
        		@buttonValider.set_visible(false)
        		@buttonRetour.label = "Se logguer"
       		else
        		@labelReussite.set_text("Le pseudo est déjà pris.")
        	end
        else
        	@labelReussite.set_text("Tout les champs ne sont pas remplis")
        end
    end
end