# Valentin CHAILLOU
# Defi.rb
# Implémentation de la classe Defi

# == Classe Defi :
#	- connaît son envoyeur, son destinataire, sa Grille
#	- sait relever un défi, supprimer un défi, donne le score de l'envoyeur
class Defi
	
	# Variables d'instance
	
	# * Variable d'instance (un <b>String</b>) qui représente le pseudo de l'envoyeur du *Defi*
	# * Est initialisée lors de la création de l'objet
	# * Accessible en lecture uniquement
	attr :envoyeur, false
	
	# * Variable d'instance (un <b>String</b>) qui représente le pseudo du destinataire du *Defi*
	# * Est initialisée lors de la création de l'objet
	# * Accessible en lecture uniquement
	attr :destinataire, false
	
	# * Variable d'instance qui représente la *Grille* du *Defi*
	# * Est intialisée lors de la création de l'objet
	# * Accessible en lecture uniquement
	attr :idGrille, false

	attr :scoreEnvoi, false
	
	# Méthodes d'instance
	
	# * Méthode d'instance qui relève un *Defi*
	# * crée une nouvelle *Partie* dans le *Jeu*
	# * Retourne la *Partie* en cours dans le *Jeu*
	def relever
		Jeu.JEU.partie = PartieDefi.creer(@idGrille, @envoyeur, score)
		return Jeu.JEU.partie
	end
	
	# * Méthode d'instance qui supprime le défi courant
	# * Supprime le *Defi* dans la BDD
	# * Retourne *nil*
	def supprimer
		BaseDeDonnees.supprimeDefi(@envoyeur, @destinataire, @idGrille)
		# ACHTUNG ! L'instance n'est pas supprimée directement : NE PAS RELEVER UN DEFI SUPPRIME !!!
		# Par précaution il vaut mieux faire listeDefis[X] = listeDefis.supprimer! afin de supprimer l'instance
		return nil
	end
	
	# * Méthode d'instance qui retourne le score réalisé par l'envoyeur pour le *Defi*
	# * Recherche le score de l'envoyeur dans la BDD
	# * Retourne un entier représentant le score de l'envoyeur
	def score
		return BaseDeDonnees.getDefiScore(@envoyeur, @destinataire, @idGrille)
	end
	
	def initialize(unDestinataire, unEnvoyeur, unIdGrille, unScore) # :nodoc:
		@envoyeur, @destinataire, @idGrille, @scoreEnvoi = unEnvoyeur, unDestinataire, unIdGrille, unScore
	end
	
	def envoyerDefi
		return BaseDeDonnees.setDefi(@destinataire, @envoyeur, @idGrille, @scoreEnvoi)
	end
	# Méthode de classe
	
	# * Méthode de classe permettant de créer un *Defi*
	# ===== Attributs :
	#		- unEnvoyeur : le *Compte* de l'envoyeur
	#		- unDestinataire : le *Compte* du destinataire
	#		- uneGrille : la *Grille* du Defi
	#		- unScore : un entier représentant le score réalisé par l'envoyeur
	def Defi.creer(unDestinataire, unEnvoyeur, unIdGrille, unScore)
		new(unDestinataire, unEnvoyeur, unIdGrille, unScore)
	end
	
	private_class_method :new
end
