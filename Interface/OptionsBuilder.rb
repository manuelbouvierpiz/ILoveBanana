# encoding: UTF-8

##
# Auteur Kuang Nanzhem, Modification Parmenon Damien
# Version 0.2 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe OptionsBuilder : 
#   - Permet à l'utilisateur de pouvoir choisir des options qui modifieront certaines fonctionnalités du jeu
#   - les options modifiables sont le volume de la musique et du bruitage, certains raccourcis clavier et les couleurs des cases
#   - L'utilisateur doit changer les options qu'il souhaite dans les emplacements dédiés puis cliquer sur le bouton Valider pour les enregistrer
class OptionsBuilder < TakuzuBuilder

	# Variables
	
	# * Variable d'instance qui représente les valeurs possible du curseur correspondant au volume du bruitage
	# * Cette variable est initialisée dans la fonction initialize et a des valeurs possible comprise entre 1 et 100
	# * Accessible en lecture uniquement
	# * L'obtention de la valeur choisie par l'utilisateur se fait grâce à la méthode adjBruitage.value
	attr :adjBruitage, false

	# * Variable d'instance qui représente les valeurs possible du curseur correspondant au volume de la musique
	# * Cette variable est initialisée dans la fonction initialize et a des valeurs possible comprise entre 1 et 100
	# * Accessible en lecture uniquement
	# * L'obtention de la valeur choisie par l'utilisateur se fait grâce à la méthode adjMusique.value
	attr :adjMusique, false
	
	# Méthodes

	# * Méthode d'instance qui initialise la fenêtre correspondante au +MenuPrincipalBuilder+
	# * Cette méthode va chercher dans la base de données les options actuelles du joueur qu'il pourra modifier ensuite
	def initialize() 
		super(__FILE__,"Options")
		@adjBruitage =  Gtk::Adjustment.new(1,1,100,1,1,0)
		@hscaleBruitage.adjustment = @adjBruitage
		@adjMusique =  Gtk::Adjustment.new(1,1,100,1,1,0)
		@hscaleMusique.adjustment = @adjMusique
		
		@adjBruitage.value = Compte.COMPTE.options.getVolumeBruitage
		@adjMusique.value = Compte.COMPTE.options.getVolumeMusique

		@entry1.set_text(Compte.COMPTE.options.getRaccourci(1))
		@entry2.set_text(Compte.COMPTE.options.getRaccourci(2))
		@entry3.set_text(Compte.COMPTE.options.getRaccourci(3))
		@entry4.set_text(Compte.COMPTE.options.getRaccourci(4))

		stringColor1 = Compte.COMPTE.options.couleur(1)
		stringColor2 = Compte.COMPTE.options.couleur(2)
		@colorbutton1.color = Gdk::Color.new(stringColor1[1..4].to_i(16), stringColor1[5..8].to_i(16), stringColor1[9..12].to_i(16))
		@colorbutton2.color = Gdk::Color.new(stringColor2[1..4].to_i(16), stringColor2[5..8].to_i(16), stringColor2[9..12].to_i(16))
	end
	
	# * Méthode d'instance qui ouvre la fenêtre du menu principal si l'utilisateur clique sur le bouton correspondant
	def on_buttonPrecedent_clicked	
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end

	# * Méthode d'instance qui permet de valider les changements effectués par l'utilisateur
	# * Les changements sont directement enregistrés dans la base de données
	# * Ouvre après l'enregistrement la fenêtre correspondant au menu principal
	def on_buttonValider_clicked
	
		if @entryMotDePasse.text != "" || @entryNouveauMotDePasse.text != "" || @entryConfirmation.text != ""
			if @entryMotDePasse.text != "" && @entryNouveauMotDePasse.text != "" && @entryNouveauMotDePasse.text == @entryConfirmation.text && Compte.verifierMotDePasse?(Compte.COMPTE.pseudo, @entryMotDePasse.text)
				Compte.COMPTE.changerMotDePasse(@entryNouveauMotDePasse.text)
			else
				@labelErreur.set_text("Informations incorrectes")
				return
			end
		end
		Compte.COMPTE.options.modifierVolumeBruitage(@adjBruitage.value)
		Compte.COMPTE.options.modifierVolumeMusique(@adjMusique.value)
		
		Compte.COMPTE.options.changerRaccourci(1, @entry1.text)
		Compte.COMPTE.options.changerRaccourci(2, @entry2.text)
		Compte.COMPTE.options.changerRaccourci(3, @entry3.text)
		Compte.COMPTE.options.changerRaccourci(4, @entry4.text)

		Compte.COMPTE.options.changerCouleur(1,@colorbutton1.color.to_s)
		Compte.COMPTE.options.changerCouleur(2,@colorbutton2.color.to_s)
		print @colorbutton2.color
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
end
