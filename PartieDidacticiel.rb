load 'Partie.rb'

class PartieDidactitiel < Partie 
	
	def PartieDidacticiel.creer(id)
		super(id)		
	end
	
	
	
	def estTermine?()
		@grille.estTermine?
	end
end
