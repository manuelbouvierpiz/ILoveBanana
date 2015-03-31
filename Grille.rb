# Modifications par Valentin CHAILLOU le 26/03/2015
#Class Grille
#Opération sur le grille

#======Class Grille=====
#une grille pour le jeu

load 'case.rb'
class Grille
  #variable
  
  # * idGrille - l'id de la +Grille+
  attr :idGrille, false
  
  # * matrice - matrice contenant les +Case+s de la +Grille+
  attr :matrice, false
  
  #nbClicMin - nombre minimum de clics
  attr :nbClicMin, false
  
  #Méthodes
  
  # * Méthode de classe qui demande l'id de la +Grille à créer+
  def Grille.ceer(unIdGrille)
      new(unIdGrille)
  end

  # * Méthode de classe qui demande l'id de la +Grille à créer+ et la matrice (dans le cas d'une sauvegarde)
  def Grille.ceer(unIdGrille, uneMatrice)
      new(unIdGrille, uneMatrice)
  end
  # * Méthode qui initialise les variables
  def initialize(unIdGrille)
      @idGrille = unIdGrille
      @matrice = matriceDepart
      @nbClicMin = 0
      @matrice.each do |uneLigne|
      	uneLigne.each do |uneCase|
      		@nbClicsMin += 1 if uneCase.estVide?
      	end
      end
  end
  
  # * Méthode qui initialise les variables
  def initialize(unIdGrille, uneMatrice)
      @idGrille = unIdGrille
      @matrice = uneMatrice
      @nbClicMin = 0
      matriceDepart.each do |uneLigne|
      	uneLigne.each do |uneCase|
      		@nbClicsMin += 1 if uneCase.estVide?
      	end
      end
  end
  
  # * Méthode qui vérifie la matrice (remplie par le joueur) est correcte
  def estCorrecte?
  	uneMatriceCorrecte = BaseDeDonnes.getGrilleMatriceResolue(@idGrille)
  	return matrice == uneMatriceCorrecte
  end
  
  # * Méthode d'instance qui change l'état d'une +Case+
  def jouer(unX, unY, rougeOuBleu, estHypothese)
  	case rougeOuBleu.lowerCase
  		when 'b', 'bleu', 0
  			matrice[i][j].setBleu
  		when 'r', 'rouge', 1
  			matrice[i][j].setRouge
  	end
  	matrice[i][j].setHypothese if estHypothese
  end
  
  # * Méthode d'instance qui met toutes les <b>Case</b>s de la +Grille+ en état non hypothésé 
  def setNonHypothese()
  	matrice.each do |uneLigne|
  		matrice.each do |uneCase|
  			uneCase.setNonHypothese if uneCase.estHypothese?
  		end
  	end
  end
  
  #Méthode -définir une case vide
  def viderCase(x,y)
  	@matrice[x][y].setVide()
  end
  
  #Méthode - lire en base donnée et remplir dans le @matrice et @matriceCorrect pour le réponse
  def matriceDepart
  	@matrice = BaseDeDonnees.getGrilleMatrice(@idGrille)
  end
  
  # * Méthode d'instance qui retourne la diffculté de la +Grille+
  def difficulte
  	return BaseDeDonnees.getGrilleDiffculte(@idGrille)
  end
  
  # * Méthode d'instance qui retourne la taille de la +Grille+
  def taille
  	return BaseDeDonnees.getGrilleTaille(@idGrille)
  end
  
  #Méthode d'instance qui retourne +true+ si il n'y a plus de +Case+ vide, +false+ sinon
  def estTermine?
  	matrice.each do |uneLigne|
  		ligne.each do |uneCase|
  			if uneCase.estVide?
  				return false
  			end
  		end
  	end
  	
  	return true
  end
  
  # * Méthode d'instance qui retourne une chaine de caractères décrivant une aide possible
  def obtenirAide
  	# A compléter
  	return "Au maximum deux cases consécutives peuvent avoir la même couleur"
  end

  # * Méthode d'instance qui retourne une chaine de caractères décrivant la +Grille+
  def to_s()
  	 0.upto(@taille) do |i|
  	 	0.upto(@taille) do |x|
  	 		print "-"
  	 	end
  		0.upto(@taille) do |j|
  			print @matrice[i][j]
  			print "|"
  		end
  		puts " "
    end
  end
  
end
