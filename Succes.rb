# encoding: UTF-8
# Yseux Ronan, Parmenon Damien

# == Classe Succes : 
#   - connaît tout les SuccesIndividuel existant
#   - permet la vérification et le déblocage des succès
class Succes
    
    # Variables
    
    # * Variable d'instance qui contient tout les *SuccesIndividuel*
    # * Accessible en lecture uniquement
    # * Est intialisée lors de la création de *Succes*
    attr_reader :succes
    
    # Méthodes d'instance
    
    # * Initialise la classe *Succes* avec tout les *SuccesIndividuel* contenus dans la base de données
    def initialize()
        @succes = BaseDeDonnees.getSucces();
    end
    
    # * Méthode pour obtenir le nombre de succes existant
    # * Retourne un entier representant le nombre de succes existant
    def nbSuccesTotal()
        return @succes.length
    end

    # * Méthode pour debloquer un succes en faisant appel à la fonction de même nom de la classe *SuccesIndividuel*
    def debloquer(unSucces)
        0.upto(@succes.length) do |i| # i pour index
            if(unSucces == @succes[i])
                @succes[i].debloquer()
            end
        end
    end
    
    # * Méthode vérifiant pour chaque *SuccesIndividuel* s'il est apte a être débloquer et le débloque si oui
    def verifierTousLesSucces()
        @succes.each do |unSucces|
            if(!unSucces.estDebloque?)
                if(unSucces.verifierUnSucces())
                    unSucces.debloquer()
                end
            end
        end
    end
end
