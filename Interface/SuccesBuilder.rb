# encoding: UTF-8

##
# Auteur Alexandre Moutel, Damien Parmenon (Code Ruby)


# == Classe SuccesBuilder : 
#   - Permet l'affichage des succès ainsi que s'ils ont été débloqués ou non par le joueur
#   - Permet également l'accès aux statistiques et au classement ainsi que de retourner sur le Menu Principal
class SuccesBuilder < TakuzuBuilder

    # * Méthode d'instance qui initialise la fenêtre correspondante au +SuccesBuilder+
    # * Va chercher les succés dans la base de données et vérifie s'ils ont été réussis, affiche une image dans le cas où ils le sont
	def initialize
		super(__FILE__, "Succès")
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

    # * Méthode d'instance qui ouvre la fenêtre Classement si l'utilisateur clique sur le bouton correspondant
    def on_buttonClassement_clicked
    	ouvrirFenetre(ClassementBuilder.new)
    end

    # * Méthode d'instance qui ouvre la fenêtre Statistiques si l'utilisateur clique sur le bouton correspondant
    def on_buttonStatistiques_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end

    # * Méthode d'instance qui ouvre le menu principal si l'utilisateur clique sur le bouton correspondant
    def on_buttonMenuPrincipal_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
