#JOUSSE Wilfried, modifié par Parmenon Damien

# encoding: UTF-8


class ChoixGrilleSuiteBuilder < TakuzuBuilder
    
	@monde

	def ChoixGrilleSuiteBuilder.creer(unMonde)
		new(unMonde)
	end
  
	private_class_method :new

	def initialize(unMonde)
		super(__FILE__,"Choix de la Grille")   
		@monde=unMonde
		@nomMonde.set_text(@monde.nom)

		unResultatIntermediaire = true
		20.upto(39) do |x|
			if unResultatIntermediaire
				unResultatIntermediaire = @monde.partie(x).initialiseEtat
			end
=begin
		if unResultatIntermediaire && @monde.partie(20).estDebloque?
			@button1.set_tooltip_text("Etoile(s) : #{@monde.partie(20).nbEtoile}/3")
		else
			@button1.set_sensitive(false)
		end
=end
			eval("if unResultatIntermediaire && @monde.partie(#{x}).estDebloque?\n@button#{x-19}.set_tooltip_text(\"Etoile(s) : #{unResultatIntermediaire ? @monde.partie(x).nbEtoile : 0}/3\")\nelse\n@button#{x-19}.set_sensitive(false)\nend")
		end
	end

	def on_niveauBouton_clicked unLabel
		i=unLabel.label.to_i - 1
		laPartie = @monde.partie(i)
		ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
	end

	def on_precedentBouton_clicked
		ouvrirFenetre(ChoixGrilleBuilder.creer(@monde))
	end
  
	def on_retourBouton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
end
