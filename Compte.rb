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


    attr_reader: idPseudo

    #*Méthode demande le pseudo , le mot de passe et l'email adresse pour creer un compte 
    def Grille.creer (pseudo,motDePasse,emailAdresse)
      new(pseudo,motDePasse,emailAdresse)
    end
    
    def initialize(pseudo,motDePasse,emailAdresse)
      @pseudo = pseudo
      @motDePasse = motDePasse
      @emailAdresse = emailAdresse
      misEnJourCompte()
    end

    #*méthode qui creer un reperatoir local pour un compte 
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
    def motDePasseLibre?()
        return @motDePasse == nil
    end

    #login avec le pseudo et mot de passe
    def login(String unPseudo,String unMotDePass)
        if(@pseudo == unPseudo && @motDePasse ==unMotDePass)
            return true
        else
            return false
        end
    end

    #recuperer le compte avec l'email adresse
    #!!! pas encore verifier !!!
    def recuperer(String unMail)
        if(@emailAdresse == unMail)
            message = << MESSAGE_END
            From: Private Person <me@fromdomain.com>
            To: A Test User <@emailAdresse.com>
            Subject: Pseudo et Mot de Passe

            "Compte:"@pseudo
            "Mot de passe:"@motDePasse
            MESSAGE_END

            Net::SMTP.start('localhost') do |smtp|
            smtp.send_message message, 'me@fromdomain.com',@emailAdresse
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
