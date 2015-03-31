# Valentin CHAILLOU
# Case.rb
# Implémentation de la classe Case

# == Classe Case : 
#	- connaît son état
#	- sait se décrire (to_s), changer son état (setBleu, setRouge, setVide, setHypothese, setNonHypothese), donner son état (estBleu?, estRouge?, estVide?, estHypothese?)
class Case
	
	# Variables
	
	# * Variable d'instance qui représente l'état de la +Case+
	# * Peut être 'V' (vide), 'B', (bleu) ou 'R' (rouge), 'v' (vide hypothèse), 'b' (bleu hypothèse), 'r' (rouge hypothèse)
	# * Accessible en lecture uniquement
	attr :etat, false

	# Méthodes

	# * Méthode d'instance qui initialise la +Case+
	def initialize()	# :nodoc:
		@etat = 'V'
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères décrivant la +Case+
	# * +Retourne+ : un +String+ décrivant la +Case+
	def to_s()		# :nodoc:
		return etat
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur bleu
	def setBleu()
		if estHypothese?
			@etat = 'b'
		else
			@etat = 'B'
		end
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur rouge
	def setRouge()
		if estHypothese?
			@etat = 'r'
		else
			@etat = 'R'
		end
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met l'état de la +Case+ sur vide
	def setVide()
		if estHypothese?
			@etat = 'v'
		else
			@etat = 'V'
		end
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met la +Case+ en état d'hypothèse
	# * <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def setHypothese()
		@etat.downcase!
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui met la +Case+ en état de non hypothèse
	# *  <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def setNonHypothese()
		@etat.upcase!
		return self	# Pour éviter l'entorse à l'encapsulation
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est bleue
	# * <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def estBleu?()
		unResultat = false
		if @etat.upcase == 'B'
			unResultat = true
		end
		return unResultat
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est rouge
	# * <b>/!\ Une case rouge n'est ni bleue ni vide mais peut être une case hypothésée /!\</b>
	def estRouge?()
		unResultat = false
		if @etat.upcase == 'R'
			unResultat = true
		end
		return unResultat
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est vide
	# * <b>/!\ Une case bleue n'est ni rouge ni vide mais peut être une case hypothésée /!\</b>
	def estVide?()
		unResultat = false
		if @etat.upcase == 'V'
			unResultat = true
		end
		return unResultat
	end
	
	# * Méthode d'instance qui renvoie +true+ si la +Case+ est en état d'hypothèse
	# * <b>/!\ Une case hypothésée peut être bleue, rouge ou vide /!\</b>
	def estHypothese?()
		unResultat = false
		if @etat.downcase == @etat	# Si c'est une minuscule, la Case est en état d'hypothèse
			unResultat = true
		end
		return unResultat
	end
end
