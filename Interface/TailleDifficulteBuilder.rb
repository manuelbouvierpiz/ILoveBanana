# encoding: UTF-8

##
# Auteur Alexandre Moutel, Damien Parmenon (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'

class TailleDifficulteBuilder < TakuzuBuilder
	@tailleChoisie
# Variable contenant un Adjustment permettant le fonctionnement du curseur difficulte
	@adjDifficulte

	def initialize 
        super(__FILE__, "Choix de la taille et difficulté")
        @adjDifficulte = Gtk::Adjustment.new(1, 1, 7, 1, 1, 0)
        @hscaleDifficulte.adjustment = @adjDifficulte
	end

# Les quatre fonctions suivantes permettent 
# d'activer un et un seul ToggleButton
	def on_buttonSix_toggled
		if(@tailleChoisie != nil)
			case @tailleChoisie
				when 8
					@buttonHuit.set_active(false)
				when 10
					@buttonDix.set_active(false)
				when 12
					@buttonDouze.set_active(false)
			end
		end		
		@tailleChoisie = 6
	end

	def on_buttonHuit_toggled
		if(@tailleChoisie != nil)
			case @tailleChoisie
				when 6
					@buttonSix.set_active(false)
				when 10
					@buttonDix.set_active(false)
				when 12
					@buttonDouze.set_active(false)
			end
		end
		@tailleChoisie = 8
	end

	def on_buttonDix_toggled
		if(@tailleChoisie != nil)
			case @tailleChoisie
				when 6
					@buttonSix.set_active(false)
				when 8
					@buttonHuit.set_active(false)
				when 12
					@buttonDouze.set_active(false)
			end
		end
		@tailleChoisie = 10
	end

	def on_buttonDouze_toggled
		if(@tailleChoisie != nil)
			case @tailleChoisie
				when 6
					@buttonSix.set_active(false)
				when 8
					@buttonHuit.set_active(false)
				when 10
					@buttonDix.set_active(false)
			end
		end
		@tailleChoisie = 12
	end

	def on_buttonPrecedent_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end

# Lance une nouvelle patie en fonction de la taille et difficulté choisie
	def on_buttonSuivant_clicked
		PartieBuilder.creer(PartieLibre.creer(@tailleChoisie,@adjDifficulte.value)))
	end
	Gtk.init
	TailleDifficulteBuilder.new()
	Gtk.main
end
