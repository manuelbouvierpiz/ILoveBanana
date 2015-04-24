# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe +PartieBuilder+ :
#	- est un +TakuzuBuilder+
#	- est considérée comme une classe abstraite
class PartieBuilder < TakuzuBuilder

	# Variable d'instance
	
	# * Variable d'instance qui représente l'ID du handler de l'arrêt du jeu
	@handlerArret

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
		super("Interface/Partie#{unePartie.grille.taille}Builder.glade")
		
		Jeu.JEU.partie = unePartie
		
		# Pour que la partie soit sauvegardée même quand on ferme la fenêtre
		# Le handler sera déconnecté si il échoue (en mode hardcore) ou si il gagne la partie
		@handlerArret = self['window1'].signal_connect("destroy") { Jeu.JEU.partie.arreteToi }
		
		# Raccourcis clavier !
		self['window1'].signal_connect("key-press-event") do |wdt, key|
		
=begin
			if key.keyval == Gdk::Keyval::GDK_p						# Pause
				on_regle_clicked if @regle.get_property(\"visible\")
			elsif key.keyval == Gdk::Keyval::GDK_h					# Hypothèse
				on_hypothese_clicked if @hypothese.get_property(\"visible\")
			end
=end

			eval("if key.keyval == Gdk::Keyval::GDK_#{Compte.COMPTE.options.getRaccourci(1)}\non_regle_clicked if @regle.get_property(\"visible\")\nelsif key.keyval == Gdk::Keyval::GDK_#{Compte.COMPTE.options.getRaccourci(4)}\non_hypothese_clicked if @hypothese.get_property(\"visible\")\nend")
		end
		
		# Mise à jour du temps toutes les secondes
		GLib::Timeout.add(1000) do
			begin
				@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
				if !Jeu.JEU.partie.verifierTempsMax?
					self['window1'].signal_handler_disconnect(@handlerArret)
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
					eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(\"grey\"))\nend")
				elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
					eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))\nend")
				else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
					eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))\nend")
				end
			end
		end
		
		# Trop lent
		#actualiserGrille()
		
		# Connexion des signaux pour les hypothèses
		1.upto(5) do |unNumero|
			eval("@hypothese_#{unNumero}.signal_connect(\"clicked\") { on_hypothese_X_clicked(#{unNumero}) }\n@hypothese_#{unNumero}.hide")
		end		
		
		# Initialisation du bouton "back" (non disponible si c'eset le tout début d'une partie)
		if !Jeu.JEU.partie.peutRetourArriere?
			@back.hide
		end
		
		Jeu.JEU.partie.lanceToi
		
		@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
		@nbClics.set_text("Clic(s) :\n" + Jeu.JEU.partie.nbClicsString)
		
	end

	# * Méthode d'instance qui permet de modifier l'état d'une +Case+
	# * Est automatiquement appelée par Gtk
	def	on_bouton_clicked(unX, unY)
		Jeu.JEU.partie.jouer(unX, unY)
		@nbClics.set_text("Clic(s) :\n" + Jeu.JEU.partie.nbClicsString)
		
		# Trop lent
		#actualiserGrille()

		if Jeu.JEU.partie.grille.matrice[unX][unY].estVide?
			eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(\"grey\"))\nend")
		elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
			eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))\nend")
		else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
			eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))\nend")
		end
		
		# Ré-affichage du retour arrière
		if Jeu.JEU.partie.peutRetourArriere?
			@back.show
		end
	end

	# * Méthode d'instance qui permet de rafraichir l'affichage de la +Grille+
	# * Ne doit être appelée que lors d'un chargement de sauvegarde temporaire
	def actualiserGrille()
		0.upto(Jeu.JEU.partie.grille.taille - 1) do |unX|
			0.upto(Jeu.JEU.partie.grille.taille - 1) do |unY|
				if Jeu.JEU.partie.grille.matrice[unX][unY].estVide?
					eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(\"grey\"))\nend")
				elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
					eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(Compte.COMPTE.options.couleur(1)))\nend")
				else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
					eval("[Gtk::STATE_NORMAL, Gtk::STATE_ACTIVE, Gtk::STATE_PRELIGHT].each do |unEtatGtk|\n@bouton_#{unX+1}_#{unY+1}.modify_bg(unEtatGtk, Gdk::Color.parse(Compte.COMPTE.options.couleur(2)))\nend")
				end
			end
		end
	end
	
	# * Méthode d'instance qui permet d'arrêter la +Partie+ et de retourner au menu principal
	# * Est automatiquement appelée par Gtk
	def on_menu_clicked()
		# La partie s'arrête quand la fenêtre reçoit le signal destroy
		ouvrirFenetre(MenuPrincipalBuilder.new)
		Jeu.JEU.partie = nil
	end
	
	# * Méthode d'instance qui permet d'ouvrir une fenêtre indiquant les règles
	# * Est automatiquement appelée par Gtk
	def on_regle_clicked()
		Jeu.JEU.partie.mettreEnPauseChronometre()
		@grille.hide
		@regle.hide
		ouvrirFenetreNonFermante(ReglesBuilder.new)
	end
	
	# * Méthode d'instance qui permet d'afficher une aide
	# * Est automatiquement appelée par Gtk
	def on_aide_clicked()
		@aideLabel.set_text(Jeu.JEU.partie.obtenirAide)
	end
	
	# * Méthode d'instance qui permet de jouer un coup en arrière
	# * Est automatiquement appelée par Gtk
	def on_back_clicked()
		Jeu.JEU.partie.retourArriere
		if !Jeu.JEU.partie.peutRetourArriere?
			@back.hide
		end
		actualiserGrille()
	end
	
	# * Méthode d'instance qui permet de poser une sauvegarde temporaire pour une hypothèse
	# * Est automatiquement appelée par Gtk
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
	
	# * Méthode d'instance qui permet de revenir à un état sauvegardé/pré-hypothésé
	# * Est automatiquement appelée par Gtk
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
