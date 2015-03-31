
#class Succes 
# -represente le liste de succes qui est definit en base de donneese
class Succes
    @succes
    
    # Initialiseur
    def initialize()
        @succes = BaseDeDonnees.getSucces();
    end

    attr_reader :succes
    # Méthode pour obtenir le nombre de succes possible
    def nbSuccesTotal()
        return @succes.length
    end

    # Méthode pour debloquer un succes
    #  - Si le succes est dans le liste 
    def debloquer(unSucces)
        0.upto(@succes.length) do |i|
            if(unSucces == @succes[i])
                @succes[i].debloquer()
            end
        end
    end
    
end
