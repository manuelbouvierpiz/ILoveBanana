class Didactitiel 
	@didactitielDeBase
	@didactitielAvance


=begin
	
Les valeurs 5 et  6 sont temporaires et servent juste pour illustrer que l'id des grilles sera connu en avance.
	
=end


	def Didactitiel
		@didactitielDeBase,@didactitielAvance = PartieDidactitiel.creer(5) , PartieDidactitiel.creer(6) 
	end



	def estTermine?
		return (@didactitielDeBase.estTermine && didactitielAvance.estTermine )
	end
