#Kuang Nanzhen
#Class Grille
#Opération sur le grille

#======Class Grille=====
#
#
require 'matrix' 
Class Grille
  #variable
  #*idGrille - l'id du grille
  #*case - matrice
  #** 0 - rien dans le case
  #** 1 - le premier couleur 
  #** 2 - le deuxieme couleur
  #*difficulte - difficulte du jeu
  #** 7 niveau de difficulte  [0-6]
  #*taille - taille de matrice
  #**4 taille de matrice
  #*** 4*4 6*6 8*8 10*10
  @idGrille
  @case
  @difficulte
  @taille
  
  def Grille.ceer(difficulte,taille)
      new(difficulte,taille)
  end

  def initialize(difficulte,taille)
    @difficulte = difficulte
    @taille = taille
    @case =Matrix.zero(taille) ; 
  end

  attr_reader :difficulte, :taille

  def estTerminer?
	@case.each do |e|
		if(e == 0)	
			return false
		end 
	end 
	return true
  end

  def to_s()
	puts @case.each{|e| puts e}
  end
  
end
