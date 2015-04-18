# encoding: UTF-8

##
# Auteur Alexandre Moutel, Damien Parmenon (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class SuccesBuilder < TakuzuBuilder

	def initialize
		super(__FILE__, "Succès")
		#Compte.COMPTE.succes.verifierTousLesSucces()
		lesSucces = Compte.COMPTE.succes.succes
		lesSucces.each do |leSucces|
			uneHbox = Gtk::HBox.new(true, nil)
			uneHbox.add(Gtk::Label.new(leSucces.nom,false))
			uneHbox.add(Gtk::Label.new(leSucces.description,false))
			if(leSucces.estDebloque?)
  				uneHbox.add(Gtk::Image.new("Images/SuccesReussi.png"))
            else
                uneHbox.add(Gtk::Label.new("",false))
  			end
			@vboxSucces.add(uneHbox)
            @vboxSucces.add(Gtk::HSeparator.new)
			@vboxSucces.show_all
		end
    end

    def on_buttonClassement_clicked
    	ouvrirFenetre(ClassementBuilder.new)
    end

    def on_buttonStatistiques_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end

    def on_buttonMenuPrincipal_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
