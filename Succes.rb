class Succes

    # Constructeur
    def Succes.creer()
        new()
    end

    # Initialiseur
    def initialize()
        
    end

    # Rend la méthode new en private
    private_class_method :new

    # Méthode pour obtenir le nombre de succes possible
    def nbSuccesTotal()
        return getSucces().length
    end

    # Méthode pour debloquer un succes
    def debloquer(unSucces)
        unSucces.debloquer()
    end
    
end