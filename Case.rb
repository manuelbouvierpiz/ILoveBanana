# Valentin CHAILLOU
# Case.rb
# Implémentation de la classe Case

# == Classe Case : 
#	- connaît on état
class Case
	
	# Variables
	
	# * Variable d'instance qui représente l'état de la case
	# * Peut être ' ' (vide), 'B', (bleu) ou 'R' (rouge)
	@etat

	# Méthodes

	# * Méthode d'instance qui initialise la +Case+
	def initialize()
		@etat = ' '
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères décrivant la +Case+
	# * +Retourne+ : un +String+ décrivant la +Case+
	def toString()
		return etat
	end
end
