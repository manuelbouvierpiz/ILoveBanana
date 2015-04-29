# encoding: UTF-8

##
# Auteur Alexandre Moutel, Damien Parmenon (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe TailleDifficulteBuilder :
#		est un TakuzuBuilder
class TailleDifficulteBuilder < TakuzuBuilder
	# * Variable d'instance qui représente la taille d'une grille
	@tailleChoisie
	
	# * Variable d'instance contenant un Adjustment permettant le fonctionnement du curseur difficulte
	@adjDifficulte
	
	# * Méthode d'instance qui intialise le *TailleDifficulteBuilder*
	def initialize		# :nodoc:
        super(__FILE__)
        @adjDifficulte = Gtk::Adjustment.new(1, 1, 8, 1, 1, 0)
        @hscaleDifficulte.adjustment = @adjDifficulte
        @adjDifficulte.signal_connect('value-changed'){
        	@labelTaille.show
        	if(@adjDifficulte.value == 4 || @adjDifficulte.value == 7)
        		@buttonSix.set_active(false)
        		@buttonSix.hide
        		@buttonHuit.show
        		@buttonDix.show
        		@buttonDouze.show
        	elsif(@adjDifficulte.value == 8)
				@buttonSix.set_active(false)
        		@buttonSix.hide
        		@buttonHuit.set_active(false)
        		@buttonHuit.hide
        		@buttonDix.set_active(false)
        		@buttonDix.hide
        		@buttonDouze.show
			else
        		@hboxTaille.show_all
        	end
        }
        @labelCorrect.hide
	end

	# * Méthode d'instance qui permet de désactiver les autres boutons de choix de taille qaund celui-ci est sélectionné (Taille 6) 
	# * est automatiquement appelée par Gtk
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
	
	# * Méthode d'instance qui permet de désactiver les autres boutons de choix de taille qaund celui-ci est sélectionné (Taille 8) 
	# * est automatiquement appelée par Gtk
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
	
	# * Méthode d'instance qui permet de désactiver les autres boutons de choix de taille qaund celui-ci est sélectionné (Taille 10) 
	# * est automatiquement appelée par Gtk
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
	
	# * Méthode d'instance qui permet de désactiver les autres boutons de choix de taille qaund celui-ci est sélectionné (Taille 12) 
	# * est automatiquement appelée par Gtk
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
	
	
	# * Méthode d'instance qui ouvre la fenetre du menu principal
	# * est automatiquement appelée par Gtk
	def on_buttonPrecedent_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end

	# * Méthode d'instance qui lance une nouvelle *PartieLibreBuilder* en fonction de la taille et difficulté choisie
	def on_buttonSuivant_clicked
		if(@tailleChoisie != nil)
			ouvrirFenetre(PartieLibreBuilder.creer(PartieLibre.creer(@tailleChoisie, @adjDifficulte.value)))
	 	else
			@labelCorrect.show
		end
	end
end
