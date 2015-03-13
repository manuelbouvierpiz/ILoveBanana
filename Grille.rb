#Kuang Nanzhen
#Class Grille
#Opération sur le grille

#======Class Grille=====
#
#
load 'case.rb'
Class Grille
  #variable
  #*idGrille - l'id du grille
  #*matrice - matrice de case
  #** nil - rien dans le case
  #** 0 - case bleu
  #** 1 - case rouge
  #matriceCorrect -matrice de reponse
  #*difficulte - difficulte du jeu
  #** 7 niveau de difficulte  [0-6]
  #*taille - taille de matrice
  #**4 taille de matrice
  #*** 4*4 6*6 8*8 10*10
  @idGrille
  @matrice
  @matriceCorrect
  @nbClicMin
  @difficulte
  @taille
  
  def Grille.ceer(difficulte,taille)
      new(difficulte,taille)
  end

  def initialize(difficulte,taille)
    @difficulte = difficulte
    @taille = taille
    @matrice = new Case[][]
    @matriceCorrect = new Case[][]
  end

  attr_reader :difficulte, :taille
  
  def estCorrect?
  	if estTerminer?
  		if(@matrice == @matriceCorrect) #matrice est pareil avec matrice correct
  			return true
  		else
  			return false
  		end
  	end
  	return false
  end
  
  def jouer(x,y,etat)
  	if(etat.estBleu?)
  		@matric[x,y] =0
  	else(etat.estRouge?)
  		
  end
  
  def videCase(x,y)
  	@matrice[x][y].setVide()
  end
  
  def nbClicMin()
  	
  end
  
  def matriceDepart()
  	
  end
  
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
