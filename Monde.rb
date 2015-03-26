# Alexandre MOUTEL
# Monde.rb
# Implementation de la classe Monde

# == Classe Monde 
#	- connait son id
#	- rendre le monde accessible (debloquer), savoir si il est bloque (estDebloque?), connaitre son nom (nom), connaitre son theme(theme)

class Monde

	# Variables 
	@idMonde
	@nom
	@etat
	
	attr_reader :idMonde 
	# Méthodes

	def Monde.creer(nom)
		new(nom)
	end

	# Méthode d'instance qui initialise le Monde
	def initialize(nom)
		@nom = nom
		@etat = false
	end

	attr_reader :nom

	# Méthode d'instance qui permet de donner l'accès à un Monde
	def debloquer()
		if(@etat == false)
			@etat = true
		end
	end

	# Méthode d'instance qui permet de savoir si le Monde est accessible
	def estDebloque?()
		return @etat
	end

	# Méthode d'instance qui retourne le nom du monde
	def nom()
		return @nom
	end

	# Méthode d'affichage
	def to_s()
		print "Monde: " + @nom + "Accès: " + @etat
	end
end
