# Valentin CHAILLOU
# GrilleHardcore.rb
# 27/02/2015

Class GrilleHarcore < Grille

  # Variables
  
  # * Variable d'instance représentant le temps maximum autorisé pour une +Partie+ sur cette +GrilleHardcore+
  # * Accessible en lecture uniquement
  # * Est intialisée lors de la création de la +GrilleHardcore+
  attr :tempsMax, false
  
  # * Variable d'instance représentant le nombre maximum de clics autorisés sur cette +GrilleHardcore+
  # * Accessible en lecture uniquement
  # * Est initialisée lors de la création de la +GrilleHardcore+
  attr :nbClicsMax, false
  
  # Méthodes
  
  # * Méthode de classe qui crée une nouvelle +GrilleHardcore+
  # * ===== Attributs :
  # - unTempsMax : un flottant représentant le temps maximum de la résolution de la +GrilleHardcore+
  # - unNbClicsMax : un entier représentant le nombre de clics maximum pour résoudre la +GrilleHardcore+
  def GrilleHardcore.creer(uneDifficulte, uneTaille, unTempsMax, unNbClicsMax)
    new(uneDiffculte, uneTaille, unTempsMax, unNbClicsMax)
  end
  
  private_method :new
  
  # Méthode d'instance qui intialise le temps maximum et le nombre maximum de clics associés à la +GrilleHardcore+
  def initialize(uneDifficulte, uneTaille, unTempsMax, unNbClicsMax)  # :nodoc
    super(uneDiffculte, uneTaille)
    tempsMax, nbClicsMax = unTempsMax, unNbClicsMax
  end

end
