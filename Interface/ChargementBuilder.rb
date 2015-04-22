# encoding: UTF-8

# Damien PARMENon et Valentin CHAILLOU

#
class ChargementBuilder < TakuzuBuilder
    def initialize
        super(__FILE__, "Takuzu Avengers")
		
		# Mise à jour de la classe chargée 10 fois par seconde
		GLib::Timeout.add(100) do
			uneClasse = Chargement.element
			unPourcentage = Chargement.pourcentage
			
			if uneClasse == nil
				self['window1'].destroy
				false
			else
				@labelTexte.set_text("Chargement de " + uneClasse + " (" + unPourcentage.to_s + "%)")
				true
			end
			
		end
    end
	
	# Méthode de classe

	# * Méthode de classe qui lance l'interface graphique
	# * Est appelée depuis +TakuzuLanceur.rb+
	def ChargementBuilder.lancer
		Gtk.init
		ChargementBuilder.new()
		Gtk.main
    end

end
