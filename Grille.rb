# encoding: UTF-8

# Nanzhen Kuang
# Modifications par Valentin CHAILLOU le 26/03/2015
# Classe Grille

# == Classe Grille :
#		- connaît son id, sa matrice départ, sa matrice courante, sa matrice correcte et son nombre minimum de clics pour arriver à résolution
#		- sait dire si elle correcte, jouer sur une Case, donner sa difficulté, donner sa taille, donner une aide
class Grille

	# Variables d'instance
	
	# * Variable d'instance accessible en lecture représentant l'unique ID de la *Grille*
	attr :idGrille, false
	
	# * Variable d'instance accessible en lecture représentant le tableau de <b>Case</b>s à deux dimensions de la *Grille*
	attr :matrice, false
	
	# * Variable d'instance accessible en lecture représentant le tableau de <b>Case</b>s à deux dimensions lorsque la *Grille* vient d'être créée
	attr :matriceDepart, false
	
	# * Variable d'instance non accessible représentant le tableau de <b>Case</b>s à deux dimensions lorsque la *Grille* est résolue
	@matriceCorrecte
	
	# * Variable d'instance (un <b>Integer</b>) représentant le nombre minimum de clics pour remplir correctement la *Grille*
	attr :nbClicMin, false
	
	# Méthode de classe

	# * Méthode de classe qui crée une nouvelle +Grille+
	# * === Attribut :
	#		- unIdGrille : un entier représentant l'ID de la Grille
	# * === Attributs :
	#		- unIdGrille : un entier représentant l'ID de la Grille
	#		- uneMatrice : un tableau de Cases à deux dimensions
	def Grille.creer(unIdGrille, uneMatrice=nil)
		new(unIdGrille, uneMatrice)
	end
	
	private_class_method :new
	
	# Méthodes d'instance

	# Méthode qui initialise les variables d'instance
	def initialize(unIdGrille, uneMatrice=nil) # :nodoc:
		@idGrille = unIdGrille
		@matriceCorrecte = BaseDeDonnees.getGrilleMatriceResolue(@idGrille)
		@matriceDepart = BaseDeDonnees.getGrilleMatrice(@idGrille)
		if uneMatrice == nil
			@matrice = BaseDeDonnees.getGrilleMatrice(@idGrille)
		else
			# Copie de la matrice => NE PAS UTILISER clone (pas de copie en profondeur)
			@matrice = []
			0.upto(taille - 1) do |unX|
				@matrice[unX] = []
				0.upto(taille - 1) do |unY|
					@matrice[unX][unY] = uneMatrice[unX][unY].copie
				end
			end
		end
		
		# Comptage du nombre de clics minimum
		@nbClicMin = 0
		0.upto(taille-1) do |i|
			0.upto(taille-1) do |j|
				if @matriceDepart[i][j].estVide?
					if @matriceCorrecte[i][j].estBleu?
						@nbClicMin += 2
					else
						@nbClicMin += 1
					end
				end
			end
		end
		
	end
	
	# * Méthode qui vérifie la matrice (remplie par le joueur) est correcte
	# * Retourne *true* si la matrice est correcte, *false* sinon
	def estCorrecte?
		return @matrice == @matriceCorrecte
	end
	
	# * Méthode d'instance qui change l'état d'une +Case+
	# * === Attributs :
	#		- unX : un entier représentant l'abscisse de la Case
	#		- unY : un entier représentant l'ordonnée de la Case
	#		- rougeOuBleu : un String parmi ceux-ci : "r", "b", "rouge", "bleu", "v", "vide" (sensible à la casse)
	# * Retourne *self*
	def jouer(unX, unY, rougeOuBleu)
		case rougeOuBleu
			when 'b', 'bleu'
				@matrice[unX][unY].setBleu
			when 'r', 'rouge'
				@matrice[unX][unY].setRouge
			when 'v', 'vide'
				@matrice[unX][unY].setVide
		end
		return self
	end
	
	# * Méthode d'instance qui retourne la difficulté de la *Grille*
	# * Retourne un *Integer* représentant la difficulté de la *Grille*
	def difficulte
		return BaseDeDonnees.getGrilleDifficulte(@idGrille)
	end
	
	# * Méthode d'instance qui retourne la taille de la *Grille*
	# * Retourne un *Integer* représentant la taille de la *Grille*
	def taille
		#return BaseDeDonnees.getGrilleTaille(@idGrille) # => Trop lent
		return @matriceDepart.size
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères représentant le temps max de la *Grille*
	# * Retourne un *String* vide
	def getTempsMaxString
		return ""
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères représentant le nombre max de clics de la *Grille*
	# * Retourne un *String* vide
	def nbClicsMaxString
		return ""
	end
	
	# * Méthode d'instance qui permet de vérifier que le nombre de clics max de la *Grille* n'est pas atteint
	# * Retourne *true*
	def verifierNbClicsMax?(unNbClics)
		return true		# Pas de limite pour les grilles normales
	end
	
	# * Méthode d'instance qui permet de vérifier que le temps max de la *Grille* n'est pas atteint
	# * Retourne *true*
	def verifierTempsMax?(unTemps)
		return true		# Pas de limite pour les grilles normales
	end
	
	# * Méthode d'instance qui retourne une aide possible en fonction de la matrice de la *Grille*
	# * Retourne un tableau contant un *String* représentant l'aide et les coordonnées de la *Case* (ou de la colonne/ligne) [String, x, y]
def obtenirAide
	
		tailleMax = @matrice.length
	
		for x in 0..tailleMax-1
			for y in 0..tailleMax-1
				#Aide si deux colonnes sont identiques
				for z in 0..tailleMax-1
				caseCom=0
					if x != Z
						if @matrice[x][y]==@matrice[z][y]
							caseCom+=1
						end
						if casCom == tailleMax-1
							return "Les colonnes #{x+1} et #{z+1} sont identiques "
						end
					end
				end
			end
		end
		
		
		for y in 0..tailleMax-1
			for x in 0..tailleMax-1
				#Aide si deux lignes sont identiques
				for z in 0..tailleMax-1
				caseCom=0
					if x != Z
						if @matrice[x][y]==@matrice[x][z]
							caseCom+=1
						end
						if casCom == tailleMax-1
							return "Les lignes #{y+1} et #{z+1} sont identiques "
						end
					end
				end
			end
		end
		
		
		
		
		
	#Application des regles sur les lignes

		#Deplacement d'une ligne a l'autre( de haut en bas).
		for i in 0..tailleMax-1
	 
			nbBleu=0
			nbRouge=0


			for j in 0..tailleMax-1
				caseActuelle = @matrice[i][j]
				#Test la couleur de la case pour les compter.
				if caseActuelle.estBleu?
					nbBleu+=1
				end
				if caseActuelle.estRouge?
					nbRouge+=1			
				end
			end


			#Verifie qu'aucune des couleurs est en surnombre.
			if nbRouge>tailleMax/2 || nbBleu>tailleMax/2
				return ["Il y a trop de case de la meme couleur dans la ligne #{i+1}", -1, -1]
			end


			#Parcours des  colonne ( de gauche a droite).
			for j in 0..tailleMax-1
				caseActuelle = @matrice[i][j]
		
		 
				if caseActuelle.estVide?

					#Test si il y a une case vide entre 2 case de la meme couleurs	(Peut etre utilisé )
					if j>0 && j<tailleMax-1
						if @matrice[i][j-1].estBleu?&&@matrice[i][j+1].estBleu? || @matrice[i][j-1].estRouge?&&@matrice[i][j+1].estRouge? 
							return ["Il y a une solution dans cette case", i, j]
						end
					end

					#Test si il deux cases de la meme couleur d'affillé a coté d'une case vide
					if j<tailleMax-2
						if @matrice[i][j+2].estBleu?&&@matrice[i][j+1].estBleu? || @matrice[i][j+2].estRouge?&&@matrice[i][j+1].estRouge? 
							return ["Il y a une solution dans cette case", i, j]
						end
					end

					if j>1
						if @matrice[i][j-2].estBleu?&&@matrice[i][j-1].estBleu? || @matrice[i][j-2].estRouge?&&@matrice[i][j-1].estRouge? 
							return ["Il y a une solution dans cette case", i, j]
						end
					end

					
				end

				

			end
			
			#Verifie si une couleur est complete
			if (nbRouge==tailleMax/2  || nbBleu==tailleMax/2) && nbBleu !=nbRouge
				return ["Une couleur est complete dans la ligne #{i+1}", -1, -1]
			end


		end
	



	#Application des regles sur les colonnes

		#Deplacement d'une colonne a l'autre( de gauche a droite).
		for j in 0..tailleMax-1
	 
			nbBleu=0
			nbRouge=0

			
			for i in 0..tailleMax-1
				caseActuelle =@matrice[i][j]
				#Test la couleur de la case pour les compter.
				if caseActuelle.estBleu?
					nbBleu+=1
				end
				if caseActuelle.estRouge?
					nbRouge+=1			
				end

			end
			
			

			#Verifie qu'aucune des couleurs est en surnombre.
			if nbRouge>tailleMax/2 || nbBleu>tailleMax/2
				return ["Il y a trop de case de la meme couleur dans la colonne #{j+1}", -1, -1]
			end


			#Parcours des  ligne ( de haut en bas).
			for i in 0..tailleMax-1
				caseActuelle =@matrice[i][j]
		
		 
				if caseActuelle.estVide?

					#Test si il y a une case vide entre 2 case de la meme couleurs	(Peut etre utilisé )
					if i>0 && i<tailleMax-1
						if @matrice[i-1][j].estBleu?&&@matrice[i+1][j].estBleu? || @matrice[i-1][j].estRouge?&&@matrice[i+1][j].estRouge? 
							return ["Il y a une solution dans cette case", i, j]
						end
					end

					#Test si il deux cases de la meme couleur d'affillé a coté d'une case vide
					if i<tailleMax-2
						if @matrice[i+2][j].estBleu?&&@matrice[i+1][j].estBleu? || @matrice[i+2][j].estRouge?&&@matrice[i+1][j].estRouge? 
							return ["Il y a une solution dans cette case", i, j]
						end
					end

					if i>1
						if @matrice[i-2][j].estBleu?&&@matrice[i-1][j].estBleu? || @matrice[i-2][j].estRouge?&&@matrice[i-1][j].estRouge? 
							return ["Il y a une solution dans cette case", i, j]
						end
					end

					#Test
				end
			end

			#Verifie si une couleur est complete
			if (nbRouge==tailleMax/2  || nbBleu==tailleMax/2) && nbBleu !=nbRouge
				return ["Une couleur est complete dans la colonne #{j+1}", -1, -1]
			end
			
			

		end

		return ["Peut-être qu une hypothèse pourrait aider...", -1, -1]
	end
	
	# * Méthode d'instance qui retourne une chaine de caractères décrivant la matrice de la *Grille*
	# * Retourne un *String* décrivant la *Grille*
	def to_s()
		0.upto(taille-1) do |i|
			0.upto(taille-1) do |x|
				print "|" + @matrice[i][x].to_s + "|"
			end
		print "\n"
		end
	end
	
end
