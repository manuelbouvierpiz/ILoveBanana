# encoding: UTF-8

# Valentin CHAILLOU

class ReinitialisationConfirmationBuilder < TakuzuBuilder
    def initialize
        super(__FILE__)
    end

    def on_boutonNon_clicked
    	ouvrirFenetre(OptionsBuilder.new)
    end

	def on_boutonOui_clicked
		Compte.COMPTE.reinitialiser
    	ouvrirFenetre(MenuPrincipal.new)
    end
end
