# encoding: UTF-8

##
# Auteur Alexandre Moutel, Parmenon Damien (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

# == Classe ClassementBuilder : 
#	- est un TakuzuBuilder
#   - Permet l'affichage d'un classement en fonction d'une taille et d'une difficulté choisies par l'utilisateur
#   - Permet également l'accès aux Statistiques et aux Succès ainsi que de retourner sur le Menu Principal
class ClassementBuilder < TakuzuBuilder

    # Variables d'instance
    
    # * Variable d'instance non accessible qui permet de savoir si la taille a déjà été choisie par l'utilisateur
    # * Le classement ne s'affichera que si la taille et la difficulté ont été choisies
	@boolNiveau

    # * Variable d'instance non accessible qui permet de savoir si la difficulté a déjà été choisie par l'utilisateur
    # * Le classement ne s'affichera que si la taille et la difficulté ont été choisies
	@boolTaille

    # Méthodes d'instance

    # * Méthode d'instance qui initialise la fenêtre correspondante au *ClassementBuilder*
    # * Initialise les ComboBox pour la taille et la difficulté avec leurs models respectifs
	def initialize		# :nodoc:
		super(__FILE__)
		
		tabNiveau = [1, 2, 3, 4, 5, 6, 7]
		tabNiveau.each_with_index do |e|
  			iter = @listeNiveaux.append
  			iter[0] = e
		end
		@boxTaille.model=@listeNiveaux

		tabTaille = [6, 8, 10, 12]
		tabTaille.each_with_index do |e|
  			iter = @listeTaille.append
  			iter[0] = e
		end
		@boxTaille.model=@listeTaille

		@labelRang.set_visible(false)
    	@labelPseudo.set_visible(false)
    	@labelScore.set_visible(false)
    end

    # * Méthode d'instance qui ouvre la fenêtre des *Statistiques* si l'utilisateur clique sur le bouton correspondant
    def on_buttonStatistiques_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end

    # * Méthode d'instance qui ouvre la fenêtre des *Succes* si l'utilisateur clique sur le bouton correspondant
    def on_buttonSucces_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end

    # * Méthode d'instance qui met à la valeur *true* le booléen correspondant à la difficulté
    # * Affiche le classement correspondant aux valeurs données par l'utilisateur si le booléen de la taille est à *true* aussi
    def on_boxNiveau_changed
        @vboxClassement.each do |child|
            @vboxClassement.remove(child)
        end
    	@boolNiveau = true
    	if(@boolTaille == true)
    		@labelRang.set_visible(true)
    		@labelPseudo.set_visible(true)
    		@labelScore.set_visible(true)
    		leClassement = Compte.COMPTE.statistiques.classement(@boxTaille.active_text.to_i, @boxNiveau.active_text.to_i)
            @vboxClassement.add(Gtk::HSeparator.new)
            leClassement.each do |uneLigne|
                uneHbox = Gtk::HBox.new(true, nil)
                uneHbox.add(Gtk::Label.new(uneLigne[0].to_s,false))
                uneHbox.add(Gtk::Label.new(uneLigne[1],false))
                uneHbox.add(Gtk::Label.new(uneLigne[2].to_s,false))
                @vboxClassement.add(uneHbox)
                @vboxClassement.add(Gtk::HSeparator.new)
            end
            @vboxClassement.show_all
    	end
    end

    # * Méthode d'instance qui met à la valeur *true* le booléen correspondant à la taille
    # * Affiche le classement correspondant aux valeurs données par l'utilisateur si le booléen de la difficulté est à *true* aussi
    def on_boxTaille_changed
        @vboxClassement.each do |child|
            @vboxClassement.remove(child)
        end
    	@boolTaille = true
    	if(@boolNiveau == true)
    		@labelRang.set_visible(true)
    		@labelPseudo.set_visible(true)
    		@labelScore.set_visible(true)
    		leClassement = Compte.COMPTE.statistiques.classement(@boxTaille.active_text.to_i, @boxNiveau.active_text.to_i)
            @vboxClassement.add(Gtk::HSeparator.new)
            leClassement.each do |uneLigne|
                uneHbox = Gtk::HBox.new(true, nil)
                uneHbox.add(Gtk::Label.new(uneLigne[0].to_s,false))
                uneHbox.add(Gtk::Label.new(uneLigne[1],false))
                uneHbox.add(Gtk::Label.new(uneLigne[2].to_s,false))
                @vboxClassement.add(uneHbox)
                @vboxClassement.add(Gtk::HSeparator.new)
            end
            @vboxClassement.show_all
    	end
    end

    # * Méthode d'instance qui ouvre la fenêtre du menu principal si l'utilisateur clique sur le bouton correspondant
    def on_buttonMenuPrincipal_clicked
        ouvrirFenetre(MenuPrincipalBuilder.new)
    end
end
