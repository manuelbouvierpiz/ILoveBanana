# encoding: UTF-8

##
# Damien Parmenon
#

class PartieEchecBuilder < TakuzuBuilder

	def initialize 
        super(__FILE__, "Echec de la partie")
    end

    def on_buttonRetour_clicked
    	ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
