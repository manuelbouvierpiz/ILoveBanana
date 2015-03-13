#Kuang Nanzhen
#Class Grille
#Opération sur le grille

#======Class Grille=====
#une grille pour le jeu

load 'case.rb'
Class Grille
  #variable
  
  #*idGrille - l'id du grille
  @idGrille
  
  #*matrice - matrice de case
  #** 'v' ou 'V' - rien dans le case
  #** 'r' ou 'R' - case rouge
  #** 'b' ou 'B' - case bleu
  @matrice
  #@matricePrecedent - matrice precedent
  @matricePrecedent
  #matriceCorrect -matrice de reponse
  @matriceCorrect
  
  #nbClicMin - nombre cliqué minimum 
  @@nbClicMin =0
  
  #*difficulte - difficulte du jeu
  #** 7 niveau de difficulte  [0-6]
  @difficulte
  
  #*taille - taille de matrice
  #**4 taille de matrice
  #*** 4*4 6*6 8*8 10*10
  @taille
  
  #Méthode
  
  #* Méthode demande le difficulte de grille et le taille d grille 
  def Grille.ceer(difficulte,taille)
      new(difficulte,taille)
      @matrice = new Case[][]
      @matricePrecedent = new Case[][]
      @matriceCorrect = new Case[][]
  end

  #* Méthode qui initialise les variable
  def initialize(difficulte,taille)
      @difficulte = difficulte
      @taille = taille
      @matrice = Case[taille][taille]
      @matricePrecedent = Case[taille][taille]
      @matriceCorrect = Case[taille][taille]
  end
  
  attr_reader :difficulte, :taille
  
  #Méthod vérifier le matrice ( remplié par les joueur)  est correspondant à l matrice correct
  def estCorrect?
  	if estTerminer?
  		#matrice est pareil avec matrice correct
  		if(@matrice == @matriceCorrect)
  			return true
  		else
  			return false
  		end
  	end
  	return false
  end
  
  #Méthode changer le état d'une case
  def jouer(x,y,piece)
  	if(piece=='B' || piece == 'b')
  		@matric[x][y].setBleu()
  	elsif(piece=='R' || piece == 'r')
  		@matrice[x][y].setRouge()
  	else
  		@matrice[x][y].setVide()
  		
  end
  
  #Méthode -définir une case vide
  def videCase(x,y)
  	@matrice[x][y].setVide()
  end
  
  #Méthode - calculer le nombre de clique minimum
  def nbClicMin()
  	
  end
  
  #Méthode - lire en base donnée et remplir dans le @matrice et @matriceCorrect pour le réponse
  def matriceDepart()
  	
  end
  
  #Méthode -rendre s'il y a pas case vide, le joue est terminé
  def estTerminer?
  	0.upto(taille) do i
  		0.upto(taille) do j
  			if(@matrice[i][j].estVide()?)
  				return false
  			end
  		end
  	end
	return true
  end

  def to_s()
  	
  end
  
end
