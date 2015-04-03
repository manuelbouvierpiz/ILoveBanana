	##
# Auteur RONAN YZEUX
# Version 0.1 : Date : Sat Mar 14 15:57:38 CET 2015
#
require "digest/md5"

class BaseDeDonnee
	ActiveRecord::Base.establish_connection(
		:adapter => "mysql2",
		:database => "6zp2nn69",
		:username => "6zp2nn69",
		:password => "BDDProjet2015",
	    :host => "sql2.olympe.in"
	)
   
    private_class_method :new
    
	def BaseDeDonnee.getDifficulte(idGrille)
		return Grilles.select(:difficulte).find_by_id_grille(idGrille).difficulte
	end

	def BaseDeDonnee.getNbClicsMax(idGrille)
		return Grilles.select(:nb_clic_max).find_by_id_grille(idGrille).nb_clic_max
	end

	def BaseDeDonnee.getTempsMax(idGrille)
		return Grilles.select(:temps_max).find_by_id_grille(idGrille).temps_max
	end

	def BaseDeDonnee.getScore(pseudo, idGrille)
		return GrilleFinis.select(:score).find_by(pseudo: pseudo, id_grille: idGrille).score
	end

	def BaseDeDonnee.getTemps(pseudo, idGrille)
		return GrilleFinis.select(:temps).find_by(pseudo: pseudo, id_grille: idGrille).temps
	end

	def BaseDeDonnee.estGrilleResolue?(pseudo, idGrille)
		return GrilleFinis.exists?(:pseudo => pseudo, :id_grille => idGrille)
	end

	def BaseDeDonnee.setGrilleTermine(pseudo, idGrille, temps, nbClics, nbEtoiles, nbHypotheses, nbAides, score)
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
	
	def BaseDeDonnee.getNbClics(pseudo, idGrille)
		return GrilleFinis.select(:nb_clic).find_by(pseudo: pseudo, id_grille: idGrille).nb_clic
	end
	
	def BaseDeDonnee.getMail(pseudo)
		return Comptes.select(:adresse_mail).find_by_pseudo(pseudo).adresse_mail
	end
	
	def BaseDeDonnee.getNom(pseudo)
		return Comptes.select(:nom).find_by_pseudo(pseudo).nom
	end
	
	def BaseDeDonnee.getPrenom(pseudo)
		return Comptes.select(:prenom).find_by_pseudo(pseudo).prenom
	end
	
	def BaseDeDonnee.getCouleurUn(pseudo)
		return Comptes.select(:couleur_1).find_by_pseudo(pseudo).couleur_1
	end

	def BaseDeDonnee.estBonsIdentifiants?(pseudo, motDePasse)
		return Comptes.exists?(:pseudo => pseudo, :mot_de_passe => motDePasse)
	end

	def BaseDeDonnee.setCouleurUn(pseudo, couleur)
		Comptes.where(:pseudo => pseudo).update_all(couleur_1: couleur)
		return self
	end

	def BaseDeDonnee.getCouleurDeux(pseudo)
		return Comptes.select(:couleur_2).find_by_pseudo(pseudo).couleur_2
	end

	def BaseDeDonnee.setCouleurDeux(pseudo, couleur)
		Comptes.where(:pseudo => pseudo).update_all(couleur_2: couleur)
		return self
	end

	def BaseDeDonnee.setMotDePasse(pseudo, motDePasse)
		Comptes.where(:pseudo => pseudo).update_all(mot_de_passe: motDePasse)
		return self
	end

	def BaseDeDonnee.getVolumeMusique(pseudo)
		return Comptes.select(:volume_musique).find_by_pseudo(pseudo).volume_musique
	end

	def BaseDeDonnee.setVolumeMusique(pseudo, volume)
		Comptes.where(:pseudo => pseudo).update_all(volume_musique: volume)
		return self
	end

	def BaseDeDonnee.getVolumeBruitage(pseudo)
		return Comptes.select(:volume_bruitage).find_by_pseudo(pseudo).volume_bruitage
	end

	def BaseDeDonnee.setVolumeBruitage(pseudo, volume)
		Comptes.where(:pseudo => pseudo).update_all(volume_bruitage: volume)
		return self
	end

    def BaseDeDonnee.getSucces()
        res = Succes.all
        succes = Array.new
        res.each do |elem|
            succes.push(SuccesIndividuel.creer(elem.id_succes))
        end
        return succes
    end

    def BaseDeDonnee.estSuccesDebloque?(idSucces, pseudo)
        return SuccesAccomplis.exists?(:id_succes => idSucces, :pseudo => pseudo)
    end

    def BaseDeDonnee.setSuccesDebloque(idSucces, pseudo)
        newSucces = SuccesAccomplis.new
        newSucces.pseudo = pseudo
        newSucces.id_succes = idSucces
        newSucces.save
        return self
    end

    def BaseDeDonnee.getSuccesDescription(idSucces)
        return Succes.select(:description).find_by_id_succes(idSucces).description
    end

    def BaseDeDonnee.getSuccesCondition(idSucces)
        return Succes.select(:condition).find_by_id_succes(idSucces).condition
    end

    def BaseDeDonnee.getDefis(pseudoDest)     
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

    def BaseDeDonnee.setDefi(pseudoDest, pseudoEnv, idGrille, score)
        newDefis = Defis.new
        newdefis.pseudo = pseudoEnv
        newDefis.pseudo_defier = pseudoDest
        newDefis.id_grille = idGrille
        newDefis.score = score
        newDefis.save
        return self
    end

    def BaseDeDonnee.getMondeNom(idMonde)
        return Mondes.select(:nom_monde).find_by(id_monde: idMonde).nom_monde
    end

    def BaseDeDonnee.getDefiScore(pseudoEnv, pseudoDest, idGrille)
        return Defis.select(:score).find_by(pseudo: pseudoEnv, pseudo_defier: pseudoDest, id_grille: idGrille).score
    end

    def BaseDeDonnee.setCompte(pseudo, mdp, nom, prenom, mail)
        newCompte = Comptes.new
        newCompte.pseudo = pseudo
        newCompte.mot_de_passe = Digest::MD5.hexdigest(mdp)
        newCompte.nom = nom
        newCompte.prenom = prenom
        newCompte.adresse_mail = mail
        newCompte.save
    end

    def BaseDeDonnee.setRaccourci(pseudo, idRaccourci, touche)
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

    def BaseDeDonnee.getRaccourci(pseudo, idRaccourci)
        return RaccourciComptes.select(:touche).find_by(pseudo: pseudo, id_raccourci: idRaccourci).touche
    end
    
    def BaseDeDonnee.getScoreTotal(pseudo, taille)
        GrilleFinis.select(:score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ?", pseudo, taille).sum(:score)
    end

    def BaseDeDonnee.getTempsTotal(pseudo)
        return GrilleFinis.where(pseudo: pseudo).sum(:temps)
    end

    def BaseDeDonnee.getScoreDifficulte(pseudo, taille, difficulte)
        GrilleFinis.select(:score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("pseudo = ? AND taille = ? AND difficulte = ?", pseudo, taille, difficulte).sum(:score)
    end

    def BaseDeDonnee.getClassement(taille, difficulte)
        i = 1
        classement = Array.new
        res = GrilleFinis.select(:pseudo, :score).joins("JOIN grille ON grille.id_grille = grille_fini.id_grille").where("taille = ? AND difficulte = ?",taille, difficulte).order(score: :desc).all
        res.each do |elem|
            classement.push([i, elem.pseudo, elem.score])
            i += 1
        end
        return classement
    end

    def BaseDeDonnee.addGrille(cheminFic)
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

    def BaseDeDonnee.getSauvegardeNbHypotheses(pseudo)
        return Sauvegardes.select(:nb_hypothese).find_by_pseudo(pseudo).nb_hypothese
    end

    def BaseDeDonnee.getSauvegardeNbAides(pseudo)
        return Sauvegardes.select(:nb_aide).find_by_pseudo(pseudo).nb_aide
    end

    def BaseDeDonnee.getSauvegardeNbClics(pseudo)
        return Sauvegardes.select(:nb_clic).find_by_pseudo(pseudo).nb_clic
    end

    def BaseDeDonnee.getSauvegardeTemps(pseudo)
        return Sauvegardes.select(:temps).find_by_pseudo(pseudo).temps
    end

    def BaseDeDonnee.getSauvegardeGrilleSauvegardee(pseudo)
        grilleSauvegarde = Sauvegardes.select(:grille_sauvegarde).find_by_pseudo(pseudo).grille_sauvegarde
        return BaseDeDonnee.stringToGrille(grilleSauvegarde)
    end

    def BaseDeDonnee.estSauvegarde?(pseudo)
        return Sauvegardes.exists?(:pseudo => pseudo)            
    end

    def BaseDeDonnee.getSauvegardeIdGrille(pseudo)
        return Sauvegardes.select(:id_grille).find_by_pseudo(pseudo).id_grille 
    end

    def BaseDeDonnee.supprimeSauvegarde(pseudo)
        Sauvegardes.where(:pseudo => pseudo).destroy_all
        return self
    end

    def BaseDeDonnee.supprimeDefi(pseudoEnv, pseudoDest, idGrille)
        Defis.where(:pseudo => pseudo, :pseudo_defier => pseudoDest, :id_grille => idGrille).destroy_all
        return self
    end

    def BaseDeDonnee.viderReussir(pseudo)
        SuccesAccomplis.where(:pseudo => pseudo).destroy_all
        return self
    end

    def BaseDeDonnee.viderFinir(pseudo)
        GrilleFinis.where(:pseudo => pseudo).destroy_all
        return self
    end

    def BaseDeDonnee.getGrilleTaille(idGrille)
        return Grilles.select(:taille).find_by_id_grille(idGrille).taille
    end

    def BaseDeDonnee.getGrilleDifficulte(idGrille)
        return Grilles.select(:difficulte).find_by_id_grille(idGrille).difficulte
    end

    def BaseDeDonnee.getGrilleNbClicsMax(idGrille)
        return Grilles.select(:nb_clic_max).find_by_id_grille(idGrille).nb_clic_max
    end

    def BaseDeDonnee.getGrilleTempsMax(idGrille)
        return Grilles.select(:temps_max).find_by_id_grille(idGrille).temps_max
    end

    def BaseDeDonnee.stringToGrille(grille)
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

    def BaseDeDonnee.getGrilleMatrice(idGrille)
        grilleDepart = Grilles.select(:grille_depart).find_by_id_grille(idGrille).grille_depart
        return BaseDeDonnee.stringToGrille(grilleDepart)
    end

    def BaseDeDonnee.getGrilleMatriceResolue(idGrille)
        grilleSolution = Grilles.select(:grille_solution).find_by_id_grille(idGrille).grille_solution
        return BaseDeDonnee.stringToGrille(grilleSolution)
    end
    
    def BaseDeDonnee.setSauvegarde(pseudo, temps, nbClics, nbHypotheses, nbAides, idGrille, grilleSauvegarde)
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
end
