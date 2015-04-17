	##
# Auteur RONAN YZEUX
# Version 0.1 : Date : Sat Mar 14 15:57:38 CET 2015
#
require "digest/md5"
require "active_record"

load 'ClassesBdd.rb'

class BaseDeDonnees
	ActiveRecord::Base.establish_connection(
		:adapter => "mysql2",
		:database => "ronan",
		:username => "ronan",
		:password => "ronan",
	    	:host => "vps120906.ovh.net"
	)
   
    	private_class_method :new
    	
	# Renvoie le score d'un joueur sur une grille
	# - pseudo le pseudo du joueur
	# - idGrille l'identifiant de la grille
	def BaseDeDonnees.getScore(pseudo, idGrille)
		return GrilleFinis.select(:score).find_by(pseudo: pseudo, id_grille: idGrille).score
	end
	
	# Renvoie le temps d'un joueur sur une grille
	# - pseudo le pseudo du joueur
	# - idGrille l'identifiant de la grille
	def BaseDeDonnees.getTemps(pseudo, idGrille)
		return GrilleFinis.select(:temps).find_by(pseudo: pseudo, id_grille: idGrille).temps
	end
	
	# Indique si le joueur a fini une grille (vrai ou faux)
	# - pseudo le pseudo du joueur
	# - idGrille l'identifiant de la grille
	def BaseDeDonnees.estGrilleResolue?(pseudo, idGrille)
		return GrilleFinis.exists?(:pseudo => pseudo, :id_grille => idGrille)
	end
	
	# Insertion du résultat d'un joueur sur une grille ou mise à jour si déjà fait au moins une fois
	# - pseudo le pseudo du joueur
	# - idGrille l'identifiant de la grille
	# - temps le temps qu'à mis le joueur pour effectuer la grille
	# - nbClics le nombre de clics qu'à fait le joueur
	# - nbEtoiles le nombre d'étoiles obtenu par le joueur
	# - nbHypotheses le nombre d'hypothèses effectué par le joueur
	# - nbAides le nombre d'aides demandé par le joueur
	# - score le score du joueur sur la grille
	def BaseDeDonnees.setGrilleTermine(pseudo, idGrille, temps, nbClics, nbEtoiles, nbHypotheses, nbAides, score)
		if(BaseDeDonnee.estGrilleResolue?(pseudo, idGrille))
			GrilleFinis.where(:pseudo => pseudo, :id_grille => idGrille).update_all(nb_clic: nbClics, nb_etoile: nbEtoiles, nb_hypothese: nb_hypotheses, nb_aide: nbAides, score: score)
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
	
	# Renvoie le nombre de clic effectué par le joueur sur une grille
	# - pseudo le pseudo du joueur
	# - idGrille l'identifiant de la grille
	def BaseDeDonnees.getNbClics(pseudo, idGrille)
		return GrilleFinis.select(:nb_clic).find_by(pseudo: pseudo, id_grille: idGrille).nb_clic
	end
	
	# Renvoie l'adresse mail possesseur du compte
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getMail(pseudo)
		return Comptes.select(:adresse_mail).find_by_pseudo(pseudo).adresse_mail
	end
	
	# Renvoie le nom du possesseur du compte
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getNom(pseudo)
		return Comptes.select(:nom).find_by_pseudo(pseudo).nom
	end
	
	# Renvoie le prenom du possesseur du compte
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getPrenom(pseudo)
		return Comptes.select(:prenom).find_by_pseudo(pseudo).prenom
	end
	
	# Renvoie la couleur du clic gauche
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getCouleurUn(pseudo)
		return Comptes.select(:couleur_1).find_by_pseudo(pseudo).couleur_1
	end
	
	# Indique si un compte existe ou pas (vrai ou faux)
	# - pseudo le pseudo du joueur
	# - motDePasse le mot de passe du joueur
	def BaseDeDonnees.estBonsIdentifiants?(pseudo, motDePasse)
		mdpCrypte = Digest::MD5.hexdigest(motDePasse)
		return Comptes.exists?(:pseudo => pseudo, :mot_de_passe => mdpCrypte)
	end
	
	# Modifie dans la base la couleur du clic gauche du joueur
	# - pseudo le pseudo du joueur
	# - couleur la couleur souhaité
	def BaseDeDonnees.setCouleurUn(pseudo, couleur)
		Comptes.where(:pseudo => pseudo).update_all(couleur_1: couleur)
		return self
	end
	
	# Renvoie la couleur du clic droit
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getCouleurDeux(pseudo)
		return Comptes.select(:couleur_2).find_by_pseudo(pseudo).couleur_2
	end
	
	# Modifie dans la base la couleur du clic droit du joueur
	# - pseudo le pseudo du joueur
	# - couleur la couleur souhaité
	def BaseDeDonnees.setCouleurDeux(pseudo, couleur)
		Comptes.where(:pseudo => pseudo).update_all(couleur_2: couleur)
		return self
	end
	
	# Modifier le mot de passe du joueur
	# - pseudo le pseudo du joueur
	# - motDePasse le mot de passe souhaité
	def BaseDeDonnees.setMotDePasse(pseudo, motDePasse)
		mdpCrypte = Digest::MD5.hexdigest(motDePasse)
		Comptes.where(:pseudo => pseudo).update_all(mot_de_passe: mdpCrypte)
		return self
	end
	
	# Renvoie le volume de la musique du compte
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getVolumeMusique(pseudo)
		return Comptes.select(:volume_musique).find_by_pseudo(pseudo).volume_musique
	end
	
	# Modifie le volume de la musique du compte
	# - pseudo le pseudo du joueur
	# - volume le volume de la musique souhaité
	def BaseDeDonnees.setVolumeMusique(pseudo, volume)
		Comptes.where(:pseudo => pseudo).update_all(volume_musique: volume)
		return self
	end
	
	# Renvoie le volume des bruitages
	# - pseudo le pseudo du joueur
	def BaseDeDonnees.getVolumeBruitage(pseudo)
		return Comptes.select(:volume_bruitage).find_by_pseudo(pseudo).volume_bruitage
	end
	
	# Modifie le volume des bruitages du compte
	# - pseudo le pseudo du joueur
	# - volume le volume des bruitages souhaité
	def BaseDeDonnees.setVolumeBruitage(pseudo, volume)
		Comptes.where(:pseudo => pseudo).update_all(volume_bruitage: volume)
		return self
	end
    
    # Rencoie la liste des succès
    def BaseDeDonnees.getSucces()
        res = Succes.all
        succes = Array.new
        res.each do |elem|
            succes.push(SuccesIndividuel.creer(elem.id_succes))
        end
        return succes
    end
    
    # Indique si le joueur a débloqué un succès précis (vrai ou faux)
    # - idSucces l'identifiant du succès
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.estSuccesDebloque?(idSucces, pseudo)
        return SuccesAccomplis.exists?(:id_succes => idSucces, :pseudo => pseudo)
    end
    
    # Insertion dans la base le fait que le joueur a débloqué un succès
    # - idSucces l'identifiant du succès débloqué
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.setSuccesDebloque(idSucces, pseudo)
        newSucces = SuccesAccomplis.new
        newSucces.pseudo = pseudo
        newSucces.id_succes = idSucces
        newSucces.save
        return self
    end
    
    # Renvoie la description du succès
    # - idSucces l'identifiant du succès
    def BaseDeDonnees.getSuccesDescription(idSucces)
        return Succes.select(:description).find_by_id_succes(idSucces).description
    end
    
    # Renvoie la condition du succès
    # - idSucces l'identifiant du succès
    def BaseDeDonnees.getSuccesCondition(idSucces)
        return Succes.select(:condition).find_by_id_succes(idSucces).condition
    end
    
    # Renvoie les défis sous forme de liste que doit effectuer le joueur
    # - pseudoDest le pseudo du joueur
    def BaseDeDonnees.getDefis(pseudoDest)     
        res = Defis.joins("JOIN grille ON grille.id_grille = defi.id_grille").where(pseudo_defier: pseudoDest, pseudo_vainqueur: nil).all
        defis = Array.new  
        res.each do |elem|
            if(elem.difficulte < 8)
                defis.push(Defi.new(elem.pseudo, elem.pseudo_defier, Grille.new(elem.id_grille), elem.score))
            else
                 defis.push(Defi.new(elem.pseudo, elem.pseudo_defier, GrilleHardcore.new(elem.id_grille), elem.score))
            end
        end
        return defis
    end
    
    # Insertion d'un nouveau défi
    # pseudoDest le pseudo du joueur qui reçoit le défi
    # pseudoEnv le pseudo du joueur qui envoit le défi
    # idGrille l'identifiant de la grille
    # score le score effectué par le joueur qui envoit le défi
    def BaseDeDonnees.setDefi(pseudoDest, pseudoEnv, idGrille, score)
        newDefis = Defis.new
        newdefis.pseudo = pseudoEnv
        newDefis.pseudo_defier = pseudoDest
        newDefis.id_grille = idGrille
        newDefis.score = score
        newDefis.save
        return self
    end
    
    # Renvoie le nom d'un monde
    # - idMonde l'identifiant du monde
    def BaseDeDonnees.getMondeNom(idMonde)
        return Mondes.select(:nom_monde).find_by(id_monde: idMonde).nom_monde
    end
    
    # Renvoie le score d'un défi
    # - pseudoEnv le pseudo du joueur qui a envoyé le défi
    # - pseudoDest le pseudo du joueur qui a reçu le défi
    # - idGrille l'identifiant de la grille
    def BaseDeDonnees.getDefiScore(pseudoEnv, pseudoDest, idGrille)
        return Defis.select(:score).find_by(pseudo: pseudoEnv, pseudo_defier: pseudoDest, id_grille: idGrille).score
    end
    
    # Insertion d'un nouveau compte
    # - pseudo le pseudo du nouveau joueur
    # - mdp le mot de passe du nouveau joueur
    # - nom le nom du nouveau joueur
    # - prenom le prénom du nouveau joueur
    # - mail l'adresse mail du nouveau joueur
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
    
    # Insertion d'un nouveau raccourci ou mise à jour s'il existe déjà
    # - pseudo le pseudo du joueur
    # - idRaccourci l'identifiant du raccourci
    # - touche la touche attribué pour le raccourci
    def BaseDeDonnees.setRaccourci(pseudo, idRaccourci, touche)
        if(RaccourciComptes.exists?(:pseudo => pseudo, :id_raccourci => idRaccourci))
            RaccourciComptes.where(:pseudo => pseudo, :id_raccourci => idRaccourci).update_all(touche: touche)
        else
            newRaccourci = RaccourciCompte.new
            newRaccourci.pseudo = pseudo
            newRaccourci.id_raccourci = idRaccourci
            newRaccourci.touche = touche
            newRaccourci.save
        end
        return self
    end
    
    # Renvoie la touche attribué à un raccourci
    # - pseudo le pseudo du joueur
    # - idRaccourci l'identifiant du raccourci
    def BaseDeDonnees.getRaccourci(pseudo, idRaccourci)
        return RaccourciComptes.select(:touche).find_by(pseudo: pseudo, id_raccourci: idRaccourci).touche
    end
    
    # Renvoie le score total d'un joueur en fonction d'une taille de grille
    # - pseudo le pseudo du joueur
    # - taille la taille de la grille
    def BaseDeDonnees.getScoreTotal(pseudo, taille)
        GrilleFinis.select(:score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ?", pseudo, taille).sum(:score)
    end
    
    # Renvoie le temps total passé en jeu par un joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getTempsTotal(pseudo)
        return GrilleFinis.where(pseudo: pseudo).sum(:temps)
    end
    
    # Renvoie le score total d'un joueur en fonction d'une difficulté et d'une taille
    # - pseudo le pseudo du joueur
    # - taille la taille de la grille
    # - difficulte la difficulté de la grille
    def BaseDeDonnees.getScoreDifficulte(pseudo, taille, difficulte)
        GrilleFinis.select(:score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ? AND difficulte = ?", pseudo, taille, difficulte).sum(:score)
    end
    
    # Renvoie le classement des meilleurs score en fonction d'une taille de grille et de la difficulté
    # - taille la taille d'une grille
    # - difficulte la difficulté d'une grille
    def BaseDeDonnees.getClassement(taille, difficulte)
        i = 1
        classement = Array.new
        res = GrilleFinis.select(:pseudo, :score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("taille = ? AND difficulte = ?",taille, difficulte).order(score: :desc).all
        res.each do |elem|
            classement.push([i, elem.pseudo, elem.score])
            i += 1
        end
        return classement
    end
    
    # Insertion de grilles dans la base de données
    # - cheminFic le chemin du fichier contenant les grilles
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
    end
    
    # Renvoie le nombre d'hypothèse d'une sauvegarde d'un joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getSauvegardeNbHypotheses(pseudo)
        return Sauvegardes.select(:nb_hypothese).find_by_pseudo(pseudo).nb_hypothese
    end
    
    # Renvoie le nombre d'aides d'une sauvegarde d'un joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getSauvegardeNbAides(pseudo)
        return Sauvegardes.select(:nb_aide).find_by_pseudo(pseudo).nb_aide
    end
    
    # Renvoie le nombre de clic d'une sauvegarde d'un joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getSauvegardeNbClics(pseudo)
        return Sauvegardes.select(:nb_clic).find_by_pseudo(pseudo).nb_clic
    end
    
    # Renvoie le temps d'une sauvegarde d'un joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getSauvegardeTemps(pseudo)
        return Sauvegardes.select(:temps).find_by_pseudo(pseudo).temps
    end
    
    # Renvoie la grille d'une sauvegarde d'un joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getSauvegardeGrilleSauvegardee(pseudo)
        grilleSauvegarde = Sauvegardes.select(:grille_sauvegarde).find_by_pseudo(pseudo).grille_sauvegarde
        return BaseDeDonnees.stringToGrille(grilleSauvegarde)
    end
    
    # Indique si une sauvegarde existe pour un joueur (vrai ou faux)
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.estSauvegarde?(pseudo)
        return Sauvegardes.exists?(:pseudo => pseudo)            
    end
    
    # Renvoie l'identifiant de la grille de la sauvegarde du joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getSauvegardeIdGrille(pseudo)
        return Sauvegardes.select(:id_grille).find_by_pseudo(pseudo).id_grille 
    end
    
    # Supprime la sauvegarde du joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.supprimeSauvegarde(pseudo)
        Sauvegardes.where(:pseudo => pseudo).destroy_all
        return self
    end
    
    # Supprime un défi
    # - pseudoEnv le pseudo du joueur qui a envoyé le défi
    # - pseudoDest le pseudo du joueur qui a reçu le défi
    # - idGrille l'identifiant de la grille
    def BaseDeDonnees.supprimeDefi(pseudoEnv, pseudoDest, idGrille)
        Defis.where(:pseudo => pseudo, :pseudo_defier => pseudoDest, :id_grille => idGrille).destroy_all
        return self
    end
    
    # Supprime tous les succès qu'à accompli le joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.viderReussir(pseudo)
        SuccesAccomplis.where(:pseudo => pseudo).destroy_all
        return self
    end
    
    # Supprime tous les résultats des grilles du joueur
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.viderFinir(pseudo)
        GrilleFinis.where(:pseudo => pseudo).destroy_all
        return self
    end
    
    # Renvoie la taille d'une grille
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleTaille(idGrille)
        return Grilles.select(:taille).find_by_id_grille(idGrille).taille
    end
    
    # Renvoie la difficulté d'une grille
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleDifficulte(idGrille)
        return Grilles.select(:difficulte).find_by_id_grille(idGrille).difficulte
    end
    
    # Renvoie le nombre de clics maximum d'une grille
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleNbClicsMax(idGrille)
        return Grilles.select(:nb_clic_max).find_by_id_grille(idGrille).nb_clic_max
    end
    
    # Renvoie le temps maximum d'une grille
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleTempsMax(idGrille)
        return Grilles.select(:temps_max).find_by_id_grille(idGrille).temps_max
    end
    
    # Transforme un chaine de cractère en grille de cases
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
    
    # Renvoie la matrice de départ d'une grille
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleMatrice(idGrille)
        grilleDepart = Grilles.select(:grille_depart).find_by_id_grille(idGrille).grille_depart
        return BaseDeDonnees.stringToGrille(grilleDepart)
    end
    
    # Renvoie la matrice solution d'une grille
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleMatriceResolue(idGrille)
        grilleSolution = Grilles.select(:grille_solution).find_by_id_grille(idGrille).grille_solution
        return BaseDeDonnees.stringToGrille(grilleSolution)
    end
    
    # Insertion d'une sauvegarde
    # - pseudo le pseudo du joueur
    # - temps le temps effectué par le joueur sur la grille
    # - nbClics le nombre de clics effectué par le joueur 
    # - nbHypotheses le nombre d'hypothèses effectué par le joueur
    # - nbAides le nombre d'aides demandé par le joueur
    # - idGrille l'identifiant de la grille
    # - grilleSauvegarde la sauvegarde la grille sous forme de chaine de caractères
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
    
    # Indique si un pseudo est disponible (vrai ou faux)
    # - pseudo le pseudo à tester
    def BaseDeDonnees.estIdentifiantDisponible?(pseudo)
    	return !Comptes.exists?(:pseudo => pseudo)
    end
    
    # Indique si une adresse mail est disponible (vrai ou faux)
    # - mail l'adresse mail à tester
    def BaseDeDonnees.estMailDisponible?(mail)
    	return !Comptes.exists?(:mail => mail)
    end
    
    # Renvoie le seuil pour obtenir la première étoile
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleEtoileUnScore(idGrille)
    	return Grilles.select(:etoile_1).find_by_id_grille(idGrille).etoile_1
    end
    
    # Renvoie le seuil pour obtenir la deuxième étoile
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleEtoileDeuxScore(idGrille)
    	return Grilles.select(:etoile_2).find_by_id_grille(idGrille).etoile_2
    end
    
    # Renvoie le seuil pour obtenir la troisième étoile
    # - idGrille l'identifiant de la grille 
    def BaseDeDonnees.getGrilleEtoileTroisScore(idGrille)
    	return Grilles.select(:etoile_3).find_by_id_grille(idGrille).etoile_3
    end
    
    # Renvoie l'identifiant d'une grille par rapport à un monde et numèro de niveau
    # - idMonde l'identifiant du monde
    # - numNiveau le numéro du niveau
    def BaseDeDonnees.getMondeGrilleId(idMonde, numNiveau)
    	Grilles.select(:id_grille).where(:id_monde => idMonde, :numero_niveau => numNiveau).first.id_grille	
    end
    
    # Renvoie le nom d'un monde par rapport à son identifiant
    # - idMonde l'identifiant du monde
    def BaseDeDonnees.getMondeNom(idMonde)
	return Mondes.select(:nom_monde).find_by_id_monde(idMonde).nom_monde   
    end
    
    # Renvoie l'identifiant d'une grille de façon alétoire en fonction d'une taille et d'une difficulté
    # - taille la taille de la grille
    # - difficulte la difficulté de la grille
    def BaseDeDonnees.getGrilleIdAleatoire(taille, difficulte)
    	return Grilles.select(:id_grille).where(:taille => taille, :difficulte => difficulte).order("RAND()").first.id_grille
    end
    
    # Renvoie le nombre de grilles accomplis en fonction d'une taille
    # - pseudo le pseudo du joueur
    # - taille la taille de la grille
    def BaseDeDonnees.getNbGrilleTailleFini(pseudo, taille)
    	return GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ?", pseudo, taille).count	
    end
    
    # Renvoie le nombre de grilles accomplis sans aide en fonction d'une difficulte
    # - pseudo le pseudo du joueur
    # - difficulte la difficulte de la grille
    def BaseDeDonnees.getNbGrilleDifficulteSansAideFini(pseudo, difficulte)
    	return GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND difficulte = ? AND nb_aide = ?",pseudo, difficulte, 0).count 
    end
    
    # Renvoie un booleen indiquant l'accomplissement total d'un monde ou non
    # - pseudo le pseudo du joueur
    # - idMonde l'identifiant du monde
    def BaseDeDonnees.estFiniMonde?(pseudo, idMonde)
    	idGrille = Grilles.select(:id_monde).where(:pseudo => pseudo, :id_monde => idMonde).order(numero_niveau: :asc).last.id_grille
    	return GrilleFinis.exists?(:pseudo => pseudo, :id_grille => idGrille)
    end
    
    # Renvoie le nombre de grille accomplis
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getNbGrilleFini(pseudo)
    	return GrilleFinis.where(:pseudo => pseudo).count
    end
    
    # Renvoie le nombre de grilles accompli en moins de 1 minute pour des grilles de taille 12
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getNbGrilleTailleDouzeMoinsSoixante(pseudo)
    	return GrilleFinis.joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ? AND temps < ?",pseudo, 12, 60).count
    end
    
    # Renvoie le nombre de défi gagné
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getNbDefiGagne(pseudo)
    	return Defis.where(:pseudo_vainqueur => pseudo).count
    end
    
    # Renvoie le nom d'un succès à partir de son identifiant
    # - idSucces l'identifiant du succès
    def BaseDeDonnees.getNomSucces(idSucces)
    	return Succes.select(:nom).find_by_id_succes(idSucces).nom 
    end
    
    # Renvoie la somme des étoiles obtenus
    # - pseudo le pseudo du joueur
    def BaseDeDonnees.getTotalNbEtoile(pseudo)
    	GrilleFinis.select(:nb_etoile).find_by_pseudo(pseudo).sum(:nb_etoile)	
    end
end
