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

	def RaccourciClavier.creer(id,nom)
		new(id,nom)
	end

	def initialize(id,nom)
		@id,@nom = id,nom
		resetTouche()
	end


	def changerTouche
		a=gets
		BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id,'a')
	end

	def resetTouche()
		case @id
			when 1
				BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id,'p')
			when 2
				BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id,'d')
			when 3
				BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id,'f')
			when 4
				BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id,'h')
		end
	end
end
