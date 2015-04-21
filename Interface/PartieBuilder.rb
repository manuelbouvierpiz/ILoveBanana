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
		super("Interface/Partie#{unePartie.grille.taille}Builder.glade", "Partie")
		
		if unMonde == nil
			@image1.set_file("Images/rien.png")
			@meilleurScore.set_text("")
			@meilleurScore.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse("white"))
			@nbClics.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse("white"))
			@labelHypothese.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse("white"))
			@temps.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse("white"))
		else
			@image1.set_file(unMonde.image)
		end

		@partie = unePartie
		@partie.lanceToi
		
		# Mise à jour du temps toutes les secondes
		GLib::Timeout.add(1000) do
			@temps.set_text("Temps :\n" + @partie.getTempsString)
			true
		end
		
		0.upto(unePartie.grille.taille - 1) do |unX|
			0.upto(unePartie.grille.taille - 1) do |unY|
				eval("@bouton_#{unX+1}_#{unY+1}.signal_connect(\"clicked\") { on_bouton_clicked(#{unX}, #{unY})}")
				
				if @partie.grille.matrice[unX][unY].estVide?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
				elsif @partie.grille.matrice[unX][unY].estRouge?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
				else #elsif @partie.grille.matrice[unX][unY].estBleu?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
				end
			end
		end
		
		# Trop lent
		#actualiserGrille()
		
	end

	# * Méthode d'instance qui permet de modifier l'état d'une +Case+
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		@nbClics.set_text("Clics :\n" + @partie.jouer(unX, unY).to_s)
		
		# Trop lent
		#actualiserGrille()
=begin	
		if @partie.grille.matrice[unX][unY].estVide?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
		elsif @partie.grille.matrice[unX][unY].estRouge?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
		else #elsif @partie.grille.matrice[unX][unY].estBleu?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
		end
=end
	end
=begin
	# * Méthode d'instance qui permet de rafraichir l'affichage de la +Grille+
	# * Ne doit être appelée que lors d'un chargement de sauvegarde temporaire
	def actualiserGrille()
		0.upto(@partie.grille.taille - 1) do |unX|
			0.upto(@partie.grille.taille - 1) do |unY|
				if @partie.grille.matrice[unX][unY].estVide?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
				elsif @partie.grille.matrice[unX][unY].estRouge?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
				else #elsif @partie.grille.matrice[unX][unY].estBleu?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
				end
			end
		end
	end
=end
	
	private_class_method :new
end
