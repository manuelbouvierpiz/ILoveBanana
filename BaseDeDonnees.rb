##
# Auteur RONAN YZEUX
# Version 0.1 : Date : Sat Mar 14 15:57:38 CET 2015
#
require "digest/md5"
require "active_record"

# == Classe BaseDeDonnees :
#		- sait donner accès en lecture et écriture à des tables de la base de données
class BaseDeDonnees
	ActiveRecord::Base.establish_connection(
		:adapter => "mysql2",
		:database => "ronan",
		:username => "ronan",
		:password => "ronan",
			:host => "vps120906.ovh.net"
	)
   
	private_class_method :new
		
	# Méthodes de classe
		
	# * Méthode de classe qui renvoie le score d'un joueur sur une *Grille*
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idGrille : un entier représentant l'identifiant de la Grille
	# * Retourne un entier représentant le score du joueur sur la *Grille* ou -1 si il n'a pas de score
	def BaseDeDonnees.getScore(pseudo, idGrille)
		if(BaseDeDonnees.estGrilleResolue?(pseudo, idGrille))
			return GrilleFinis.select(:score).find_by(pseudo: pseudo, id_grille: idGrille).score
		end
		return -1
	end
	
	# * Méthode de classe qui renvoie le temps d'un joueur sur une *Grille*
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idGrille : un entier représentant l'identifiant de la Grille
	# * Retourne un entier représentant le temps en secondes du joueur sur la *Grille* ou -1 si il n'a pas de temps enregistré
	def BaseDeDonnees.getTemps(pseudo, idGrille)
		return GrilleFinis.select(:temps).find_by(pseudo: pseudo, id_grille: idGrille).temps
	end
	
	# * Méthode de classe qui indique si le joueur a fini une grille (vrai ou faux)
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idGrille : un entier représentant l'identifiant de la Grille
	# * Retourne *true* si le joueur a terminé la *Grille* dont l'ID a été passé en paramètre
	def BaseDeDonnees.estGrilleResolue?(pseudo, idGrille)
		return GrilleFinis.exists?(:pseudo => pseudo, :id_grille => idGrille)
	end
	
	# * Méthode de classe qui insert le résultat d'un joueur sur une *Grille* ou le met à jour si déjà fait au moins une fois
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idGrille : un entier représentant l'identifiant de la Grille
	#		- temps : un entier représentant le temps en seconde qu'a mis le joueur pour effectuer la Grille
	#		- nbClics : un entier représentant le nombre de clics qu'a faits le joueur
	#		- nbEtoiles : un entier représentant le nombre d'étoiles obtenues par le joueur
	#		- nbHypotheses : un entier qui représente le nombre d'hypothèses effectuées par le joueur
	#		- nbAides : un entier représentant le nombre d'aides demandées par le joueur
	#		- score : un entier représentant le score du joueur sur la Grille
	# * Retourne *self*
	def BaseDeDonnees.setGrilleTermine(pseudo, idGrille, temps, nbClics, nbEtoiles, nbHypotheses, nbAides, score)
		if(BaseDeDonnees.estGrilleResolue?(pseudo, idGrille))
			GrilleFinis.where(:pseudo => pseudo, :id_grille => idGrille).update_all(nb_clic: nbClics, nb_etoile: nbEtoiles, nb_hypothese: nbHypotheses, nb_aide: nbAides, score: score)
		else
			grilleFini = GrilleFinis.new
			grilleFini.pseudo = pseudo
			grilleFini.id_grille = idGrille
			grilleFini.temps = temps
			grilleFini.nb_clic = nbClics
			grilleFini.nb_etoile = nbEtoiles
			grilleFini.nb_hypothese = nbHypotheses
			grilleFini.nb_aide = nbAides
			grilleFini.score = score
			grilleFini.save
		end
		return self
	end
	
	# * Méthode de classe qui renvoie le nombre de clics effectués par le joueur sur une *Grille*
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	# * Retourne un entier représentant le nombre de clics effectués par le joueur sur la *Grille*
	def BaseDeDonnees.getNbClics(pseudo, idGrille)
		return GrilleFinis.select(:nb_clic).find_by(pseudo: pseudo, id_grille: idGrille).nb_clic
	end
	
	# * Méthode de classe qui renvoie l'adresse mail du possesseur du *Compte* dont on a donné le pseudo
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un *String* représentant le mail associé au *Compte*
	def BaseDeDonnees.getMail(pseudo)
		return Comptes.select(:adresse_mail).find_by_pseudo(pseudo).adresse_mail
	end
	
	# * Méthode de classe qui renvoie le nom du possesseur du *Compte* dont on a donné le pseudo
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un *String* représentant le nom du possesseur du *Compte*
	def BaseDeDonnees.getNom(pseudo)
		return Comptes.select(:nom).find_by_pseudo(pseudo).nom
	end
	
	# * Méthode de classe qui renvoie la couleur associée à la première couleur (rouge par défaut) du *Compte* dont on a donné le pseudo
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un *String* de la forme "#RRGGBB"représentant la première couleur du possesseur du *Compte*
	def BaseDeDonnees.getPrenom(pseudo)
		return Comptes.select(:prenom).find_by_pseudo(pseudo).prenom
	end
	
	# * Méthode de classe qui renvoie le prénom du possesseur du *Compte*
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un *String* représentant le prénom du possesseur du *Compte*
	def BaseDeDonnees.getCouleurUn(pseudo)
		return Comptes.select(:couleur_1).find_by_pseudo(pseudo).couleur_1
	end
	
	# * Méthode de classe qui permet de savoir si le mot de passe donné est bien celui du *Compte* dont on a donné le pseudo
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- motDePasse : un String représentant le mot de passe du joueur
	# * Retourne *true* si les identifiants sont corrects, *false* sinon
	def BaseDeDonnees.estBonsIdentifiants?(pseudo, motDePasse)
		mdpCrypte = Digest::MD5.hexdigest(motDePasse)
		return Comptes.exists?(:pseudo => pseudo, :mot_de_passe => mdpCrypte)
	end
	
	# * Méthode de classe qui permet d'attribuer une couleur en tant que première couleur du *Compte* dont on a donné le pseudo
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- couleur : un String de la forme "#RRGBB" représentant la couleur du joueur
	# * Retourne *self*
	def BaseDeDonnees.setCouleurUn(pseudo, couleur)
		Comptes.where(:pseudo => pseudo).update_all(couleur_1: couleur)
		return self
	end
	
	# * Méthode de classe qui renvoie la couleur associée à la seconde couleur (bleu par défaut) du *Compte* dont on a donné le pseudo
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un *String* de la forme "#RRGGBB"représentant la seconde couleur du possesseur du *Compte*
	def BaseDeDonnees.getCouleurDeux(pseudo)
		return Comptes.select(:couleur_2).find_by_pseudo(pseudo).couleur_2
	end
	
	# * Méthode de classe qui permet d'attribuer une couleur en tant que première couleur du *Compte* dont on a donné le pseudo
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- couleur : un String de la forme "#RRGBB" représentant la couleur du joueur
	# * Retourne *self*
	def BaseDeDonnees.setCouleurDeux(pseudo, couleur)
		Comptes.where(:pseudo => pseudo).update_all(couleur_2: couleur)
		return self
	end
	
	# * Méthode de classe qui permet de changer le mot de passe du *Compte* dont on a donné le pseudo
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- motDePasse : un String représentant le nouveau mot de passe du joueur
	# * Retourne *self*
	def BaseDeDonnees.setMotDePasse(pseudo, motDePasse)
		mdpCrypte = Digest::MD5.hexdigest(motDePasse)
		Comptes.where(:pseudo => pseudo).update_all(mot_de_passe: mdpCrypte)
		return self
	end
	
	# * Méthode de classe qui renvoie le volume de la musique du *Compte* dont on a donné le pseudo
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le volume du *Compte*
	def BaseDeDonnees.getVolumeMusique(pseudo)
		return Comptes.select(:volume_musique).find_by_pseudo(pseudo).volume_musique
	end
	
	# * Méthode de classe qui permet de modifier le volume de la musique du *Compte* dont on a donné le pseudo
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- volume : un entier représentant le volume de la musique souhaité
	# * Retourne *self*
	def BaseDeDonnees.setVolumeMusique(pseudo, volume)
		Comptes.where(:pseudo => pseudo).update_all(volume_musique: volume)
		return self
	end
	
	# * Méthode de classe qui renvoie le volume des bruitages du *Compte* dont on a donné le pseudo
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le volume du *Compte*
	def BaseDeDonnees.getVolumeBruitage(pseudo)
		return Comptes.select(:volume_bruitage).find_by_pseudo(pseudo).volume_bruitage
	end
	
	# * Méthode de classe qui permet de modifier le volume des bruitages du *Compte* dont on a donné le pseudo
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- volume : un entier représentant le volume des bruitages souhaité
	# * Retourne *self*
	def BaseDeDonnees.setVolumeBruitage(pseudo, volume)
		Comptes.where(:pseudo => pseudo).update_all(volume_bruitage: volume)
		return self
	end
	
	# * Méthode de classe qui renvoie la liste de tous les <b>SuccesIndividuel</b>s
	# * Retourne un tableau contenant tous les <b>SuccesIndividuel</b>s
	def BaseDeDonnees.getSucces()
		res = Succes.all
		succes = Array.new
		res.each do |elem|
			succes.push(SuccesIndividuel.creer(elem.id_succes))
		end
		return succes
	end
	
	# * Méthode de classe qui indique si le joueur a débloqué un *SuccesIndividuel*
	# * === Attributs :
	#		- idSucces : un entier représentant l'identifiant du SuccesIndividuel
	#		- pseudo : un String qui représente le pseudo du joueur
	# * Retourne *true* si le *SuccesIndividuel* est débloqué pour le joueur, *false* sinon
	def BaseDeDonnees.estSuccesDebloque?(idSucces, pseudo)
		return SuccesAccomplis.exists?(:id_succes => idSucces, :pseudo => pseudo)
	end
	
	# * Méthode de classe qui permet d'insérer dans la base le fait que le joueur a débloqué un *SuccesIndividuel*
	# * === Attributs :
	#		- idSucces : un entier représentant l'identifiant du *SuccesIndividuel* débloqué
	#		- pseudo : un String qui représente le pseudo du joueur
	# * Retourne *self*
	def BaseDeDonnees.setSuccesDebloque(idSucces, pseudo)
		newSucces = SuccesAccomplis.new
		newSucces.pseudo = pseudo
		newSucces.id_succes = idSucces
		newSucces.save
		return self
	end
	
	# * Méthode de classe qui renvoie la description du *SuccesIndividuel*
	# * === Attribut :
	#		- idSucces : un entier qui représente l'identifiant du SuccesIndividuel
	# * Retourne un *String* représentant la description du *SuccesIndividuel*
	def BaseDeDonnees.getSuccesDescription(idSucces)
		return Succes.select(:description).find_by_id_succes(idSucces).description
	end
	
	 # * Méthode de classe qui renvoie la condition de déblocage du *SuccesIndividuel*
	# * === Attribut :
	#		- idSucces : un entier qui représente l'identifiant du SuccesIndividuel
	# * Retourne un *String* (à utiliser avec la méthode <t>eval</t>) représentant la condition de déblocage du *SuccesIndividuel*
	def BaseDeDonnees.getSuccesCondition(idSucces)
		return Succes.select(:condition).find_by_id_succes(idSucces).condition
	end
	
	# * Méthode de classe qui permet de renvoyer les <b>Defi</b>s que doit effectuer le joueur sous forme de liste
	# * === Attributs :
	#		- pseudoDest : un String qui représente le pseudo du joueur destinataire
	# * Retourne un tableau contenant les <b>Defi</b>s du joueur
	def BaseDeDonnees.getDefis(pseudoDest)	 
		res = Defis.where(pseudo_defier: pseudoDest, pseudo_vainqueur: nil).all
		defis = Array.new  
		res.each do |elem|
			defis.push(Defi.creer(elem.pseudo_defier, elem.pseudo, elem.id_grille, elem.score))
		end
		return defis
	end
	
	# * Méthode de classe qui permet d'insérer un nouveau *Defi*
	# * === Attributs :
	#		- pseudoDest : un String représentant le pseudo du joueur qui reçoit le défi
	#		- pseudoEnv : un String représentant le pseudo du joueur qui envoie le défi
	#		- idGrille : un entier qui représente l'unique identifiant de la grille
	#		- score : un entier qui représente le score effectué par le joueur qui envoie le défi
	# * Retourne *self* si la requête réussit, -1 sinon
	def BaseDeDonnees.setDefi(pseudoDest, pseudoEnv, idGrille, score)
		if(Comptes.exists?(:pseudo => pseudoDest))
			newDefis = Defis.new
			newDefis.pseudo = pseudoEnv
			newDefis.pseudo_defier = pseudoDest
			newDefis.id_grille = idGrille
			newDefis.score = score
			newDefis.save
			return self
		end
		return -1
	end
	
	# * Méthode de classe qui renvoie le nom d'un *Monde*
	# * === Attributs :
	#		- idMonde : un entier représentant l'unique identifiant du Monde
	# * Retourne un *String* représentant le nom du *Monde*
	def BaseDeDonnees.getMondeNom(idMonde)
		return Mondes.select(:nom_monde).find_by(id_monde: idMonde).nom_monde
	end
	
	# * Méthode de classe qui renvoie le score d'un *Defi*
	# * === Attributs :
	#		- pseudoEnv : un String représentant le pseudo du joueur qui a envoyé le Defi
	#		- pseudoDest : un String qui représente le pseudo du joueur qui a reçu le Defi
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	# * Retourne un entier représentant le score du *Defi*
	def BaseDeDonnees.getDefiScore(pseudoEnv, pseudoDest, idGrille)
		return Defis.select(:score).find_by(pseudo: pseudoEnv, pseudo_defier: pseudoDest, id_grille: idGrille).score
	end
	
	# * Méthode de classe qui permet l'insertion d'un nouveau *Compte*
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du nouveau joueur
	#		- mdp : un String représentant le mot de passe du nouveau joueur
	#		- nom : un String représentant le nom du nouveau joueur
	#		- prenom : un String représentant le prénom du nouveau joueur
	#		- mail : un String représentant l'adresse mail du nouveau joueur
	# * Retourne *self*
	def BaseDeDonnees.setCompte(pseudo, mdp, nom, prenom, mail)
		newCompte = Comptes.new
		newCompte.pseudo = pseudo
		newCompte.mot_de_passe = Digest::MD5.hexdigest(mdp)
		newCompte.nom = nom
		newCompte.prenom = prenom
		newCompte.adresse_mail = mail
		newCompte.save
		return self
	end
	
	# * Méthode de classe qui permet l'insertion d'un nouveau *RaccourciClavier* ou la mise à jour s'il existe déjà
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idRaccourci : un entier représentant l'identifiant du RaccourciClavier
	#		- touche : un String d'un seul caractère représentant la touche attribué pour le RaccourciClavier
	# * Retourne *self*
	def BaseDeDonnees.setRaccourci(pseudo, idRaccourci, touche)
		if(RaccourciComptes.exists?(:pseudo => pseudo, :id_raccourci => idRaccourci))
			RaccourciComptes.where(:pseudo => pseudo, :id_raccourci => idRaccourci).update_all(touche: touche)
		else
			newRaccourci = RaccourciComptes.new
			newRaccourci.pseudo = pseudo
			newRaccourci.id_raccourci = idRaccourci
			newRaccourci.touche = touche
			newRaccourci.save
		end
		return self
	end
	
	# * Méthode de classe qui renvoie la touche attribué à un *RaccourciClavier*
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idRaccourci : un entier représentant l'identifiant du RaccourciClavier
	# * Retourne *self*
	def BaseDeDonnees.getRaccourci(pseudo, idRaccourci)
		return RaccourciComptes.select(:touche).find_by(pseudo: pseudo, id_raccourci: idRaccourci).touche
	end
	
	# * Méthode de classe qui renvoie le score total d'un joueur en fonction de la taille des <b>Grille</b>s
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- taille : un entier représentant la taille des Grilles sur lesquelles chercher le score
	# * Retourne un entier représentant le score
	def BaseDeDonnees.getScoreTotal(pseudo, taille)
		GrilleFinis.select(:score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ?", pseudo, taille).sum(:score)
	end
	
	# * Méthode de classe qui renvoie le temps total qu'a joué un joueur
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le temps total en secondes
	def BaseDeDonnees.getTempsTotal(pseudo)
		return GrilleFinis.where(pseudo: pseudo).sum(:temps)
	end
	
	# * Méthode de classe qui renvoie le score total d'un joueur en fonction de la taille et de la difficulté des <b>Grille</b>s
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- taille : un entier représentant la taille des Grilles sur lesquelles chercher le score
	#		- difficulte : un entier représentant la difficulté des Grilles sur lesquelles chercher le score
	# * Retourne un entier représentant le score
	def BaseDeDonnees.getScoreDifficulte(pseudo, taille, difficulte)
		GrilleFinis.select(:score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ? AND difficulte = ?", pseudo, taille, difficulte).sum(:score)
	end
	
	# * Méthode de classe qui renvoie le classement des meilleurs scores en fonction d'une taille de *Grille* et de la difficulté
	# * === Attributs :
	#		- taille : un entier représentant la taille d'une grille
	#		- difficulte : un entier représentant la difficulté d'une grille
	# * Retourne un tableau contenant des tableaux du type [position dans le classement (entier), pseudo du joueur (<b>String</b>), score du joueur (entier)]
	def BaseDeDonnees.getClassement(taille, difficulte)
		i = 1
		classement = Array.new
		res = GrilleFinis.select(:pseudo, :score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("taille = ? AND difficulte = ?",taille, difficulte).order(score: :desc).first(10)
		res.each do |elem|
			classement.push([i, elem.pseudo, elem.score])
			i += 1
		end
		return classement
	end
	
	# * Méthode de classe qui permet l'insertion de <b>Grille</b>s dans la base de données
	# * === Attribut :
	#		- cheminFic : un String représentant le chemin du fichier contenant les Grilles
	# * Retourne *self*
	def BaseDeDonnees.addGrille(cheminFic)
		fichier = File.new(cheminFic, "r")
		tabLigne = Array.new

		fichier.each_line do |ligne|
			tabLigne = ligne.split(";")
			difficulte = tabLigne[0]
			taille = Math.sqrt(tabLigne[1].length)
			grilleDepart = tabLigne[1]
			grilleSolution = tabLigne[2]

			newGrille = Grilles.new
			newGrille.difficulte = difficulte
			newGrille.taille = taille
			newGrille.grille_depart = grilleDepart
			newGrille.grille_solution = grilleSolution
			newGrille.save
		end
		return self
	end
	
	# * Méthode de classe qui renvoie le nombre d'hypothèses d'une sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le nombre d'hypothèses
	def BaseDeDonnees.getSauvegardeNbHypotheses(pseudo)
		return Sauvegardes.select(:nb_hypothese).find_by_pseudo(pseudo).nb_hypothese
	end
	
	# * Méthode de classe qui renvoie le nombre d'aides d'une sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le nombre d'aides
	def BaseDeDonnees.getSauvegardeNbAides(pseudo)
		return Sauvegardes.select(:nb_aide).find_by_pseudo(pseudo).nb_aide
	end
	
	# * Méthode de classe qui renvoie le nombre de clics d'une sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le nombre de clics
	def BaseDeDonnees.getSauvegardeNbClics(pseudo)
		return Sauvegardes.select(:nb_clic).find_by_pseudo(pseudo).nb_clic
	end
	
	# * Méthode de classe qui renvoie le temps d'une sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le temps en seconde
	def BaseDeDonnees.getSauvegardeTemps(pseudo)
		return Sauvegardes.select(:temps).find_by_pseudo(pseudo).temps
	end
	
	# * Méthode de classe qui renvoie la *Grille* d'une sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne la *Grille* de la sauvegarde
	def BaseDeDonnees.getSauvegardeGrilleSauvegardee(pseudo)
		grilleSauvegarde = Sauvegardes.select(:grille_sauvegarde).find_by_pseudo(pseudo).grille_sauvegarde
		return BaseDeDonnees.stringToGrille(grilleSauvegarde)
	end
	
	# * Méthode de classe qui permet de savoir si le joueur a une sauvegarde
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne *true* si le joueur a une sauvegarde, *false* sinon
	def BaseDeDonnees.estSauvegarde?(pseudo)
		return Sauvegardes.exists?(:pseudo => pseudo)			
	end
	
	# * Méthode de classe qui renvoie l'unique ID de la *Grille* d'une sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant l'unique ID de la *Grille*
	def BaseDeDonnees.getSauvegardeIdGrille(pseudo)
		return Sauvegardes.select(:id_grille).find_by_pseudo(pseudo).id_grille 
	end
	
	# * Méthode de classe qui supprime la sauvegarde d'un joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne *self*
	def BaseDeDonnees.supprimeSauvegarde(pseudo)
		Sauvegardes.where(:pseudo => pseudo).destroy_all
		return self
	end
	
	# * Méthode de classe qui supprime un *Defi*
	# * === Attributs :
	#		- pseudoEnv : un String représentant le pseudo du joueur qui a envoyé le défi
	#		- pseudoDest : un String le pseudo du joueur qui a reçu le défi
	#		- idGrille : un entier représentant l'identifiant de la grille
	# * Retourne *self*
	def BaseDeDonnees.supprimeDefi(pseudoEnv, pseudoDest, idGrille)
		Defis.delete_all(["pseudo = ? AND pseudo_defier = ? AND id_grille = ?", pseudoEnv, pseudoDest, idGrille])
		return self
	end
	
	# * Méthode de classe qui supprime tous les succès qu'a accomplis le joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne *self*
	def BaseDeDonnees.viderReussir(pseudo)
		SuccesAccomplis.delete_all(["pseudo = ?", pseudo])
		return self
	end
	
	# * Méthode de classe qui supprime tous les résultats qu'a accomplis le joueur sur les <b>Grille</b>s
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne *self*
	def BaseDeDonnees.viderFinir(pseudo)
		GrilleFinis.delete_all(["pseudo = ?", pseudo])
		return self
	end
	
	# * Méthode de classe qui renvoie la taille d'une *Grille*
	# * === Attribut :
	#		- idGrille l'identifiant de la Grille
	# * Retourne un entier représentant la taille de la *Grille*
	def BaseDeDonnees.getGrilleTaille(idGrille)
		return Grilles.select(:taille).find_by_id_grille(idGrille).taille
	end
	
	# * Méthode de classe qui renvoie la difficulte d'une *Grille*
	# * === Attribut :
	#		- idGrille l'identifiant de la Grille
	# * Retourne un entier représentant la difficulte de la *Grille*
	def BaseDeDonnees.getGrilleDifficulte(idGrille)
		return Grilles.select(:difficulte).find_by_id_grille(idGrille).difficulte
	end
	
	# * Méthode de classe qui renvoie le nombre de clics max d'une *Grille*
	# * === Attribut :
	#		- idGrille l'identifiant de la Grille
	# * Retourne un entier représentant le nombre de clics max de la *Grille*
	def BaseDeDonnees.getGrilleNbClicsMax(idGrille)
		return Grilles.select(:nb_clic_max).find_by_id_grille(idGrille).nb_clic_max
	end
	
	# * Méthode de classe qui renvoie le temps max d'une *Grille*
	# * === Attribut :
	#		- idGrille l'identifiant de la Grille
	# * Retourne un entier représentant le temps max de la *Grille* en secondes
	def BaseDeDonnees.getGrilleTempsMax(idGrille)
		return Grilles.select(:temps_max).find_by_id_grille(idGrille).temps_max
	end
	
	# * Méthode de classe qui transforme un chaine de cractère en grille de cases
	# * === Attribut :
	#		- grille : un String représentatif de la Grille
	# * Retourne une matrice de <b>Case</b>s
	def BaseDeDonnees.stringToGrille(grille)
		matriceGrille = []
		j = 0
		longGrille = grille.length
		0.upto(Math.sqrt(longGrille) - 1) do |i|
			matriceGrille[i] = []
			0.upto(Math.sqrt(longGrille) - 1) do
				caseGrille = Case.new
				if(grille[j] == '0')
					caseGrille.setBleu
				else
					 if(grille[j] == '1')
						caseGrille.setRouge
					 end
				end
				j += 1
				matriceGrille[i] += [caseGrille]
			end
		end
		return matriceGrille
	end
	
	# * Méthode de classe qui renvoie la matrice de départ d'une *Grille*
	# * === Attribut :
	#		- idGrille l'identifiant de la Grille
	# * Retourne une matrice de <b>Case</b>s de départ de la *Grille*
	def BaseDeDonnees.getGrilleMatrice(idGrille)
		grilleDepart = Grilles.select(:grille_depart).find_by_id_grille(idGrille).grille_depart
		return BaseDeDonnees.stringToGrille(grilleDepart)
	end
	
	# * Méthode de classe qui renvoie la matrice résolue d'une *Grille*
	# * === Attribut :
	#		- idGrille l'identifiant de la Grille
	# * Retourne une matrice de <b>Case</b>s non vides de la *Grille*
	def BaseDeDonnees.getGrilleMatriceResolue(idGrille)
		grilleSolution = Grilles.select(:grille_solution).find_by_id_grille(idGrille).grille_solution
		return BaseDeDonnees.stringToGrille(grilleSolution)
	end
	
	# * Méthode de classe qui permet l'insertion d'une sauvegarde
	# * === Attributs :
	#		- pseudo : un String qui représente le pseudo du joueur
	#		- temps : un entier représentant le temps effectué par le joueur sur la Grille en secondes
	#		- nbClics : un entier représentant le nombre de clics effectués par le joueur 
	#		- nbHypotheses : un entier représentant le nombre d'hypothèses effectuées par le joueur
	#		- nbAides : un entier représentant le nombre d'aides demandées par le joueur
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	#		- grilleSauvegarde : un String représentatif de la Grille (de la forme "BBRR__RB_BB_R...")
	# * Retourne *self*
	def BaseDeDonnees.setSauvegarde(pseudo, temps, nbClics, nbHypotheses, nbAides, idGrille, grilleSauvegarde)
		tabGrilleSauvegarde = Array.new

		0.upto(grilleSauvegarde.length - 1) do |i|
			0.upto(grilleSauvegarde.length - 1) do |j|
				if(grilleSauvegarde[i][j].estBleu?())
					tabGrilleSauvegarde.push('0')
				else
					if(grilleSauvegarde[i][j].estRouge?())
						tabGrilleSauvegarde.push('1')
					else
						tabGrilleSauvegarde.push('_')	
					end
				end
			end
		end

		newSauvegarde = Sauvegardes.new
		newSauvegarde.pseudo = pseudo
		newSauvegarde.temps = temps
		newSauvegarde.nb_clic = nbClics
		newSauvegarde.nb_hypothese = nbHypotheses
		newSauvegarde.nb_aide = nbAides
		newSauvegarde.id_grille = idGrille
		newSauvegarde.grille_sauvegarde = tabGrilleSauvegarde.join
		newSauvegarde.save

		return self
	end
	
	# * Méthode de classe qui indique si un pseudo est disponible
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo à tester
	# * Retourne *true* si le pseudo est disponible, *false* sinon
	def BaseDeDonnees.estIdentifiantDisponible?(pseudo)
		return !Comptes.exists?(:pseudo => pseudo)
	end
	
	# * Méthode de classe qui indique si une adresse mail est disponible
	# * === Attribut :
	#		- mail : un String représentant l'adresse mail à tester
	# * Retourne *true* si l'adresse mail est disponible, *false* sinon
	def BaseDeDonnees.estMailDisponible?(mail)
		return !Comptes.exists?(:adresse_mail => mail)
	end
	
	# * Méthode de classe qui renvoie le seuil pour obtenir la première étoile
	# * === Attribut :
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	# * Retourne un entier représentant le seuil (en terme de score) pour la première étoile
	def BaseDeDonnees.getGrilleEtoileUnScore(idGrille)
		return Grilles.select(:etoile_1).find_by_id_grille(idGrille).etoile_1
	end
	
	# * Méthode de classe qui renvoie le seuil pour obtenir la seconde étoile
	# * === Attribut :
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	# * Retourne un entier représentant le seuil (en terme de score) pour la seconde étoile
	def BaseDeDonnees.getGrilleEtoileDeuxScore(idGrille)
		return Grilles.select(:etoile_2).find_by_id_grille(idGrille).etoile_2
	end
	
	# * Méthode de classe qui renvoie le seuil pour obtenir la troisième étoile
	# * === Attribut :
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	# * Retourne un entier représentant le seuil (en terme de score) pour la troisième étoile
	def BaseDeDonnees.getGrilleEtoileTroisScore(idGrille)
		return Grilles.select(:etoile_3).find_by_id_grille(idGrille).etoile_3
	end
	
	# * Méthode de classe qui renvoie l'identifiant d'une *Grille* par rapport à un *Monde* et numèro de niveau
	# * === Attributs :
	#		- idMonde : un entier représentant l'unique identifiant du Monde
	#		- numNiveau : un entier représentant le numéro du niveau dans le Monde
	# * Retourne un entier représentant l'unique ID de la *Grille*
	def BaseDeDonnees.getMondeGrilleId(idMonde, numNiveau)
		Grilles.select(:id_grille).where(:id_monde => idMonde, :numero_niveau => numNiveau).first.id_grille	
	end
	
	# * Méthode de classe qui renvoie le nom d'un *Monde*
	# * === Attribut :
	#		- idMonde : un entier représentant l'unique identifiant du Monde
	# * Retourne un *String* représentant le nom du *Monde*
	def BaseDeDonnees.getMondeNom(idMonde)
		return Mondes.select(:nom_monde).find_by_id_monde(idMonde).nom_monde   
	end
	
	# * Méthode de classe qui renvoie l'identifiant d'une *Grille* de façon alétoire en fonction d'une taille et d'une difficulté
	# * === Attributs :
	#		- taille : un entier représentant la taille de la Grille
	#		- difficulte : un entier représentant la difficulté de la Grille
	# * Retourne un entier représentant un ID d'une *Grille* aléatoire
	def BaseDeDonnees.getGrilleIdAleatoire(taille, difficulte)
		return Grilles.select(:id_grille).where(:taille => taille, :difficulte => difficulte, :numero_niveau => nil, :id_monde => nil).order("RAND()").first.id_grille
	end
	
	# * Méthode de classe qui renvoie le nombre de <b>Grille</b>s accomplies en fonction d'une taille
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- taille : un entier représentant la taille de la Grille
	# * Retourne un entier représentant le nombre de <b>Grille</b>s accomplies
	def BaseDeDonnees.getNbGrilleTailleFini(pseudo, taille)
		return GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ?", pseudo, taille).count	
	end
	
	# * Méthode de classe qui renvoie le nombre de <b>Grille</b>s accomplies sans aide en fonction d'une taille
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- taille : un entier représentant la taille de la Grille
	# * Retourne un entier représentant le nombre de <b>Grille</b>s accomplies sans aide
	def BaseDeDonnees.getNbGrilleDifficulteSansAideFini(pseudo, difficulte)
		return GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND difficulte = ? AND nb_aide = ?",pseudo, difficulte, 0).count 
	end
	
	# * Méthode de classe qui permet de savoir si un *Monde* est terminé
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idMonde : un entier représentant l'unique identifiant du Monde
	# * Retourne *true* si le *Monde* est fini, *false* sinon
	def BaseDeDonnees.estFiniMonde?(pseudo, idMonde)
		idGrille = Grilles.select(:id_grille).where(:id_monde => idMonde).order(numero_niveau: :asc).last.id_grille
		return GrilleFinis.exists?(:pseudo => pseudo, :id_grille => idGrille)
	end
	
	# * Méthode de classe qui renvoie le nombre de <b>Grille</b>s accomplies
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le nombre de <b>Grille</b>s terminées
	def BaseDeDonnees.getNbGrilleFini(pseudo)
		return GrilleFinis.where(:pseudo => pseudo).count
	end
	
	# * Méthode de classe qui renvoie le nombre de <b>Grille</b>s de taille 12 accomplies en moins de 60 secondes
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le nombre de <b>Grille</b>s de taille 12 terminées en moins de 60 secondes
	def BaseDeDonnees.getNbGrilleTailleDouzeMoinsSoixante(pseudo)
		return GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ? AND temps < ?",pseudo, 12, 60).count
	end
	
	# * Méthode de classe qui renvoie le nombre de <b>Defi</b>s gagnés par le joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant le nombre de <b>Defi</b>s gagnés par le joueur
	def BaseDeDonnees.getNbDefiGagne(pseudo)
		return Defis.where(:pseudo_vainqueur => pseudo).count
	end
	
	# * Méthode de classe qui renvoie le nom d'un *SuccesIndividuel* à partir de son identifiant
	# * === Attribut :
	#		- idSucces : un entier représentant l'identifiant du SuccesIndividuel
	# * Retourne un *String* qui représente le nom du *SuccesIndividuel*
	def BaseDeDonnees.getNomSucces(idSucces)
		return Succes.select(:nom).find_by_id_succes(idSucces).nom 
	end
	
	# * Méthode de classe qui renvoie la somme des étoiles obtenues par le joueur
	# * === Attribut
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier représentant la somme des étoiles obtenues par le joueur
	def BaseDeDonnees.getTotalNbEtoile(pseudo)
		if(GrilleFinis.exists?(:pseudo => pseudo))
			return GrilleFinis.select(:nb_etoile).where(pseudo: pseudo).sum(:nb_etoile)
		end
		return 0
	end
	
	# * Méthode de classe qui renvoie le plus petit nombre de clics effectués toutes <b>Grille</b>s confondues par le joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier qui représente le plus petit nombre de clics
	def BaseDeDonnees.getPlusPetitNombreClic(pseudo)
		return GrilleFinis.select(:nb_clic).where(pseudo: pseudo).minimum(:nb_clic)
	end
	
	# * Méthode de classe qui renvoie le plus grand nombre de clics effectués toutes <b>Grille</b>s confondues par le joueur
	# * === Attribut :
	#		- pseudo : un String représentant le pseudo du joueur
	# * Retourne un entier qui représente le plus grand nombre de clics
	def BaseDeDonnees.getPlusGrandNombreClic(pseudo)
		return GrilleFinis.select(:nb_clic).where(pseudo: pseudo).maximum(:nb_clic)
	end
	
	# * Méthode de classe qui renvoie un tableau contenant l'identifiant du *Monde* et le numero_niveau les plus avancés
	# * === Attribut :
	#		- pseudo : un String qui représente le pseudo du joueur
	# * Retourne un tableau contenant l'identifiant du *Monde* et le numero_niveau les plus avancés
	def BaseDeDonnees.dernierNiveauFini(pseudo)
		tabDernierNiveau = Array.new
		if(GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("numero_niveau > ? AND id_monde > ?", 0, 0).exists?(:pseudo => pseudo))
			  res = Grilles.joins("JOIN grille_fini ON grille.id_grille = grille_fini.id_grille").where("numero_niveau > ? AND id_monde > ? AND pseudo = ?", 0, 0, pseudo).order(id_monde: :desc, numero_niveau: :desc).first
			  tabDernierNiveau.push(res.id_monde)
			  tabDernierNiveau.push(res.numero_niveau)
			  return tabDernierNiveau
		end
		return -1
	end
	
	# * Méthode de classe qui renvoie le numero de niveau d'une *Grille* appartenant à un *Monde*
	# * === Attribut :
	#		- idGrille : un entier représentant l'unique identifiant de la Grille
	# * Retourne un entier représentant le numero de niveau d'une *Grille* appartenant à un *Monde*
	def BaseDeDonnees.getNumeroNiveau(idGrille)
		return Grilles.select(:numero_niveau).find_by_id_grille(idGrille).numero_niveau
	end
	
	# * Méthode de classe qui attribue un vainqueur à un *Defi*
	# * === Attributs :
	#		- joueurDefie : un String représentant le pseudo du joueur qui a été défié
	#		- joueurDefiant : un String représentant le pseudo du joueur qui a défié
	#		- unIdGrille : un entier représentant l'unique identifiant de la Grille
	#		- pseudoVainqueur : un String représentant le pseudo du vainqueur du Defi
	#		- unScore : un entier représentant le score du vainqueur
	# * Retourne *self*
	def BaseDeDonnees.setVainqueurDefi(joueurDefie, joueurDefiant, unIdGrille, pseudoVainqueur, unScore)
		Defis.where(:pseudo => joueurDefiant, :pseudo_defier => joueurDefie, :id_grille => unIdGrille).update_all(score: unScore, pseudo_vainqueur: pseudoVainqueur)
		return self
	end
	
	# * Méthode de classe qui renvoie le nombre d'étoiles obtenues sur une *Grille* par le joueur
	# * === Attributs :
	#		- pseudo : un String représentant le pseudo du joueur
	#		- idGrille : un entier représentant l'unqiue identifiant de la Grille
	# * Retourne le nombre d'étoiles obtenues sur une *Grille* par le joueur
	def BaseDeDonnees.getNbEtoileObtenu(pseudo, idGrille)
		if(GrilleFinis.exists?(:pseudo => pseudo, :id_grille => idGrille))
			return GrilleFinis.select(:nb_etoile).find_by(pseudo: pseudo, id_grille: idGrille).nb_etoile	
		end
		return 0
	end
end
