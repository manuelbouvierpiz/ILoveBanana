class RaccourciClavier
	@id
	@nom

	attr_reader :id , :nom

=begin
	La pause est associer a la  touche p et l'id 1.
	Le clique droit a la touche d et l'id 2.
	Le clique gauche a la touche  f et l'id 3.
	L'hypothese a la touche h et l'id 4.
=end

	def RaccourciClavier.creer(id,nom,unPseudo) 
		new(id,nom,unPseudo)
	end
	
	private_class_method :new

	def initialize(id,nom,unPseudo)
		@id,@nom = id,nom
		resetTouche(unPseudo)
	end


	def changerTouche
		a=gets
		BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id,'a')
	end

	def resetTouche(unPseudo)
		case @id
			when 1
				BaseDeDonnees.setRaccourci(unPseudo, @id,'p')
			when 2
				BaseDeDonnees.setRaccourci(unPseudo, @id,'d')
			when 3
				BaseDeDonnees.setRaccourci(unPseudo, @id,'f')
			when 4
				BaseDeDonnees.setRaccourci(unPseudo, @id,'h')
		end
	end
end
