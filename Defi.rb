# Valentin CHAILLOU
# Defi.rb
# Implémentation de la classe Defi

# == Classe Defi :
#	- connaît son envoyeur, son destinataire, sa grille
#	- sait relever un défi, supprimer un défi, donne le score de l'envoyeur
class Defi
  
  # Variables d'instance
  
  # * Variable d'instance qui représente l'envoyeur (+Compte+) du +Defi+
  # * Est initialisée lors de la création de l'objet
  # * Accessible en lecture uniquement
  attr :envoyeur, false
  
  # * Variable d'instance qui représente le destinataire (+Compte+) du +Defi+
  # * Est initialisée lors de la création de l'objet
  # * Accessible en lecture uniquement
  attr :destinataire, false
  
  # * Variable d'instance qui représente la +Grille+ du +Defi+
  # * Est intialisée lors de la création de l'objet
  # * Accessible en lecture uniquement
  attr :grille, false
  
  # Méthodes d'instance
  
  # * Méthode d'instance qui relève un +Defi+
  # * crée une nouvelle +Partie+ dans le +Jeu+
  # * Retourne la +Partie+ en cours dans le +Jeu+
  def relever
  	Jeu.JEU.partie = PartieRapide.creer(@grille.idGrille)
  	return Jeu.JEU.partie
  end
  
  # * Méthode d'instance qui supprime le défi courant
  # * Supprime le +Defi+ dans la BDD et l'objet
  # * Retourne nil
  def supprimer!
  	BaseDeDonnees.supprimeDefi(@destinataire.pseudo, @envoyeur.pseudo, Grille.idGrille)
  	self = nil
  	return nil
  end
  
  # * Méthode d'instance qui retourne le score réalisé par l'envoyeur pour le +Defi+
  # * Recherche le score de l'envoyeur dans la BDD
  # * Retourne un entier représentant le score de l'envoyeur
  def score
  	return BaseDeDonnees.getDefiScore(envoyeur.pseudo, destinataire.pseudo, grille.idGrille)
  end
  
  def initialize(unEnvoyeur, unDestinataire, uneGrille, unScore) # :nodoc:
  	@envoyeur, @destinataire, @grille = unEnvoyeur, unDestinataire, uneGrille
  	BaseDeDonnees.setDefi(@envoyeur, @destinataire, @grille, unScore)
  end
  
  # Méthode de classe
  
  # * Méthode de classe permettant de créer un +Defi+
  # ===== Attributs :
  #		- unEnvoyeur : le Compte de l'envoyeur
  #		- unDestinataire : le Compte du destinataire
  #		- uneGrille : la Grille du Defi
  #		- unScore : un entier représentant le score réalisé par l'envoyeur
  def Defi.creer(unEnvoyeur, unDestinataire, uneGrille, unScore)
  	new(unEnvoyeur, unDestiantaire, uneGrille, unScore)
  end
  
  private_class_method :new
end
