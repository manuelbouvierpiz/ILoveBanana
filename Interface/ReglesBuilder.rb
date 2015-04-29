# encoding: UTF-8

# Valentin CHAILLOU

# == Classe *ReglesBuilder* :
#	- sait afficher les règles
class ReglesBuilder < TakuzuBuilder

	
    # * Méthodes d'instance qui initialise *ReglesBuilder*
    def initialize	
		super(__FILE__, "Règles")
		
		self['window1'].signal_connect("key-press-event") do |wdt, key|
			eval("if key.keyval == Gdk::Keyval::GDK_#{Compte.COMPTE.options.getRaccourci(1)}\non_boutonRetour_clicked\nend")
		end
    end

	# * Méthode d'instance qui effectue le traitement du bouton retour
	# * Est appelée automaiquement par Gtk
	def on_boutonRetour_clicked
		ouvrirFenetrePrecedente
		Jeu.JEU.partie.repriseChronometre
    end
end
