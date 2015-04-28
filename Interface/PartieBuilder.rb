# encoding: UTF-8

##
# Auteur : Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe +PartieBuilder+ :
#	- est un +TakuzuBuilder+
#	- est considérée comme une classe abstraite
class PartieBuilder < TakuzuBuilder

	# Variables d'instance
	
	# * Variable d'instance non accessible qui représente l'ID du handler de l'arrêt du jeu
	@handlerArret

	# * Variable d'instance non accessible qui représente le style à appliquer aux <b>Case</b>s rouges
	@styleBoutonRouge

	# * Variable d'instance non accessible qui représente le style à appliquer aux <b>Case</b>s bleues
	@styleBoutonBleu

	# * Variable d'instance non accessible qui représente le style à appliquer aux <b>Case</b>s vides
	@styleBoutonVide
	
	# * Variable d'instance non accessible qui représente le style à appliquer aux <b>Case</b>s signalées par l'aide
	@styleBoutonAide

	# Méthode de classe

	# * Méthode de classe qui permet de créer une +PartieBuilder+
	# ===== Attribut :
	#	- unePartie : une +Partie+ à lancer
	def PartieBuilder.creer(unePartie)
		new(unePartie)
	end
	
	private_class_method :new

	# Méthodes d'instance

	# Méthode d'instance qui initialise la partie
	def initialize(unePartie)			# :nodoc:
		super("Interface/Partie#{unePartie.grille.taille}Builder.glade")
		
		Jeu.JEU.partie = unePartie
		
		# Pour que la partie soit sauvegardée même quand on ferme la fenêtre
		# Le handler sera déconnecté si il échoue (en mode hardcore) ou si il gagne la partie
		@handlerArret = self['window1'].signal_connect("destroy") { Jeu.JEU.partie.arreteToi }

		uneKeyRegle = nil
		uneKeyHypothese = nil

		eval("uneKeyRegle = Gdk::Keyval::GDK_#{Compte.COMPTE.options.getRaccourci(1)}")
		eval("uneKeyHypothese = Gdk::Keyval::GDK_#{Compte.COMPTE.options.getRaccourci(4)}")
		
		# Raccourcis clavier !
		self['window1'].signal_connect("key-press-event") do |wdt, key|


			if key.keyval == uneKeyRegle						# Pause
				on_regle_clicked if @regle.get_property("visible")
			elsif key.keyval == uneKeyHypothese					# Hypothèse
				on_hypothese_clicked if @hypothese.get_property("visible")
			end
		
		end
		
		# Mise à jour du temps toutes les secondes
		GLib::Timeout.add(1000) do
			begin
				@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
				verifierTemps?
			rescue
				false
			end
		end

		### Création des styles pour les couleurs ###

		uneCouleurRouge = Gdk::Color.parse(Compte.COMPTE.options.couleur(1))
		uneCouleurBleu = Gdk::Color.parse(Compte.COMPTE.options.couleur(2))
		uneCouleurVide = Gdk::Color.parse("grey")
		uneCouleurAide = Gdk::Color.parse("white")

		@styleBoutonRouge = Gtk::Style.new
		@styleBoutonBleu = Gtk::Style.new
		@styleBoutonVide = Gtk::Style.new
		@styleBoutonAide = Gtk::Style.new

		@styleBoutonRouge.set_bg(Gtk::STATE_NORMAL, uneCouleurRouge.red, uneCouleurRouge.green, uneCouleurRouge.blue)
		@styleBoutonBleu.set_bg(Gtk::STATE_NORMAL, uneCouleurBleu.red, uneCouleurBleu.green, uneCouleurBleu.blue)
		@styleBoutonVide.set_bg(Gtk::STATE_NORMAL, uneCouleurVide.red, uneCouleurVide.green, uneCouleurVide.blue)
		@styleBoutonAide.set_bg(Gtk::STATE_NORMAL, uneCouleurAide.red, uneCouleurAide.green, uneCouleurAide.blue)

		@styleBoutonRouge.set_bg(Gtk::STATE_ACTIVE, uneCouleurRouge.red, uneCouleurRouge.green, uneCouleurRouge.blue)
		@styleBoutonBleu.set_bg(Gtk::STATE_ACTIVE, uneCouleurBleu.red, uneCouleurBleu.green, uneCouleurBleu.blue)
		@styleBoutonVide.set_bg(Gtk::STATE_ACTIVE, uneCouleurVide.red, uneCouleurVide.green, uneCouleurVide.blue)
		@styleBoutonAide.set_bg(Gtk::STATE_ACTIVE, uneCouleurAide.red, uneCouleurAide.green, uneCouleurAide.blue)

		@styleBoutonRouge.set_bg(Gtk::STATE_PRELIGHT, uneCouleurRouge.red, uneCouleurRouge.green, uneCouleurRouge.blue)
		@styleBoutonBleu.set_bg(Gtk::STATE_PRELIGHT, uneCouleurBleu.red, uneCouleurBleu.green, uneCouleurBleu.blue)
		@styleBoutonVide.set_bg(Gtk::STATE_PRELIGHT, uneCouleurVide.red, uneCouleurVide.green, uneCouleurVide.blue)
		@styleBoutonAide.set_bg(Gtk::STATE_PRELIGHT, uneCouleurAide.red, uneCouleurAide.green, uneCouleurAide.blue)
		
		# Parcours initial de la grille pour connecter les signaux et afficher leur couleur initiale
		0.upto(unePartie.grille.taille - 1) do |unX|
			0.upto(unePartie.grille.taille - 1) do |unY|
				eval("@bouton_#{unX+1}_#{unY+1}.signal_connect(\"clicked\") { on_bouton_clicked(#{unX}, #{unY})}")
				
				if Jeu.JEU.partie.grille.matrice[unX][unY].estVide?
					eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonVide)")
				elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
					eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonRouge)")
				else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
					eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonBleu)")
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
			eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonVide)")
		elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
			eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonRouge)")
		else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
			eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonBleu)")
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
					eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonVide)")
				elsif Jeu.JEU.partie.grille.matrice[unX][unY].estRouge?
					eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonRouge)")
				else #elsif Jeu.JEU.partie.grille.matrice[unX][unY].estBleu?
					eval("@bouton_#{unX+1}_#{unY+1}.set_style(@styleBoutonBleu)")
				end
			end
		end
	end
	
	# * Méthode d'instance qui permet d'arrêter la +Partie+ et de retourner au menu principal
	# * Est automatiquement appelée par Gtk
	def on_menu_clicked()
		if Jeu.JEU.partie.tourne
			# La partie s'arrête quand la fenêtre reçoit le signal destroy dans ouvrirFenetre
			ouvrirFenetre(MenuPrincipalBuilder.new)
			Jeu.JEU.partie = nil
		end
	end
	
	# * Méthode d'instance qui permet d'ouvrir une fenêtre indiquant les règles
	# * Est automatiquement appelée par Gtk
	def on_regle_clicked()
		if Jeu.JEU.partie.tourne
			Jeu.JEU.partie.mettreEnPauseChronometre()
			@grille.hide
			ouvrirFenetreNonFermante(ReglesBuilder.new)
		end
	end
	
	# * Méthode d'instance qui permet d'afficher une aide
	# * Est automatiquement appelée par Gtk
	def on_aide_clicked()
		if Jeu.JEU.partie.tourne
			uneAide = Jeu.JEU.partie.obtenirAide
			@aideLabel.set_text(uneAide[0])
			if uneAide[1] > -1 && uneAide[2] > -1
				eval("@bouton_#{uneAide[1]+1}_#{uneAide[2]+1}.set_style(@styleBoutonAide)")
			end
		
			GLib::Timeout.add(5000) do
				begin
					@aideLabel.set_text("")
					if uneAide[1] > -1 && uneAide[2] > -1 && Jeu.JEU.partie.grille.matrice[uneAide[1]][uneAide[2]].estVide?
						eval("@bouton_#{uneAide[1]+1}_#{uneAide[2]+1}.set_style(@styleBoutonVide)")
					end
					false
				rescue
					false
				end
			end
		end
	end
	
	# * Méthode d'instance qui permet de jouer un coup en arrière
	# * Est automatiquement appelée par Gtk
	def on_back_clicked()
		if Jeu.JEU.partie.tourne
			Jeu.JEU.partie.retourArriere
			if !Jeu.JEU.partie.peutRetourArriere?
				@back.hide
			end
			actualiserGrille()
		end
	end
	
	# * Méthode d'instance qui permet de poser une sauvegarde temporaire pour une hypothèse
	# * Est automatiquement appelée par Gtk
	def on_hypothese_clicked()
		if Jeu.JEU.partie.tourne
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
	end
	
	# * Méthode d'instance qui permet de revenir à un état sauvegardé/pré-hypothésé
	# * Est automatiquement appelée par Gtk
	def on_hypothese_X_clicked(unNumero)
		if Jeu.JEU.partie.tourne
			if unNumero > 5 # On a enlevé toutes les hypothèses antérieures
				@temps.set_text("Temps :\n" + Jeu.JEU.partie.getTempsString)
				@nbClics.set_text("Clic(s) :\n" + Jeu.JEU.partie.nbClicsString)
				actualiserGrille
				@hypothese.show
				if Jeu.JEU.partie.peutRetourArriere?
					@back.show
				else
					@back.hide
				end
			else			# On enlève les hypothèses antérieures
				eval("if @hypothese_#{unNumero}.label != nil\n@hypothese_#{unNumero}.hide\nJeu.JEU.partie.chargerPreHypo\n@hypothese_#{unNumero}.set_label(nil)\nend")
				on_hypothese_X_clicked(unNumero + 1)
			end
		end
	end

	# * Méthode d'instance qui vérifie le temps de la *Partie*
	# * Retourne *true* si le temps n'a pas atteint le temps max, *false* sinon
	def verifierTemps?()
		if Jeu.JEU.partie.verifierTempsMax?
			return true
		end

		self['window1'].signal_handler_disconnect(@handlerArret)
		Jeu.JEU.partie.arretChronometre
		return false
	end
end
