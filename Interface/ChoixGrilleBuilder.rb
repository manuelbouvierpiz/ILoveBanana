#JOUSSE Wilfried, Modifié par PARMENON Damien

# encoding: UTF-8


class ChoixGrilleBuilder < TakuzuBuilder
	
	@monde #Monde actuel

	def ChoixGrilleBuilder.creer(unMonde)
	  new(unMonde)
	end
	
	private_class_method :new

	def initialize(unMonde)
		super(__FILE__,"Choix de la grille")   
		@monde = unMonde
		@nomMonde.set_text(@monde.nom)
		if(@monde.idMonde == 8)
			@button21.set_visible(false)
			@label1.set_text("Page 1/1")
		end

=begin
		if @monde.partie(0).estDebloque?
			@button1.set_tooltip_text("Etoile(s) : #{@monde.partie(0).nbEtoile}/3")
		else
			@button1.set_sensitive(false)
		end
=end
		
		0.upto(19) do |x|
			@monde.partie(x).initialiseEtat
			eval("if @monde.partie(#{x}).estDebloque?\n@button#{x+1}.set_tooltip_text(\"Etoile(s) : #{@monde.partie(x).nbEtoile}/3\")\nelse\n@button#{x+1}.set_sensitive(false)\nend")
		end
	end

	def on_niveauBouton_clicked unLabel
		i=unLabel.label.to_i - 1
		laPartie = @monde.partie(i)
		ouvrirFenetre(PartieMondeBuilder.creer(laPartie, @monde))
   end

	def on_suivantBouton_clicked
		ouvrirFenetre(ChoixGrilleSuiteBuilder.creer(@monde))
	end

	def on_retourBouton_clicked
		ouvrirFenetre(ChoixMondeBuilder.new)
	end
  
end
