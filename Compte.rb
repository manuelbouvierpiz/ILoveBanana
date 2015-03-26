
#Kuang Nanzhen
#Class Compte
#Opération sur le compte presonnel
#======Class Compte=====

class Compte
    @pseudo
    @motDePasse
    @emailAdresse
    @nom
    @prenom
    
    def Grille.creer (pseudo,motDePasse,emailAdresse)
      new(pseudo,motDePasse,emailAdresse)
    end
    
    def initialize(pseudo,motDePasse,emailAdresse)
      @pseudo = pseudo
      @motDePasse = motDePasse
      @emailAdresse = emailAdresse
      misEnJourCompte()
    end
    
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
    
    def verifierMotDePasse?(unMotDePasse)
        if(@motDePasse == unMotDePasse)
          return true
        else 
          return false
    end
    
    def motDePasseLibre?()
        return @motDePasse == nil
    end
    
    def login(String unPseudo,String unMotDePass)
        if(@pseudo == unPseudo && @motDePasse ==unMotDePass)
            return true
        else
            return false
        end
    end
    
    def recuperer(String unMail)
        if(@emailAdresse == unMail)
        {
            puts "votre compte est " + @pseudo
            puts "votre mot de passe est " + @motDePasse
        }
    end
    
    def changerMotDePasse(String unMotDePasse)
        @motDePasse = unMotDePasse
    end
    
    def attribuerMotDePasseAleatoire()
        prng = Random.new()
        #attribuer un mot de passe avec 6 chiffre aleatoire
        @motDePasse = prng.rand(100000..999999)
    end

end
