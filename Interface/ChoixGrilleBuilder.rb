#JOUSSE Wilfried, Modifié par PARMENON Damien et Valentin CHAILLOU

# encoding: UTF-8

# == Classe *ChoixGrilleBuilderr* :
#	- est un *TakuzuBuilder*
class ChoixGrilleBuilder < TakuzuBuilder

	# * Variable d'instance qui représente un *Monde* de l'Aventure
	@monde #Monde actuel
	
	# * Méthode de classe qui permet de créer un *ChoixGrilleBuilder*
	# ===== Attribut :
	#	- uneMond : un *Monde* de l'Aventure
	def ChoixGrilleBuilder.creer(unMonde)
		new(unMonde)
	end
	
	private_class_method :new
	
	# Méthode d'instance qui initialise le *ChoixGrilleBuilder*
	def initialize(unMonde)
		super(__FILE__)   
		@monde = unMonde
		@nomMonde.set_text(@monde.nom)
		if(@monde.idMonde == 8)
			@button21.set_visible(false)
			@label1.set_text("Page 1/1")
		end
		unResultatIntermediaire = true
		0.upto(19) do |x|
			if unResultatIntermediaire && !@monde.partie(x).estDebloque?
				unResultatIntermediaire = @monde.partie(x).initialiseEtat
			end

			if unResultatIntermediaire && @monde.partie(x).estDebloque?
				eval("@button#{x+1}.set_tooltip_text(\"Etoile(s) : #{@monde.partie(x).nbEtoile}/3\")")
			else
				eval("@button#{x+1}.set_sensitive(false)")
			end
			
		end
	end
	
	# * Méthode d'instance qui permet de lancer une *PartieMonde* et d'ouvrir la fenêtre de la partie
	# * Est automatiquement appelée par Gtk
	def on_niveauBouton_clicked unLabel
		i=unLabel.label.to_i - 1
		laPartie = @monde.partie(i)
		ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
   	end
	
	# * Méthode d'instance qui permet d'initialiser *ChoixGrilleSuiteBuilder* et d'ouvrir la fênetre correspondante
	# * Est automatiquement appelée par Gtk
	def on_suivantBouton_clicked
		ouvrirFenetre(ChoixGrilleSuiteBuilder.creer(@monde))
	end
	
	# * Méthode d'instance qui permet de retourner à la fenêtre précédente
	# * Est automatiquement appelée par Gtk
	def on_retourBouton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
  
end
