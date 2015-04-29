# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

# == Classe PartieReussieBuilder :
#		est un TakuzuBuilder
class PartieReussieBuilder < TakuzuBuilder

	# Variables d'instance

	# * Variable d'instance non accessible représentant l'ID de la *Grille*
	@idGrille
	
	# * Variable d'instance non accessible représentant le score de la *Partie*
	@leScore
	
	# Méthodes d'instances

	# Méthode d'instance qui initialise le PartieReussieBuilder
	def initialize()	# :nodoc:
		super(__FILE__)
		@leScore = Jeu.JEU.partie.calculerScore
		@idGrille = Jeu.JEU.partie.grille.idGrille
		Jeu.JEU.partie.gagner
		@score.set_text("Score :" + @leScore.to_s)
		@temps.set_text("Temps :" + Jeu.JEU.partie.getTempsString)
		Jeu.JEU.partie.remiseAZero
		@button4.hide
	end

	# * Méthode d'instance qui ouvre la fenêtre de choix d'une nouvelle *PartieLibre*
	# * est automatiquement appelée par Gtk
	def on_button1_clicked
		ouvrirFenetre(TailleDifficulteBuilder.new)
		Jeu.JEU.partie = nil
	end

	# * Méthode d'instance qui ouvre la fenêtre d'envoi d'un *Defi*
	# * est automatiquement appelée par Gtk
	def on_button2_clicked
		ouvrirFenetre(DefiBuilder.creer(@idGrille, @leScore))
		Jeu.JEU.partie = nil
	end

	# * Méthode d'instance qui ouvre le menu principal
	# * est automatiquement appelée par Gtk
	def on_button3_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
		Jeu.JEU.partie = nil
	end
	
	# * Méthode d'instance qui, par défaut, ne fait rien
	# * est automatiquement appelée par Gtk
	def on_button4_clicked
		
	end
end
