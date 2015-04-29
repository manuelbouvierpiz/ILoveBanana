#JOUSSE Wilfried, modifié par Parmenon Damien

# encoding: UTF-8

# == Classe *ChoixGrilleSuiteBuilder* :
#	- est un *TakuzuBuilder*
class ChoixGrilleSuiteBuilder < TakuzuBuilder
    	
    	# * Variable d'instance qui représente un *Monde* de l'Aventure
	@monde
	
	# * Méthode de classe qui permet de créer un *ChoixGrilleSuiteBuilder*
	# ===== Attribut :
	#	- uneMonde : un *Monde* de l'Aventure
	def ChoixGrilleSuiteBuilder.creer(unMonde)
		new(unMonde)
	end
  
	private_class_method :new
	
	# Méthode d'instance qui initialise le *ChoixGrilleBuilder*
	def initialize(unMonde)
		super(__FILE__)   
		@monde=unMonde
		@nomMonde.set_text(@monde.nom)

		unResultatIntermediaire = true
		20.upto(39) do |x|
			if unResultatIntermediaire  && !@monde.partie(x).estDebloque?
				unResultatIntermediaire = @monde.partie(x).initialiseEtat
			end
			
			if unResultatIntermediaire && @monde.partie(x).estDebloque?
				eval("@button#{x-19}.set_tooltip_text(\"Etoile(s) : #{@monde.partie(x).nbEtoile}/3\")")
			else
				eval("@button#{x-19}.set_sensitive(false)")
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

	# * Méthode d'instance qui permet d'initialiser *ChoixGrilleBuilder* et d'ouvrir la fênetre correspondante
	# * Est automatiquement appelée par Gtk
	def on_precedentBouton_clicked
		ouvrirFenetre(ChoixGrilleBuilder.creer(@monde))
	end
  	
  	# * Méthode d'instance qui permet de retourner à la fenêtre précédente *ChoixMondeBuilder*
	# * Est automatiquement appelée par Gtk
	def on_retourBouton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
end
