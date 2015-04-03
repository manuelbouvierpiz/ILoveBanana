load 'Partie.rb'

class PartieDidacticiel < Partie 
	
	def PartieDidacticiel.creer(id)
		super(id)		
	end
	
	
	
	def estTermine?()
		@grille.estTermine?
	end
end
