#Class Compte
#Opération sur le compte presonnel
#======Class Compte=====
require 'net/smtp'
class Compte
    #variable
    #* idPseudo - l'id du grille
    @idPseudo

    #*pseudo - pseudo de personne
    @pseudo

    #*motDePasse - mot de passe
    @motDePasse

    #*emailAdresse - email adresse
    @emailAdresse

    #*nom - nom de personne
    @nom

    #*prenom - prenom de personne 
    @prenom


    attr_reader :idPseudo , :pseudo , :motDePasse , :emailAdresse , :nom , :prenom

    #*Méthode demande le pseudo , le mot de passe et l'email adresse pour creer un compte 
    def Compte.creer (pseudo,motDePasse,emailAdresse)
      new(pseudo,motDePasse,emailAdresse)
    end
    
    def initialize(pseudo,motDePasse,emailAdresse)
      @pseudo = pseudo
      @motDePasse = motDePasse
      @emailAdresse = emailAdresse
      @nom = nil
      @prenom = nil
      misEnJourCompte()
    end
    
    #*mettre le Compte dans le BDD
    def misEnJourCompte()
      BaseDeDonnees.setCompte(@pseudo,@motDePasse,@nom,@prenom,@emailAdresse)
    end
    
    def nom(String nom)
        @nom = nom
        misEnJourCompte()
    end
    
    def prenom(String prenom)  
        @prenom = prenom
        misEnJourCompte()
    end

    #verifier le mot de passe
    def verifierMotDePasse?(unMotDePasse)
        if(@motDePasse == unMotDePasse)
          return true
        else 
          return false
    end

    #est-ce que le mot de passe est vide
    def Compte.motDePasseLibre?()
        return @motDePasse == nil
    end

    #login avec le pseudo et mot de passe
    def Compte.login(String unPseudo,String unMotDePass)
        if(@pseudo == unPseudo && @motDePasse ==unMotDePass)
            return true
        else
            return false
        end
    end

    #recuperer le compte avec l'email adresse
    #http://www.tutorialspoint.com/ruby/ruby_sending_email.htm
    def Compte.recuperer(String unMail,opts={})
        if(@emailAdresse == unMail)
            opts[:server]      ||= 'localhost'
            opts[:from]        ||= 'email@example.com'
            opts[:from_alias]  ||= 'Example Emailer'
            opts[:subject]     ||= "Takuzu : pseudo et mot the passe"
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

    #changer le mot de passe
    def changerMotDePasse(String unMotDePasse)
        @motDePasse = unMotDePasse
        misEnJourCompte()
    end

    #attribuer un mot de passe aleatoire en 6 chiffre
    def attribuerMotDePasseAleatoire()
        prng = Random.new()
        #attribuer un mot de passe avec 6 chiffre aleatoire
        @motDePasse = prng.rand(100000..999999).to_s
        misEnJourCompte()
    end

end
