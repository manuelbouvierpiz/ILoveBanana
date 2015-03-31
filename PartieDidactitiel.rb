load 'Partie.rb'

class PartieDidactitiel < Partie 
	
	def PartieDidactitiel.creer(id)
		super(id)		
	end
	
	
	
	def estTermine?()
		@grille.estTermine?
	end
end