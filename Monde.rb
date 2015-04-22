# encoding: UTF-8

# Alexandre MOUTEL
# Modifications par Valentin CHAILLOU
# Monde.rb
# Implementation de la classe Monde

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

	# * Variable d'instance (un <b>String</b>) qui représente le chemin d'accès à l'image du +Monde+
	# * Accessible en lecture uniquement
	attr :image, false
	
	# * Variable d'instance (un <b>Boolean</b>) qui représente l'état du monde
	# * Non accessible
	@etat
	
	# * Variable d'instance qui représente un tableau de niveaux
	# * Accessible en lecture uniquement
	# * Le tableau de <b>PartieMonde</b>s doit être créé pour initialiser le monde
	attr :tableauParties, false

	# Méthodes d'instance
	
	# * Méthode d'instance qui crée un nouveau Monde
	def Monde.creer(unIdMonde, uneImage)
		new(unIdMonde, uneImage)
	end

	# Méthode d'instance qui initialise le Monde
	def initialize(unIdMonde, uneImage)
		@idMonde = unIdMonde
		@image = uneImage
		@nom = BaseDeDonnees.getMondeNom(@idMonde)
		@etat = false
		
		# Création du tableau de parties
		@tableauParties = []
		if(@idMonde != 8)
			1.upto(40) do |i|
				@tableauParties.push(PartieMonde.creer(BaseDeDonnees.getMondeGrilleId(@idMonde, i)))
			end
		else
			1.upto(20) do |i|
				@tableauParties.push(PartieMonde.creer(BaseDeDonnees.getMondeGrilleId(@idMonde, i), true))		# C'est une GrilleHardcore
			end
		end
	end

	# Méthode d'instance qui permet de donner l'accès à un Monde
	def debloquer()
		if @etat == false
			@etat = true
		end
	end

	# Méthode d'instance qui permet de savoir si le Monde est accessible
	def estDebloque?()
		return @etat == true
	end

	# * Méthode d'instance qui retourne une chaine de caractères décrivant le +Monde+
	def to_s()
		unResultat = nom()
		
		if !estDebloque?
			unResultat += " (bloqué)"
		end
			
		return unResultat
	end
	
	def initialiseEtat
		if(@idMonde == 1)
			@etat = true
		else
			dernierMondeNiveau = BaseDeDonnees.dernierNiveauFini(Compte.COMPTE.pseudo)
			if(dernierMondeNiveau != -1)
				if(dernierMondeNiveau[1] == 40)
					dernierMondeAccessible = dernierMondeNiveau + 1
				else
					dernierMondeAccessible = dernierMondeNiveau[0]
				end
			
				if(@idMonde <= dernierMondeAccessible)
					@etat = true
				else
					@etat = false
				end
			else
				@etat = false
			end
		end
		return self
	end
end
