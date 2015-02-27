# Valentin CHAILLOU
# Case.rb
# Implémentation de la classe Case

# == Classe Case : 
#	- connaît son état
#	- sait se décrire (to_s), changer son état (setBleu, setRouge, setVide, setHypothese, setNonHypothese), donner son état (estBleu?, estRouge?, estVide?, estHypothese?)
class Case
	
	# Variables
	
	# * Variable d'instance qui représente l'état de la +Case+
	# * Peut être ' ' (vide), 'B', (bleu) ou 'R' (rouge), 'b' (bleu hypothèse), 'r' (rouge hypothèse)
	# * Accessible en lecture uniquement
	attr :etat, false

	# Méthodes

	# * Méthode d'instance qui initialise la +Case+
	def initialize()	# :nodoc:
		@etat = ' '
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères décrivant la +Case+
	# * +Retourne+ : un +String+ décrivant la +Case+
	def to_s()		# :nodoc:
		return etat
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur bleu
	def setBleu()
		@etat = 'B'
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur rouge
	def setRouge()
		@etat = 'R'
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur vide
	def setVide()
		@etat = ' '
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met la +Case+ en état d'hypothèse
	# * <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def setHypothese()
		case @etat
		when 'R'
			@etat = 'r'
		when 'B'
			@etat = 'b'
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met la +Case+ en état de non hypothèse
	# *  <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def setNonHypothese()
		case @etat
		when 'r'
			@etat = 'R'
		when 'b'
			@etat = 'B'
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est bleue
end
