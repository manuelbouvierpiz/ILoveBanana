# Valentin CHAILLOU
# GrilleHardcore.rb
# 27/02/2015

# == Classe +GrilleHardcore+ :
#		- est une +Grille+
#		- connaît son temps max et son nombrede clics max
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
  def initialize(unIdGrille, uneMatrice)  # :nodoc
    super(unIdGrille, uneMatrice)
    @tempsMax = BaseDeDonnees.getGrilleTempsMax(@idGrille)
	@nbClicsMax = BaseDeDonnees.getGrilleNbClicsMax(@idGrille)
  end
  
  # * Méthode d'instance qui renvoie la difficulté de la +GrilleHardcore+
  # * Retourne 8
  def difficulte
	return 8
  end

end
