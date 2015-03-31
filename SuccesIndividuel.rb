class SuccesIndividuel 

    # Variables
    @compte
    @idSucces

    # Constructeur
    def SuccesIndividuel.creer(unCompte, unIdSucces)
        new(unCompte, unIdSucces)
    end

    # Initialiseur
    def initialize(unCompte, unIdSucces)
        @compte = unCompte
        @idSucces = unIdSucces
    end

    # Rend la méthode new en private
    private_class_method :new
    
    # Méthode pour débloquer un succes
    def debloquer()
            BaseDeDonnees.setSuccesDebloque(@idSucces, @compte.pseudo)
    end

    # Méthode pour savoir si un succes debloque
    def estDebloque?()
        return BaseDeDonnees.estSuccesDebloque?(@idSucces, @compte.pseudo)
    end

    # Méthode pour obtenir la description du succes
    def description()
        BaseDeDonnees.getSuccesDescription(@idSucces)
    end

    # Méthode pour obtenir la condition du succes
    def condition()
        BaseDeDonnees.getSuccesCondition(@idSucces)
    end
    
end
