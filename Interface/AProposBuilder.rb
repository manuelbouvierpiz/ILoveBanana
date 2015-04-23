# encoding: UTF-8

# Manuel Bouvier

class AProposBuilder < TakuzuBuilder
    def initialize
        super(__FILE__, "A Propos")
    end

    def on_boutonRetour_clicked
    	ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
