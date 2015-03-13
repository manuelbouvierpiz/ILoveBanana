# Valentin CHAILLOU
# SauvegardeTermporaire.rb
# Implémentation de la classe SauvegardeTemporaire

# == Classe SauvegardeTemporaire :
#	- connaît une Grille
class SauvegardeTemporaire

	# Variables
	
	# * Variable d'instance qui représente la +Grille+ de la +SauvegardeTemporaire+
	# * Accessible en lecture uniquement
	# * Est initialisée lors de la sauvegardeTemporaire
	attr :grille, false
	
	# Méthodes
	
	# * Méthode de classe permettant la création d'une nouvelle +SauvegardeTemporaire+
	def SauvegardeTemporaire.nouvelle(uneGrille)
		new(uneGrille)
	end
	
	private_class_method :new
	
	# * Méthode d'instance qui initialise la +SauvegardeTemporaire+
	def initialize(uneGrille)	# :nodoc:
		grille = uneGrille.clone	# Il faut une copie de la grille étant donné que c'est une sauvegarde
	end
end
