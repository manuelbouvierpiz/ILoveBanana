# Alexandre MOUTEL
# Modifications par Valentin CHAILLOU
# Monde.rb
# Implementation de la classe Monde

load 'BaseDeDonnees.rb'

# == Classe Monde 
#	- connait son id, son nom, son état (bloqué/débloqué) et ses niveaux
#	- rendre le monde accessible (debloquer), savoir si il est bloque (estDebloque?), connaitre son nom (nom), connaitre son theme(theme)

class Monde

	# Variables d'instance
	
	# * Variable d'instance (un entier) qui représente l'id du monde
	# * Accessible en lecture uniquement
	attr :idMonde, false
	
	# * Variable d'instance (un <b>String</b>) qui représente le nom du monde
	# * Accessible en lecture uniquement
	attr :nom, false
	
	# * Variable d'instance (un <b>String</b>) qui représente l'état du monde
	# * Non accessible
	@etat
	
	# * Variable d'instance qui représente un tableau de niveaux
	# * Accessible en lecture uniquement
	# * Le tableau de <b>PartieMonde</b>s doit être créé pour initialiser le monde
	attr :tableauParties, false

	# Méthodes d'instance
	
	# * Méthode d'instance qui crée un nouveau Monde
	def Monde.creer(unIdMonde, unNom)
		new(unIdMonde, unNom)
	end

	# Méthode d'instance qui initialise le Monde
	def initialize(unIdMonde, unNom)
		@idMonde = unIdMonde
		@nom = unNom
		@etat = "bloqué"
		
		# Création du tableau de parties
		@tableauParties = []
		
		0.upto(40) do |i|
			@tableauParties += PartieMonde.creer(BaseDeDonnees.getMondeGrilleId(@idMonde, i))
		end
	end

	attr_reader :nom

	# Méthode d'instance qui permet de donner l'accès à un Monde
	def debloquer()
		if @etat == "bloqué"
			@etat = "débloqué"
		end
	end

	# Méthode d'instance qui permet de savoir si le Monde est accessible
	def estDebloque?()
		return @etat == "débloqué"
	end

	# * Méthode d'instance qui retourne une chaine de caractères décrivant le +Monde+
	def to_s()
		unResultat = nom()
		
		if !estDebloque?
			unResultat += " (bloqué)"
		else
			
		return unResultat
	end
end
