# encoding: UTF-8

# Manuel Bouvier
# == Classe *AProposBuilder* :
#	- est un *TakuzuBuilder*
class AProposBuilder < TakuzuBuilder
    # * Méthode d'instance qui initialise la fenêtre correspondante au *AProposBuilder*
    def initialize
        super(__FILE__, "A Propos")
    end
    
    # * Méthode d'instance qui ouvre la fenêtre précédente en l'occurence le Menu dans ce cas
    def on_boutonRetour_clicked
    	ouvrirFenetrePrecedente()
    end
end
