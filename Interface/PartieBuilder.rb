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
	
	# * Variable d'instance représentant la liste des hypothèses
	@hypotheses

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
		else
			@image1.set_file(unMonde.image)
			unScore = Compte.COMPTE.scorePourLeNiveau(unePartie)
			if unScore > -1
				@meilleurScore.set_text("Meilleur score :\n" + unScore.to_s)
			else
				@meilleurScore.set_text("Meilleur score :\nAucun")
			end
		end

		@partie = unePartie
		@partie.lanceToi
		
		# Mise à jour du temps toutes les secondes
		GLib::Timeout.add(1000) do
			@temps.set_text("Temps :\n" + @partie.getTempsString)
			if !@partie.verifierTempsMax?
				@partie.arretChronometre
				ouvrirFenetre(PartieEchecBuilder.new)
			end
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
		if @partie.grille.difficulte < 8
			@nbClics.set_text("Clics :\n" + @partie.jouer(unX, unY).to_s)
		else
			@nbClics.set_text("Clics :\n" + @partie.jouer(unX, unY).to_s + "/" + @partie.grille.nbClicsMax)
		end
		# Trop lent
		#actualiserGrille()

		if @partie.grille.matrice[unX][unY].estVide?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
		elsif @partie.grille.matrice[unX][unY].estRouge?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
		else #elsif @partie.grille.matrice[unX][unY].estBleu?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
		end
		
		if @partie.grille.estCorrecte?
			@partie.arretChronometre()
			ouvrirFenetre(PartieReussieBuilder.new)
		end
		
		if !@partie.verifierNbClicsMax?
			@partie.arretChronometre()
			ouvrirFenetre(PartieEchecBuilder.new)
		end
	end

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
	
	def on_menu_clicked()
		@partie.arreteToi
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
	
	def on_regle_clicked()
		ouvrirFenetreNonFermante(ReglesBuilder.new)
	end
	
	private_class_method :new
end
