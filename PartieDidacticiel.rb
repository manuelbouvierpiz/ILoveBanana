load 'Partie.rb'

class PartieDidacticiel < Partie 
	
	def PartieDidacticiel.creer(id)
		new(id)		
	end
	
	def initialize
		super(id)
	end
	
	def estTermine?()
		@grille.estTermine?
	end
end
