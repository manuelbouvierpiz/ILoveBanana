#Kuang Nanzhem
# Modifications apportées par Valentin CHAILLOU
#Class Compte
#Opération sur le compte presonnel
#======Class Compte=====
require 'net/smtp'
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

    # * Méthode d'instance qui vérifie le mot de passe
    def verifierMotDePasse?(unMotDePasse)
        return BaseDeDonnees.estBonsIdentifiants(@pseudo, unMotDePasse)
    end
=begin
    #recuperer le compte avec l'email adresse - A terminer
    #http://www.tutorialspoint.com/ruby/ruby_sending_email.htm
    def Compte.recuperer(String unMail,opts={})
        if(@emailAdresse == unMail)
            opts[:server]      ||= 'localhost'
            opts[:from]        ||= 'email@example.com'
            opts[:from_alias]  ||= 'Example Emailer'
            opts[:subject]     ||= "Takuzu : pseudo et mot de passe"
            opts[:body]        ||= "Compte :" + @pseudo + " \n Mot de passe : " + @motDePasse
message = <<MESSAGE_END
    From: #{opts[:from_alias]} <#{opts[:from]}>
    To: <#{unMail}>
    Subject: #{opts[:subject]}

     #{opts[:body]}
MESSAGE_END
             Net::SMTP.start(opts[:server]) do |smtp|
                smtp.send_message msg, opts[:from], unMail
            end
        end
    end
=end

    # * Méthode d'instance qui change le mot de passe
    def changerMotDePasse(unMotDePasse)
        BaseDeDonnees.setMotDePasse(@pseudo, unMotDePasse)
    end

    # * Méthode d'instance qui attribue un mot de passe aléatoire de 6 chiffres
    def attribuerMotDePasseAleatoire()
        changerMotDePasse(prng.rand(100000..999999).to_s)
    end
    
    # * Méthode d'instance qui retourne le score réalisé sur un niveau de l'aventure
    # * Marche théoriquement sur tous les types de partie mais non testé
    def scorePourLeNiveau(unePartieMonde)
    	BaseDeDonnes.getScore(@pseudo, unePartieMonde.grille.idGrille)
    end

end
