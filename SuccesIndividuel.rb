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
        setSuccesDebloque(@idSucces, @compte.pseudo)
    end

    # Méthode pour savoir si un succes un succes
    def estDebloque?()
        return estSuccesDebloque?(@idSucces, @compte.pseudo)
    end

    # Méthode pour obtenir la description du succes
    def description()
        getSuccesDescription(@idSucces)
    end

    # Méthode pour obtenir la condition du succes
    def condition()
        getSuccesCondition(@idSucces)
    end
    
end