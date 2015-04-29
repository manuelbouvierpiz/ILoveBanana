# encoding: UTF-8

# Valentin CHAILLOU

# == Classe *ReinitialisationConfirmationBuilder* :
#		est un TakuzuBuilder
class ReinitialisationConfirmationBuilder < TakuzuBuilder
    # * Méthode d'instance qui intialise le *ReinitialisationConfirmationBuilder*
    def initialize
        super(__FILE__)
    end
    
    # * Méthode d'instance qui ouvre la fenêtre des options
    def on_boutonNon_clicked
    	ouvrirFenetre(OptionsBuilder.new)
    end
    
    # * Méthode d'instance qui réinitialise le compte et ouvre la fenêtre du menu principal
    def on_boutonOui_clicked
	Compte.COMPTE.reinitialiser
    	ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
