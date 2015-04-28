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

	# * Variable d'instance (un <b>String</b>) qui représente le chemin d'accès à l'image du *Monde*
	# * Accessible en lecture uniquement
	attr :image, false
	
	# * Variable d'instance (un <b>Boolean</b>) qui représente l'état du monde
	# * Non accessible
	@etat
	
	# * Variable d'instance qui représente un tableau de niveaux
	# * Non accessible
	# * Le tableau de parties est rempli dynamiquement par la méthode *Partie*
	@tableauParties
	
	attr_writer :etat

	# Méthodes d'instance
	
	# * Méthode d'instance qui crée un nouveau Monde
	# * === Attributs :
	#		- unIdMonde	: un entier representant le numero du monde
	# 		- uneImage	: un string representant le chemin vers l'image
	def Monde.creer(unIdMonde, uneImage)
		new(unIdMonde, uneImage)
	end

	# Méthode d'instance qui initialise le Monde
	# * === Attributs :
	#		- unIdMonde	: un entier representant le numero du monde
	# 		- uneImage	: un string representant le chemin vers l'image
	def initialize(unIdMonde, uneImage)
		@idMonde = unIdMonde
		@image = uneImage
		@nom = BaseDeDonnees.getMondeNom(@idMonde)
		@etat = false
		
		# Création du tableau de parties
		if(@idMonde != 8)
			@tableauParties = Array.new(40)
		else
			@tableauParties = Array.new(20)
		end
	end
	
	# * Méthode d'instance qui renvoie la *PartieMonde* associée au numéro
	# * === Attributs :
	#		- unNumero	: un entier representant le numero d'une partie du monde compris entre 1 et 40
	# * Crée dynamiquement la *PartieMonde* si besoin
	# * Retourne une *PartieMonde*
	def partie(unNumero)
		if @tableauParties[unNumero] == nil
			if @idMonde != 8
				@tableauParties[unNumero] = PartieMonde.creer(BaseDeDonnees.getMondeGrilleId(@idMonde, unNumero + 1))
			else
				@tableauParties[unNumero] = PartieMonde.creer(BaseDeDonnees.getMondeGrilleId(@idMonde, unNumero + 1), true)		# C'est une GrilleHardcore
			end
		end
		return @tableauParties[unNumero]
	end

	# * Méthode d'instance qui permet de donner l'accès à un *Monde*
	# * Retourne *self*
	def debloquer()
		if @etat == false
			@etat = true
		end
		return self
	end

	# * Méthode d'instance qui permet de savoir si le *Monde* est accessible
	# *	Retourne un boolean qui represente l'etat du *Monde*
	def estDebloque?()
		return @etat == true
	end

	# * Méthode d'instance qui retourne une chaine de caractères décrivant le *Monde*
	# * Retourne un String
	def to_s()
		unResultat = nom()
		
		if !estDebloque?
			unResultat += " (bloqué)"
		end
			
		return unResultat
	end
	

	# * Méthode d'instance qui initialise l'etat du *Monde*
	# * Retourne un boolean representant l'etat du Monde
	def initialiseEtat
		if(@idMonde == 1)
			@etat = true
		else
			dernierMondeNiveau = BaseDeDonnees.dernierNiveauFini(Compte.COMPTE.pseudo)
			if(dernierMondeNiveau != -1)
				if(dernierMondeNiveau[1] == 40)
					dernierMondeAccessible = dernierMondeNiveau[0] + 1
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
		return @etat
	end
end
