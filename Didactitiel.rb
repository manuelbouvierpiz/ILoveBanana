class Didactitiel 
	@didactitielDeBase
	@didactitielAvance


=begin
	
Les valeur 5 et  6 sont temporaire et serve juste pour illustrer que l'id des grilles serat connue en avance
	
=end


	def Didactitiel
		@didactitielDeBase,@didactitielAvance = PartieDidactitiel.creer(5) , PartieDidactitiel.creer(6) 
	end



	def estTermine?
		return (@didactitielDeBase.estTermine && didactitielAvance.estTermine )
	end
