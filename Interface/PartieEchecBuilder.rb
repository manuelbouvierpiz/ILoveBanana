# encoding: UTF-8

##
# Damien Parmenon
#

class PartieEchecBuilder < TakuzuBuilder

	def initialize
        super(__FILE__, "Echec de la partie")
        if(Jeu.JEU.partie.isDefi)
        	labelEchec.text = "Vous avez perdu le défi."
        end
		Jeu.JEU.partie.remiseAZero
		Jeu.JEU.partie = nil
    end

    def on_buttonRetour_clicked
    	ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
