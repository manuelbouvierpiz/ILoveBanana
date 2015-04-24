

class ChoixMondeBuilder < TakuzuBuilder

	def initialize 
        	super(__FILE__)
        	res = true
        	0.upto(7) do |i|
			if(!Jeu.JEU.aventure.mondes[i].estDebloque?())
				if(res == true)
        				res = Jeu.JEU.aventure.mondes[i].initialiseEtat
				end
			end
		end
		@buttonForet.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[1].estDebloque?)
        	@buttonMer.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[2].estDebloque?)
        	@buttonDesert.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[3].estDebloque?)
        	@buttonGrotte.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[4].estDebloque?)
        	@buttonVolcan.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[5].estDebloque?)
        	@buttonEspace.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[6].estDebloque?)
        	@buttonArcEnCiel.set_sensitive(false) if(!Jeu.JEU.aventure.mondes[7].estDebloque?)
	end

	def go2Prairie
		monde=Jeu.JEU.aventure.mondes[0]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2Foret
		monde=Jeu.JEU.aventure.mondes[1]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2Mer
		monde=Jeu.JEU.aventure.mondes[2]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2Dessert
		monde=Jeu.JEU.aventure.mondes[3]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2Grotte
		monde=Jeu.JEU.aventure.mondes[4]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2Volcan
		monde=Jeu.JEU.aventure.mondes[5]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2Espace
		monde=Jeu.JEU.aventure.mondes[6]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def go2ArcEnCiel
		monde=Jeu.JEU.aventure.mondes[7]
		ouvrirFenetre(ChoixGrilleBuilder.creer(monde))
	end

	def on_buttonRetour_clicked
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end

end
