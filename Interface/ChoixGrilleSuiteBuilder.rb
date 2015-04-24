#JOUSSE Wilfried, modifié par Parmenon Damien

# encoding: UTF-8


class ChoixGrilleSuiteBuilder < TakuzuBuilder
    
	@monde

	def ChoixGrilleSuiteBuilder.creer(unMonde)
		new(unMonde)
	end
  
	private_class_method :new

	def initialize(unMonde)
		super(__FILE__)   
		@monde=unMonde
		@nomMonde.set_text(@monde.nom)

		unResultatIntermediaire = true
		20.upto(39) do |x|
			if unResultatIntermediaire
				unResultatIntermediaire = @monde.partie(x).initialiseEtat
			end
			
			if unResultatIntermediaire && @monde.partie(x).estDebloque?
				eval("@button#{x-19}.set_tooltip_text(\"Etoile(s) : #{@monde.partie(x).nbEtoile}/3\")")
			else
				eval("@button#{x-19}.set_sensitive(false)")
			end
			
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
