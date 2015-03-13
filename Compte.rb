
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
    end
    
    def verifierMotDePasse?(unMotDePasse)
        if(@motDePasse ==unMotDePasse)
          return true
        else 
          return false
    end
    
    def motDePasseLibre?()
        return @motDePasse == nil
    end
    
    def login()
end
