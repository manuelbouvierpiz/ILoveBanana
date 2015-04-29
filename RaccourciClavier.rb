class RaccourciClavier
	# * Variables d'instance qui représentent l'identifiant du *RaccourciClavier*, son nom ainsi que le caractère attribué
	# * Accessible en lecture
	attr_reader :id , :nom, :caractere

=begin
	La pause est associer a la  touche p et l'id 1.
	Le clique droit a la touche d et l'id 2.
	Le clique gauche a la touche  f et l'id 3.
	L'hypothese a la touche h et l'id 4.
=end
	
	# * Méthode de classe qui crée un nouveau *RaccourciClavier*
	# * === Attribut :
	#		- id : un entier représentant l'ID du *RaccourciClavier*
	#		- nom : une chaîne de caractère représentant le nom du du *RaccourciClavier*
	#		- unPseudo : une chaîne de caractère représentant le pseudo du joueur
	def RaccourciClavier.creer(id,nom,unPseudo) 
		new(id,nom,unPseudo)
	end
	
	private_class_method :new
	
	# * Méthode d'instance qui initialise les variables d'instance
	def initialize(id,nom,unPseudo)
		@id,@nom = id,nom
		@caractere =BaseDeDonnees.getRaccourci(unPseudo, @id)
	end

	# * Méthode d'instance qui change la touche du *RaccourciClavier*
	# * === Attributs :
	#		- unRaccourci : un caractère représentant la touche
	def changerTouche(unRaccourci)
		BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, @id, unRaccourci)
	end
	
	# * Méthode d'instance qui remet la touche par défaut du *RaccourciClavier*
	# * === Attributs :
	#		- unPseudo : une chaîne de caractère représentant la pseudo du joueur
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
	
	# * Méthode de classe qui initialise les touches des *RaccourciClavier* dans la base de donnée
	def RaccourciClavier.premiereInitialisationRaccourci(unPseudo)
		BaseDeDonnees.setRaccourci(unPseudo, 1,'p')
		BaseDeDonnees.setRaccourci(unPseudo, 2,'d')
		BaseDeDonnees.setRaccourci(unPseudo, 3,'f')
		BaseDeDonnees.setRaccourci(unPseudo, 4,'h')
	end
end
