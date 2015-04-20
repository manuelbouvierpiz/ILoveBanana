# Valentin CHAILLOU
# GrilleHardcore.rb
# 27/02/2015

class GrilleHardcore < Grille

  # Variables
  
  # * Variable d'instance représentant le temps maximum autorisé pour une +Partie+ sur cette +GrilleHardcore+
  # * Accessible en lecture uniquement
  # * Est intialisée lors de la création de la +GrilleHardcore+
  attr :tempsMax, false
  
  # * Variable d'instance représentant le nombre maximum de clics autorisés sur cette +GrilleHardcore+
  # * Accessible en lecture uniquement
  # * Est initialisée lors de la création de la +GrilleHardcore+
  attr :nbClicsMax, false
  
  # Méthodes d'instance
  
  # Méthode d'instance qui initialise le temps maximum et le nombre maximum de clics associés à la +GrilleHardcore+
  def initialize(unIdGrille, unTempsMax, unNbClicsMax, uneMatrice)  # :nodoc
    super(unIdGrille, uneMatrice)
    tempsMax, nbClicsMax = unTempsMax, unNbClicsMax
  end
  
  # Méthodes de classe
  
  private_class_method :new
  
  # * Méthode de classe qui crée une nouvelle +GrilleHardcore+
  # * <b>Attention à l'ordre de arguments</b>
  # ===== Attributs :
  # - unIdGrille : un entier représentant l'id de la +Grille+
  # - unTempsMax : un flottant représentant le temps maximum de la résolution de la +GrilleHardcore+
  # - unNbClicsMax : un entier représentant le nombre de clics maximum pour résoudre la +GrilleHardcore+
  # ===== Attributs :
  #	- unIdGrille : un entier représentant l'id de la +Grille+
  # - uneMatrice : une matrice de la +Grille+ sauvegardée
  # - unTempsMax : un flottant représentant le temps maximum de la résolution de la +GrilleHardcore+
  # - unNbClicsMax : un entier représentant le nombre de clics maximum pour résoudre la +GrilleHardcore+
  def GrilleHardcore.creer(unIdGrille, unTempsMax, unNbClicsMax, uneMatrice=nil)
    new(unIdGrille, unTempsMax, unNbClicsMax, uneMatrice)
  end

end
