# encoding: UTF-8

##
# Auteur Parmenon Damien et Valentin CHAILLOU
#

class PartieMondeReussieBuilder < PartieReussieBuilder

	# Variable d'instance
	
	# * variable d'instance qui représente le +Monde+ de la +PartieMonde+
	@monde
	
	# * Variable d'instance qui représente la +PartieMonde+ qui vient d'être terminée
	@partie

	# * Méthode de classe qui crée un nouveau +PartieMondeReussieBuilder+
	def PartieMondeReussieBuilder.creer(unMonde)
		new(unMonde)
	end

	def initialize(unMonde) # :nodoc:
	
		@partie = Jeu.JEU.partie
		@monde = unMonde
		
        super()
		
		case @partie.nbEtoile
			when 0
				@nbEtoiles.file="Images/ZeroEtoile.png"
			when 1
				@nbEtoiles.file="Images/UneEtoile.png"
			when 2
				@nbEtoiles.file="Images/DeuxEtoile.png"
			when 3
				@nbEtoiles.file="Images/TroisEtoile.png"
		end
		
		@partie.remiseAZero
	end
	
	def on_button1_clicked
		ouvrirFenetre(PartieMondeBuilder.creer(@partie, @monde))
	end
	
end
