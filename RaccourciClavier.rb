class RaccourciClavier {
	@id
	@nom
	@pseudo
	attr_reader: @id , @nom

=begin
	La pause est associer a la  touche p et l'id 1.
	Le clique droit a la touche d et l'id 2.
	Le clique gauche a la touche  f et l'id 3.
	L'hypothese a la touche h et l'id 4.
=end

	def RaccourciClavier.creer(id,nom,pseudo){
		initialize(id,nom,pseudo,baseDeDonnees)
	}
	def initialize(id,nom,pseudo){
		@id,@nom,@pseudo = id,nom,pseudo
		resetTouche()
	}


	def changerTouche(){
		a=gets
		BaseDeDonnees.setTouche(@id,'a')

	}
	def resetTouche(){
		case @id
		when 1
			BaseDeDonnees.setTouche(@id,'p')
		when 2
			BaseDeDonnees.setTouche(@id,'d')
		when 3
			BaseDeDonnees.setTouche(@id,'f')
		when 4
			BaseDeDonnees.setTouche(@id,'h')
				
	}
}
