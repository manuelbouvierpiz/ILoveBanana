# encoding: UTF-8

##
# Auteur Alexandre Moutel, Damien Parmenon (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe StatistiquesBuilder : 
#   - Permet à l'utilisateur de d'avoir accès aux statistiques le concernant tel que le temps de jeu et ses différents score
class StatistiquesBuilder < TakuzuBuilder

    # Variables
    
    # * Variable d'instance qui permet de savoir si la taille a déjà été choisie par l'utilisateur
    # * Les statistiques demandées ne s'afficheront que si la taille et la difficulté ont été choisies
    @boolTaille

    # * Variable d'instance qui permet de savoir si la difficulté a déjà été choisie par l'utilisateur
    # * Les statistiques demandées ne s'afficheront que si la taille et la difficulté ont été choisies
    @boolNiveau

    # Méthodes

    # * Méthode d'instance qui initialise la fenêtre correspondante à +StatistiquesBuilder+
    # * Cette méthode va chercher dans la base de données les différentes statistiques à afficher
	def initialize
		super(__FILE__, "Statistiques")
		@labelTempsJeu.set_text("Temps passé en jeu : " + "#{Compte.COMPTE.statistiques.tempsTotalJeu}")
		@labelPetitClic.set_text("Plus petit nombre de clics : " + "#{Compte.COMPTE.statistiques.plusPetitNombreClic}")
		@labelGrandClic.set_text("Plus grand nombre de clics : " + "#{Compte.COMPTE.statistiques.plusGrandNombreClic}")

        tabNiveau = [1, 2, 3, 4, 5, 6, 7]
        tabNiveau.each_with_index do |e|
            iter = @listeNiveaux.append
            iter[0] = e
        end
        @boxNiveau.model=@listeNiveaux

        tabTaille = [6, 8, 10, 12]
        tabTaille.each_with_index do |e|
            iter = @listeTaille.append
            iter[0] = e
        end
        @boxTaille.model=@listeTaille
		
    end

    # * Méthode d'instance qui ouvre +ClassementBuilder+ si l'utilisateur clique sur le bouton correspondant
    def on_buttonClassement_clicked
    	ouvrirFenetre(ClassementBuilder.new)
    end

    # * Méthode d'instance qui ouvre +SuccesBuilder+ si l'utilisateur clique sur le bouton correspondant
    def on_buttonSucces_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end

    # * Méthode d'instance qui ouvre +MenuPrincipalBuilder+ si l'utilisateur clique sur le bouton correspondant
    def on_buttonMenuPrincipal_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new)
    end

    # * Méthode d'instance qui met à la valeur true le booléen correspondant à la difficulté
    # * Affiche les statistiques correspondant aux valeurs données par l'utilisateur si le booléen de la taille est à true aussi
    def on_boxNiveau_changed
        @boolNiveau = true
        if(@boolTaille == true)
            @labelResultat.set_text("#{Compte.COMPTE.statistiques.scoreDifficulte(@boxTaille.active_text.to_i, @boxNiveau.active_text.to_i)}")
        end
    end

    # * Méthode d'instance qui met à la valeur true le booléen correspondant à la taille
    # * Affiche les statistiques correspondant aux valeurs données par l'utilisateur si le booléen de la difficulté est à true aussi
    def on_boxTaille_changed
        @boolTaille = true
        if(@boolNiveau == true)
            @labelResultat.set_text("#{Compte.COMPTE.statistiques.scoreDifficulte(@boxTaille.active_text.to_i, @boxNiveau.active_text.to_i)}")
        end
    end
end
