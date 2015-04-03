# Valentin CHAILLOU
# SauvegardeTermporaire.rb
# Implémentation de la classe SauvegardeTemporaire

# == Classe SauvegardeTemporaire :
#	- connaît une Grille
class SauvegardeTemporaire

	# Variable
	
	# * Variable d'instance qui représente la +Grille+ de la +SauvegardeTemporaire+
	# * Accessible en lecture uniquement
	# * Est initialisée lors de la sauvegardeTemporaire
	attr :grille, false
	
	# Méthode de classe
	
	# * Méthode de classe permettant la création d'une nouvelle +SauvegardeTemporaire+
	def SauvegardeTemporaire.creer(uneGrille)
		new(uneGrille)
	end
	
	private_class_method :new
	
	# Méthode d'instance
	
	# * Méthode d'instance qui initialise la +SauvegardeTemporaire+
	def initialize(uneGrille)	# :nodoc:
		grille = uneGrille.clone	# Il faut une copie de la grille étant donné que c'est une sauvegarde
	end
end
