# Valentin CHAILLOU
# Case.rb
# Implémentation de la classe Case

# == Classe Case : 
#	- connaît on état
#	- sait se décrire (toString), changer son état (bleu et rouge)
class Case
	
	# Variables
	
	# * Variable d'instance qui représente l'état de la case
	# * Peut être ' ' (vide), 'B', (bleu) ou 'R' (rouge)
	# * Accessible en lecture uniquement
	attr :etat, false

	# Méthodes

	# * Méthode d'instance qui initialise la +Case+
	def initialize()	# :nodoc:
		@etat = ' '
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères décrivant la +Case+
	# * +Retourne+ : un +String+ décrivant la +Case+
	def toString()		# :nodoc:
		return etat
	end
	
	# * Méthode d'instance qui met l'état de la Case sur bleu
	def bleu()
		@etat = 'B'
	end
	
	# * Méthode d'instance qui met l'état de la Case sur bleu
	def rouge()
		@etat = 'R'
	end
	
end