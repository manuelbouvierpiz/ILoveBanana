# encoding: UTF-8


class ListeDefiBuilder < TakuzuBuilder
    def initialize
        super(__FILE__, "Liste des défis")
    end
    
    def on_lancerBouton_clicked
        
    end
    
    def on_supprimerBouton_clicked
        
    end
    
    def on_annulerBouton_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new())
    end
end
