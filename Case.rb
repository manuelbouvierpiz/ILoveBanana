# Valentin CHAILLOU
# Case.rb
# Implémentation de la classe Case

# == Classe Case : 
#	- connaît son état
#	- sait se décrire (to_s), changer son état (setBleu, setRouge, setVide), donner son état (estBleu?, estRouge?, estVide?)
class Case
	
	# Variables
	
	# * Variable d'instance qui représente l'état de la +Case+
	# * Peut être 'V' (vide), 'B', (bleu) ou 'R' (rouge)
	# * Accessible en lecture (nécessaire pour la comparaison)
	attr :etat, false

	# Méthodes

	# * Méthode d'instance qui initialise la +Case+
	def initialize()	# :nodoc:
		@etat = 'V'
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères décrivant la +Case+
	# * +Retourne+ : un +String+ décrivant la +Case+
	def to_s()		# :nodoc:
		return @etat
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur bleu
	def setBleu()
		@etat = 'B'
		return self
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur rouge
	def setRouge()
		@etat = 'R'
		return self
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur vide
	def setVide()
		@etat = 'V'
		return self
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est bleue
	# * <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def estBleu?()
		return @etat == 'B'
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est rouge
	# * <b>/!\ Une case rouge n'est ni bleue ni vide mais peut être une case hypothésée /!\</b>
	def estRouge?()
		return @etat == 'R'
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est vide
	# * <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def estVide?()
		return @etat == 'V'
	end
	
	# * Méthode d'instance qui permet de comparer deux <b>Case</b>s
	def ==(uneCase)
		return @etat == uneCase.etat
	end
	
	# * Méthode d'instance qui retourne une copie de soi-même
	def clone
		unClone = Case.new
		if @etat == 'V'
			return unClone
		elsif @etat == 'R'
			return unClone.setRouge
		else
			return unClone.setBleu
		end
	end
	
end
