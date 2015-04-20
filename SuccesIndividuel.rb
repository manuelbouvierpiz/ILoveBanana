#class succesIndividuel
class SuccesIndividuel 

    # Variable
    @idSucces

    # Constructeur
    def SuccesIndividuel.creer(unIdSucces)
        new(unIdSucces)
    end

    # Initialiseur
    def initialize(unIdSucces)
        @idSucces = unIdSucces
    end

    # Rend la méthode new en private
    private_class_method :new
    
    # Méthode pour débloquer un succes
    def debloquer()
        BaseDeDonnees.setSuccesDebloque(@idSucces, Compte.COMPTE.pseudo)
    end

    # Méthode pour savoir si un succes debloque
    def estDebloque?()
        return BaseDeDonnees.estSuccesDebloque?(@idSucces, Compte.COMPTE.pseudo)
    end

    def nom()
        return BaseDeDonnees.getNomSucces(@idSucces)
    end

    # Méthode pour obtenir la description du succes
    def description()
        return BaseDeDonnees.getSuccesDescription(@idSucces)
    end

    # Méthode pour obtenir la condition du succes
    def condition()
        return BaseDeDonnees.getSuccesCondition(@idSucces)
    end
    
    def verifierUnSucces()
        res = false
        eval(self.condition())
        return res
    end
end
