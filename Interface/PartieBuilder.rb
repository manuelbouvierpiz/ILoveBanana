# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe +PartieBuilder+ :
#	- est un +TakuzuBuilder+
#	- est considérée comme une classe abstraite
class PartieBuilder < TakuzuBuilder

	# Méthode de classe

	# * Méthode de classe qui permet de créer une +PartieBuilder+
	# ===== Attribut :
	#	- unePartie : une +Partie+ à lancer
	def PartieBuilder.creer(unePartie)
		new(unePartie)
	end

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super("Interface/Partie#{unePartie.grille.taille}Builder.glade", "Partie")
		
		Jeu.JEU.partie = unePartie
		
		# Mise à jour du temps toutes les secondes
		GLib::Timeout.add(1000) do
			begin
				@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
				if !Jeu.JEU.partie.verifierTempsMax?
					Jeu.JEU.partie.arretChronometre
					ouvrirFenetre(PartieEchecBuilder.new)
				end
				true
			rescue
				false
			end
		end
		
		# Parcours initial de la grille pour connecter les signaux et afficher leur couleur initiale
		0.upto(unePartie.grille.taille - 1) do |unX|
			0.upto(unePartie.grille.taille - 1) do |unY|
				eval("@bouton_#{unX+1}_#{unY+1}.signal_connect(\"clicked\") { on_bouton_clicked(#{unX}, #{unY})}")
				
				if Jeu.JEU.partie.grille.matrice[unX][unY].estVide?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
				elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
				else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
				end
			end
		end
		
		# Eviter les eval quand c'est possible => Trop lent
		1.upto(5) do |unNumero|
			eval("@hypothese_#{unNumero}.signal_connect(\"clicked\") { on_hypothese_X_clicked(#{unNumero}) }\n@hypothese_#{unNumero}.hide")
		end
		
		# Connexion des signaux pour les hypothèses
		#unCompteur = 1
		#[@hypothese_1, @hypothese_2, @hypothese_3, @hypothese_4, @hypothese_5].each do |unBouton|
		#	unBouton.hide
		#	unBouton.signal_connect("clicked") { on_hypothese_X_clicked(unCompteur) }
		#	unCompteur +=1
		#end
		
		Jeu.JEU.partie.lanceToi
		
		@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
		@nbClics.set_text("Clic(s) :\n" + Jeu.JEU.partie.nbClicsString)
		
		# Trop lent
		#actualiserGrille()
		
	end

	# * Méthode d'instance qui permet de modifier l'état d'une +Case+
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		Jeu.JEU.partie.jouer(unX, unY)
		@nbClics.set_text("Clics :\n" + Jeu.JEU.partie.nbClicsString)
		
		# Trop lent
		#actualiserGrille()

		if Jeu.JEU.partie.grille.matrice[unX][unY].estVide?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
		elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
		else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
			eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
		end
	end

	# * Méthode d'instance qui permet de rafraichir l'affichage de la +Grille+
	# * Ne doit être appelée que lors d'un chargement de sauvegarde temporaire
	def actualiserGrille()
		0.upto(Jeu.JEU.partie.grille.taille - 1) do |unX|
			0.upto(Jeu.JEU.partie.grille.taille - 1) do |unY|
				if Jeu.JEU.partie.grille.matrice[unX][unY].estVide?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(\"grey\"))")
				elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))")
				else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
					eval("@bouton_#{unX+1}_#{unY+1}.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))")
				end
			end
		end
	end
	
	def on_menu_clicked()
		Jeu.JEU.partie.arreteToi
		Jeu.JEU.partie = nil
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
	
	def on_regle_clicked()
		ouvrirFenetreNonFermante(ReglesBuilder.new)
	end
	
	def on_hypothese_clicked()
		[@hypothese_1, @hypothese_2, @hypothese_3, @hypothese_4, @hypothese_5].each do |unBouton|
			if unBouton.label == nil
				Jeu.JEU.partie.faireHypothese
				unBouton.set_label("Temps : " + Jeu.JEU.partie.getTempsString + "\nClic(s) : " + Jeu.JEU.partie.nbClicsString)
				unBouton.show
				@hypothese.hide if unBouton.equal?(@hypothese_5)
				break
			end
		end
	end
	
	def on_hypothese_X_clicked(unNumero)
		if unNumero > 5 # On a enlevé toutes les hypothèses antérieures
			actualiserGrille
			@hypothese.show
		else			# On enlève les hypothèses antérieures
			eval("if @hypothese_#{unNumero}.label != nil\n@hypothese_#{unNumero}.hide\nJeu.JEU.partie.chargerPreHypo\n@hypothese_#{unNumero}.set_label(nil)\nend")
			on_hypothese_X_clicked(unNumero + 1)
		end
	end
	
	private_class_method :new
end
