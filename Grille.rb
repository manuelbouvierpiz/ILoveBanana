# Modifications par Valentin CHAILLOU le 26/03/2015
#Class Grille
#Opération sur le grille

#======Class Grille=====
#une grille pour le jeu

load 'Case.rb'
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
  def Grille.creer(unIdGrille)
      new(unIdGrille)
  end

  # * Méthode de classe qui demande l'id de la +Grille à créer+ et la matrice (dans le cas d'une sauvegarde)
  def Grille.creer(unIdGrille, uneMatrice)
  
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
    tailleMax = @matrice.lenght
  

  #Application des regles sur les colones

  #Deplacement d'une colonne a l'autre( de gauche a droite).
  for i in [0..tailleMax]
    
    nbBleu=0
    nbRouge=0
  	
    #Parcours de la colonne ( de haut en bas).
  	for j in [0..tailleMax]
      caseActuelle =@matrice[i][j]
      
       
      if caseActuelle.estVide?


      #Test si il y a une case vide entre 2 case de la meme couleurs  (Peut etre utilisé )
       if j>0 && j<tailleMax
         if @matrice[i][j-1].estBleu?&&@matrice[i][j+1].estBleu? || @matrice[i][j-1].estRouge?&&@matrice[i][j+1].estRouge? 
           return "Il n'y a que une solution"
         end
       end

     #Test si il deux case de la meme couleur d'affillé a coté d'une case vide
       if j<tailleMax-1
         if @matrice[i][j+2].estBleu?&&@matrice[i][j+1].estBleu? || @matrice[i][j+2].estRouge?&&@matrice[i][j+1].estRouge? 
           return "Il n'y a que une solution"
         end
       end

       if j>1
         if @matrice[i][j-2].estBleu?&&@matrice[i][j-1].estBleu? || @matrice[i][j-2].estRouge?&&@matrice[i][j-1].estRouge? 
           return "Il n'y a que une solution"
         end
       end

     #Test
     end

    if caseActuelle.estBleu?
      nbBleu+=1
    end
    if caseActuelle.estRouge?
      nbRouge+=1      
    end

 	  end
    #Verifie qu'aucune des couleurs est en surnombre.
    if nbRouge>tailleMax/2 || nbBleu>tailleMax/2
      return "Il y a trop de case de la meme couleur"
    end

  end



#Application des regles sur les lignes

#Deplacement d'une ligne a l'autre( de haut en bas).
  for j in [0..tailleMax]
    
    nbBleu=0
    nbRouge=0
    
    #Parcours de la ligne ( de gauche a droite).
    for i in [0..tailleMax]
      caseActuelle =@matrice[i][j]
      
       
      if caseActuelle.estVide?


      #Test si il y a une case vide entre 2 case de la meme couleurs  (Peut etre utilisé )
       if i>0 && i<tailleMax
         if @matrice[i-1][j].estBleu?&&@matrice[i+1][j].estBleu? || @matrice[i-1][j].estRouge?&&@matrice[i+1][j].estRouge? 
           return "Il n'y a que une solution"
         end
       end

     #Test si il deux case de la meme couleur d'affillé a coté d'une case vide
       if i<tailleMax-1
         if @matrice[i+2][j].estBleu?&&@matrice[i+1][j].estBleu? || @matrice[i+2][j].estRouge?&&@matrice[i+1][j].estRouge? 
           return "Il n'y a que une solution"
         end
       end

       if i>1
         if @matrice[i-2][j].estBleu?&&@matrice[i-1][j].estBleu? || @matrice[i-2][j].estRouge?&&@matrice[i-1][j].estRouge? 
           return "Il n'y a que une solution"
         end
       end

     #Test
     end

    if caseActuelle.estBleu?
      nbBleu+=1
    end
    if caseActuelle.estRouge?
      nbRouge+=1      
    end

    end
    if nbRouge>tailleMax/2 || nbBleu>tailleMax/2
      return "Il y a trop de case de la meme couleur"
    end







  	return "Au maximum deux cases consecutives peuvent avoir la meme couleur"
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
