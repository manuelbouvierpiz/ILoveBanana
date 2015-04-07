# encoding: UTF-8

#Kuang Nanzhem
# Modifications apportées par Valentin CHAILLOU
#Class Compte
#Opération sur le compte presonnel
#======Class Compte=====

load 'BaseDeDonnees.rb'

require 'mail'

class Compte
    
    # Variables de classe
    
    # * Variable de classe représentant le COMPTE selon le pattern singleton
    # * Accessible en lecture via la méthode de classe COMPTE
    @@COMPTE
    
	# * Variable d'instance qui représente le pseudo du +Compte+
    attr_reader :pseudo
    	
    # * Méthode de classe qui permet d'accéder au COMPTE en lecture
    # * Retourne le COMPTE (pattern singleton)
    def Compte.COMPTE
    	return @@COMPTE
    end

    # * Méthode de classe qui demande le pseudo , le mot de passe et l'adresse email pour créer un +Compte+
    # ===== Attributs :
    #   - unPseudo : un +String+ représentant le pseudo du +Compte+
    #   - unMotDePasse : un +String+ représentant le mot de passedu +Compte+
    # * +ATTENTION+ : Etant donné que le classe respecte le pattern singleton, la méthode de classe change automaiquement la variable de classe COMPTE et renvoie nil
    #  * <b>N'EST PAS UN CONSTRUCTEUR</b>
    def Compte.creer (unPseudo, munMotDePasse, unMail, nuPrenom, unNom)
      BaseDeDonnees.setCompte(unPseudo, unMotDePasse, unNom, unPrenom, unMail)
    end
    
    # * Méthode de classe qui permet de connecter l'utilisateur à la partie
    # ===== Attributs :
    #   - unPseudo : un +String+ représentant le pseudo du +Compte+
    #   - unMotDePasse : un +String+ représentant le mot de passedu +Compte+
    # * +ATTENTION+ : Etant donné que le classe respecte le pattern singleton, la méthode de classe change automaiquement la variable de classe COMPTE et la renvoie
    # * Ne pas oublier qu'un login peut échouer. Dans ce cas, le pseudo est égal à nil
    def Compte.login (unPseudo, unMotDePasse)
      @@COMPTE = Compte.loginPrive(unPseudo, unMotDePasse)
      return @@COMPTE
    end
    
    # * Méthode de classe qui permet de connecter l'utilisateur à la partie
    # ===== Attributs :
    #   - unPseudo : un +String+ représentant le pseudo du +Compte+
    #   - unMotDePasse : un +String+ représentant le mot de passedu +Compte+
    # * +ATTENTION+ : Etant donné que le classe respecte le pattern singleton, la méthode de classe change automaiquement la variable de classe COMPTE et la renvoie
    def Compte.loginPrive (unPseudo, unMotDePasse) # :nodoc:
      new(unPseudo, unMotDePasse)
    end
    
    private_class_method :new
    private_class_method :loginPrive
    
    # Méthodes d'instance
    
    # * Méthode d'instance qui intialise le +Compte+
    def initialize(unPseudo, unMotDePasse)
      if BaseDeDonnees.estBonsIdentifiants?(unPseudo, unMotDePasse)
    	@pseudo = unPseudo
      # Sinon erreur => Exception ?
      end
    end
    
    # * Méthode d'instance qui retourne un String représentant le nom du +Compte+
    def mail()
        return BaseDeDonnees.getMail(@pseudo)
    end
    
    # * Méthode d'instance qui retourne un String représentant le nom du +Compte+
    def nom()
        return BaseDeDonnees.getNom(@pseudo)
    end
    
    # * Méthode d'instance qui retourne un String représentant le prénom du +Compte+
    def prenom()  
        return BaseDeDonnees.getPrenom(@pseudo)
    end

	# * Méthode d'instance qui vérifie la disponibilité d'un identifiant
    def Compte.verifierIdentifiant?(unIdentifiant)
        return BaseDeDonnees.estIdentifiantDisponible?(unIdentifiant)
    end
    
    # * Méthode d'instance qui vérifie la disponibilité d'une adresse mail
    def Compte.verifierMail?(unMail)
        return BaseDeDonnees.estMailDisponible?(unMail)
    end

    # * Méthode d'instance qui vérifie le mot de passe
    def Compte.verifierMotDePasse?(unPseudo, unMotDePasse)
        return BaseDeDonnees.estBonsIdentifiants?(unPseudo, unMotDePasse)
    end
    
    #recuperer le compte avec l'adresse email
    def Compte.recuperer(unMail)
        
        options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'gmail.com',
            :user_name            => 'TakuzuAvengers',
            :password             => 'bananekiwidu72',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

		Mail.defaults do
  			delivery_method :smtp, options
		end
		
		Mail.deliver do
			to unMail
			from 'TakuzuAvengers@gmail.com'
			subject 'Récupération de votre mot de passe TakuzuAvengers'
			body "Bonjour,\nVotre mot de passe est " + attribuerMotDePasseAleatoire() + "\nCordialement,\n\nLe groupe 1"
		end
    end

    # * Méthode d'instance qui change le mot de passe
    def changerMotDePasse(unMotDePasse)
        BaseDeDonnees.setMotDePasse(@pseudo, unMotDePasse)
    end

    # * Méthode d'instance qui attribue un mot de passe aléatoire de 6 chiffres
    def attribuerMotDePasseAleatoire()
    	unMotDePasse = prng.rand(100000..999999).to_s
        changerMotDePasse(unMotDePasse)
        return unMotDePasse
    end
    
    # * Méthode d'instance qui retourne le score réalisé sur un niveau de l'aventure
    # * Marche théoriquement sur tous les types de partie mais non testé
    def scorePourLeNiveau(unePartieMonde)
    	BaseDeDonnes.getScore(@pseudo, unePartieMonde.grille.idGrille)
    end

end
