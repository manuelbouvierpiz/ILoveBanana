# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

require 'gtk2'

load 'Interface/TakuzuBuilder.rb'

# == Classe PartieBuilder :
#	- est un TakuzuBuilder
#	- est considérée comme une classe abstraite
#	- connaît sa partie
class PartieBuilder < TakuzuBuilder

	# Variable d'instance

	# * Variable d'instance non accessible qui représente la partie en cours
	@partie

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie en appliquant une image de fond
    def initialize(unePartie, unMonde)	# :nodoc:
        super("Partie#{unePartie.grille.taille}Builder", "Partie")

		@image1.set_file(unMonde.image)

		@partie = unePartie
		@partie.lanceToi
    end

	# Méthode d'instance qui initialise la partie sans appliquer d'image de fond
	def initialize(unePartie)			# :nodoc:
		super("Partie#{unePartie.grille.taille}Builder", "Partie")

		@partie = unePartie
		@partie.lanceToi
	end

	# Méthodes de classe

	# * Méthode de classe qui permet de créer une +PartieBuilder+
	# ===== Attributs :
	#	- unMonde : un +Monde+ dans lequel se trouve la +Partie+
	#	- unePartie : une +Partie+ à lancer 
	def PartieBuilder.creer(unePartie, unMonde)
		new(unePartie, unMonde)
	end

	# * Méthode de classe qui permet de créer une +PartieBuilder+
	# ===== Attributs :
	#	- unePartie : une +Partie+ à lancer
	def PartieBuilder.creer(unePartie)
		new(unePartie)
	end

	private_class_method :new
end
