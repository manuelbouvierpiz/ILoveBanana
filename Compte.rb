#Kuang Nanzhen
#Class Compte
#Opération sur le compte presonnel
#======Class Compte=====
require 'net/smtp'
class Compte
    #variable
    #* diPseudo - l'id du grille
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


    attr_reader :idPseudo , :pesudo , :motDePasse , :emailAdresse , :nom , :prenom

    #*Méthode demande le pseudo , le mot de passe et l'email adresse pour creer un compte 
    def Grille.creer (pseudo,motDePasse,emailAdresse)
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
    
    
    def nom(String nom)
        @nom = nom
    end
    
    def prenom(String prenom)  
        @prenom = prenom
    end
    
    #*méthode qui creer un reperatoire local pour un compte et l'ajouter dans le base de donnee
    def misEnJourCompte()
      #Creer une réperatoire presonnage
      Dir.mkdir("usr/"+@pseudo)
      #Creer une file pour sauvagarder le mot de passe
      filename = File.join(@pseudo,"cache")
      cache = File.new(filename, "w")
      cache.puts @motDepasse
      cache.puts @emailAdresse
      #changer le droite de ce fille
      file.chmod( 0755 )
      cache.close
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
    end

    #attribuer un mot de passe aleatoire en 6 chiffre
    def attribuerMotDePasseAleatoire()
        prng = Random.new()
        #attribuer un mot de passe avec 6 chiffre aleatoire
        @motDePasse = prng.rand(100000..999999).to_s
    end

end
