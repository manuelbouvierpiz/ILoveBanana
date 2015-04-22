# Modifications par Valentin CHAILLOU le 26/03/2015
#Class Grille
#Opération sur le grille

#======Class Grille=====
#une grille pour le jeu

class Grille
  #variable
  
  # * idGrille - l'id de la +Grille+
  attr :idGrille, false
  
  # * matrice - matrice contenant les +Case+s de la +Grille+
  attr :matrice, false
  
  # * matriceDepart - matrice contenant les +Case+s de la +Grille+ au début d'une partie
  attr :matriceDepart, false
  
  # * matriceCorrecte - matrice contenant les +Case+s de la +Grille+ terminée
  @matriceCorrecte
  
  #nbClicMin - nombre minimum de clics
  attr :nbClicMin, false
  
  #Méthodes

  # * Méthode de classe crée une nouvelle +Grille+
  # ===== Attributs :
  #		- unIdGrille : un entier représentant l'ID de la Grille
  # ===== Attributs :
  #		- unIdGrille : un entier représentant l'ID de la Grille
  #		- uneMatrice : un tableau de Cases à deux dimensions
  def Grille.creer(unIdGrille, uneMatrice=nil)
		new(unIdGrille, uneMatrice)
  end

  # * Méthode qui initialise les variables
  def initialize(unIdGrille, uneMatrice=nil) # :nodoc:
  		@idGrille = unIdGrille
		@matriceCorrecte = BaseDeDonnees.getGrilleMatriceResolue(@idGrille)
		@matriceDepart = BaseDeDonnees.getGrilleMatrice(@idGrille)
		if uneMatrice == nil
			@matrice = BaseDeDonnees.getGrilleMatrice(@idGrille)
		else
			# Copie de la matrice => NE SURTOUT PAS UTILISER clone (pas de copie en profondeur)
			@matrice = []
			0.upto(taille - 1) do |unX|
				@matrice[unX] = []
				0.upto(taille - 1) do |unY|
					@matrice[unX][unY] = uneMatrice[unX][unY].copie
				end
			end
		end
		@nbClicMin = 0
		i = 0
		j = 0
		@matriceDepart.each do |uneLigne|
			uneLigne.each do |uneCase|
				if(uneCase.estVide?)
					@nbClicMin += 1 
					@nbClicMin += 1 if @matriceCorrecte[i][j].estBleu?()
				end
				j += 1
			end
			i += 1
			j = 0
		end
  end
  
  # * Méthode qui vérifie la matrice (remplie par le joueur) est correcte
  def estCorrecte?
	return @matrice == @matriceCorrecte
  end
  
  # * Méthode d'instance qui change l'état d'une +Case+
  # ===== Attributs :
  #		- unX : un entier représentant l'abscisse de la Case
  #		- unY : un entier représentant l'ordonnée de la Case
  #		- rougeOuBleu : un String parmi ceux-ci : "r", "b", "rouge", "bleu", "v", "vide" (sensible à la casse)
  def jouer(unX, unY, rougeOuBleu)
	case rougeOuBleu
		when 'b', 'bleu'
			@matrice[unX][unY].setBleu
		when 'r', 'rouge'
			@matrice[unX][unY].setRouge
		when 'v', 'vide'
			@matrice[unX][unY].setVide
	end
  end
  
  # * Méthode d'instance qui retourne la diffculté de la +Grille+
  def difficulte
	return BaseDeDonnees.getGrilleDifficulte(@idGrille)
  end
  
  # * Méthode d'instance qui retourne la taille de la +Grille+
  def taille
	#return BaseDeDonnees.getGrilleTaille(@idGrille) # => Trop lent
	return @matriceDepart.size
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
	 tailleMax = @matrice.length
  
	 colonnes = Array.new(tailleMax)  #Tableau contenant les colonnes
	 lignes = Array.new(tailleMax)    #Tableau contenant les lignes

  #Application des regles sur les colones

  #Deplacement d'une colonne a l'autre( de gauche a droite).
  for i in 0..tailleMax
	 
	 nbBleu=0
	 nbRouge=0
	
	 colonne =Array.new(tailleMax) #Colonne actuel contenant l'etat des cases (R ouge , B leu  , V ide)


	 #Parcours de la colonne ( de haut en bas).
	for j in 0..tailleMax
		caseActuelle = @matrice[i][j]
		
		 
		if @matrice[i][j].estVide?
			colonne[j]="V"

		#Test si il y a une case vide entre 2 case de la meme couleurs  (Peut etre utilisé )
		 if j>0 && j<tailleMax-1
			if @matrice[i][j-1].estBleu?&&@matrice[i][j+1].estBleu? || @matrice[i][j-1].estRouge?&&@matrice[i][j+1].estRouge? 
			  return "Il n'y a que une solution en "+i.to_s+" "+j.to_s
			end
		 end

	  #Test si il deux cases de la meme couleur d'affillé a coté d'une case vide
		 if j<tailleMax-2
			if @matrice[i][j+2].estBleu?&&@matrice[i][j+1].estBleu? || @matrice[i][j+2].estRouge?&&@matrice[i][j+1].estRouge? 
			  return "Il n'y a que une solution en "+i.to_s+" "+j.to_s
			end
		 end

		 if j>1
			if @matrice[i][j-2].estBleu?&&@matrice[i][j-1].estBleu? || @matrice[i][j-2].estRouge?&&@matrice[i][j-1].estRouge? 
			  return "Il n'y a que une solution en "+i.to_s+" "+j.to_s
			end
		 end

	  #Test la couleur de la case pour les compter.
	  end

		if caseActuelle.estBleu?
			colonne[j]="B"
			nbBleu+=1
	  end
	  if caseActuelle.estRouge?
		 colonne[j]="R"
		 nbRouge+=1      
		end

	  end
	 colonnes[i]=colonne


	 #Verifie qu'aucune des couleurs est en surnombre.
	 if nbRouge>tailleMax/2 || nbBleu>tailleMax/2
		return "Il y a trop de case de la meme couleur dans la ligne"
	 end

  end
  



#Application des regles sur les colonnes

#Deplacement d'une ligne a l'autre( de haut en bas).
  for j in 0..tailleMax
	 
	 nbBleu=0
	 nbRouge=0
		
	 ligne = Array.new(tailleMax)


	 #Parcours de la ligne ( de gauche a droite).
	 for i in 0..tailleMax
		caseActuelle =@matrice[i][j]
		
		 
		if caseActuelle.estVide?
			ligne[i]="V"

		#Test si il y a une case vide entre 2 case de la meme couleurs  (Peut etre utilisé )
		 if i>0 && i<tailleMax-1
			if @matrice[i-1][j].estBleu?&&@matrice[i+1][j].estBleu? || @matrice[i-1][j].estRouge?&&@matrice[i+1][j].estRouge? 
			  return "Il n'y a que une solution en "+i.to_s+" "+j.to_s
			end
		 end

	  #Test si il deux cases de la meme couleur d'affillé a coté d'une case vide
		 if i<tailleMax-2
			if @matrice[i+2][j].estBleu?&&@matrice[i+1][j].estBleu? || @matrice[i+2][j].estRouge?&&@matrice[i+1][j].estRouge? 
			  return "Il n'y a que une solution en "+i.to_s+" "+j.to_s
			end
		 end

		 if i>1
			if @matrice[i-2][j].estBleu?&&@matrice[i-1][j].estBleu? || @matrice[i-2][j].estRouge?&&@matrice[i-1][j].estRouge? 
			  return "Il n'y a que une solution en "+i.to_s+" "+j.to_s
			end
		 end

	  #Test
	  end

	 if caseActuelle.estBleu?
	 	ligne[i]="B"
		nbBleu+=1
	 end
	 if caseActuelle.estRouge?
		ligne[i]="R"
		nbRouge+=1      
	 end

	 end
	 if nbRouge>tailleMax/2 || nbBleu>tailleMax/2
		return "Il y a trop de case de la meme couleur dans la colonne"
	 end

	 lignes[j]=ligne

  end

  for x in 0..tailleMax
  	for y in 0..tailleMax

=begin
   
   #Tentative d'aide quand 2 case sont vide et que le reste est identique ou avec une seul case vide


      nbVide=0

      for z in 0..tailleMax
          colonneActuel=colonnes[x]
         
          
         if caseActuelle[z].estVide?
            nbVide+=1
         end
         if nbVide>2
            z=tailleMax
            y=tailleMax
         end
      end
=end


	#Aide si 2 colonnes ou lignes sont identiques

  		if x != y
  			if colonnes[x]==colonnes[y]
  			return "Deux colonnes ne doivent pas etre identique."
  			end
  			if lignes[x]==lignes[y]
  			return "Deux lignes ne doivent pas etre identique."
  			end
  		end
  		
  	end
  end

  





	return "Il n'y a pas de regles applicable"
  end

  # * Méthode d'instance qui retourne une chaine de caractères décrivant la +Grille+
  def to_s()
	0.upto(taille-1) do |i|
		0.upto(taille-1) do |x|
			print "|" + @matrice[i][x].to_s + "|"
		end
		print "\n"
	 end
  end
  
end
