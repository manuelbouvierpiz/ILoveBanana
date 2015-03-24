
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
      #Creer une réperatoire de presonne
      Dir.mkdir("usr/"+@pseudo)
      #Creer une file pour sauvagarder le mot de passe
      filename = File.join(@pseudo,"cache")
      cache = File.new(filename, "w")
      cache.puts @motDepasse
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
    
    def login(String unPseudo,String unMOtDePass)
        
    end
    
    def recuperer(String unMail)
        
    end
    
    def changerMotDePasse(String unMotDePasse)
        
    end
    
    def attribuerMotDePasseAleatoire()
    
    end

end
