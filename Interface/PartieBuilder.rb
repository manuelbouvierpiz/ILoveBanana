# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

require 'gtk2'

# == Classe +PartieBuilder+ :
#	- est un TakuzuBuilder
#	- est considérée comme une classe abstraite
#	- connaît sa partie
class PartieBuilder < TakuzuBuilder

	# Variable d'instance

	# * Variable d'instance non accessible qui représente la partie en cours
	@partie

	# Méthode de classe

	# * Méthode de classe qui permet de créer une +PartieBuilder+
	# ===== Attribut :
	#	- unePartie : une +Partie+ à lancer
	# ===== Attributs :
	#	- unMonde : un +Monde+ dans lequel se trouve la +Partie+
	#	- unePartie : une +Partie+ à lancer 
	def PartieBuilder.creer(unePartie, unMonde=nil)
		new(unePartie, unMonde)
	end

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie, unMonde)			# :nodoc:
		super("Interface/Partie#{unePartie.grille.taille}Builder.rb", "Partie")
		
		if unMonde != nil
			@image1.set_file(unMonde.image)
		end

		@partie = unePartie
		@partie.lanceToi
		Thread.new{
				while !@partie.estTermine? do
					@temps.set_text("Temps :\n" + @partie.getTempsString)
				end
			}
	end

	# * Méthode d'instance qui permet de modifier l'état d'une +Case+
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		if @partie.grille.matrice[unX-1][unY-1].estVide? or @partie.grille.matrice[unX][unY].estBleu?
			@partie.grille.matrice[unX-1][unY-1].setRouge
			exec("@bouton_#{unX}_#{unY}.image.modify_fg(Gtk::STATE_NORMAL, Gdk::Color.new(\"#rrrrggggbbbb\"))")	# TODO => Rechercher la couleur dans les options
		else # if @partie.grille.matrice[unX-1][unY-1].estRouge?
			@partie.grille.matrice[unX-1][unY-1].setBleu
			exec("@bouton_#{unX}_#{unY}.image.modify_fg(Gtk::STATE_NORMAL, Gdk::Color.new(\"#rrrrggggbbbb\"))")	# TODO => Rechercher la couleur dans les options
		end
	end

	private_class_method :new
end
