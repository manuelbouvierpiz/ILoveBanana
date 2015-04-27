# Wilfried JOUSSE
# Modifications apportées par Valentin CHAILLOU

# == Classe Aventure
#		- connaît ses mondes
class Aventure

	# Variable d'instance

	# * Variable d'instance accessible en lecture qui représente un tableau des huit <b>Monde</b>s
	attr_reader :mondes
	
	# Méthode d'instance

	# Méthode d'instance qui initialise l'Aventure
	def initialize()	# :nodoc:
		@mondes = [Monde.creer(1,"Images/prairie.png"),
				Monde.creer(2, "Images/foret.png"),
				Monde.creer(3, "Images/mer.png"),
				Monde.creer(4, "Images/desert.png"),
				Monde.creer(5, "Images/grotte.png"),
				Monde.creer(6, "Images/volcan.png"),
				Monde.creer(7, "Images/espace.png"),
				Monde.creer(8, "Images/arc-en-ciel.png")]
	end

end
