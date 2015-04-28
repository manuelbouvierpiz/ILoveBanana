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
				@labelEtoile.set_text("Il vous fallait un score supérieur ou égal à #{@partie.scoreEtoileUn} pour débloquer la première étoile.")
			when 1
				@nbEtoiles.file="Images/UneEtoile.png"
				@labelEtoile.set_text("Il vous fallait un score supérieur ou égal à #{@partie.scoreEtoileDeux} pour débloquer la seconde étoile.")
			when 2
				@nbEtoiles.file="Images/DeuxEtoile.png"
				@labelEtoile.set_text("Il vous fallait un score supérieur ou égal à #{@partie.scoreEtoileTrois} pour débloquer la troisième étoile.")
			when 3
				@nbEtoiles.file="Images/TroisEtoile.png"
				@labelEtoile.set_text("Vous avez débloqué toutes les étoiles sur ce niveau.")
		end
		
		@partie.remiseAZero
		@button4.show
	end
	
	def on_button1_clicked
		ouvrirFenetre(PartieMondeBuilder.creer(@partie, @monde))
	end

	def on_button4_clicked
		ouvrirFenetre(ChoixGrilleBuilder.creer(@monde))
	end
	
end
