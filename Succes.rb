# encoding: UTF-8

load 'SuccesIndividuel.rb'
#class Succes 
# -represente le liste de succes qui est definit en base de donneese
class Succes
    
    attr_reader :succes
    
    # Méthode de classe
    
    # * Méthode de classe qui permet de créer un nouvel objet Succes
    def Succes.creer
        new
    end
    
    # Méthodes d'instance
    
    # Initialiseur
    def initialize()
        @succes = BaseDeDonnees.getSucces();
    end
    
    # Méthode pour obtenir le nombre de succes possible
    def nbSuccesTotal()
        return @succes.length
    end

    # Méthode pour debloquer un succes
    #  - Si le succes est dans le liste 
    def debloquer(unSucces)
        0.upto(@succes.length) do |i| # i pour index
            if(unSucces == @succes[i])
                @succes[i].debloquer()
            end
        end
    end
    
end
