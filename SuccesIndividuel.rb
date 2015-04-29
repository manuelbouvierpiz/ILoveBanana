# == Classe SuccesIndividuel : 
#	- connaît son identifiant
#	- changer son état (debloquer), donner son état (estDebloque?), donner des informations sur elle (nom, description, condition), verifier son état (verifierUnSucces)
class SuccesIndividuel 

    # * Variable d'instance qui représente l'identifiant du *SuccesIndividuel*
    @idSucces

    # * Méthode de classe qui crée un nouveau *SuccesIndividuel*
    def SuccesIndividuel.creer(unIdSucces)
        new(unIdSucces)
    end

    # * Méthode d'instance qui initialise le +SuccesIndividuel+
    def initialize(unIdSucces)
        @idSucces = unIdSucces
    end

    # Rend la méthode new en private
    private_class_method :new
    
    # * Méthode d'instance qui débloque le *SuccesIndividuel* dans la base de donnée pour le joueur
    def debloquer()
        BaseDeDonnees.setSuccesDebloque(@idSucces, Compte.COMPTE.pseudo)
    end

    # * Méthode d'instance qui test l'état du *SuccesIndividuel*
    # * Retourne *true* si le *SuccesIndividuel* est débloqué sinon *false*
    def estDebloque?()
        return BaseDeDonnees.estSuccesDebloque?(@idSucces, Compte.COMPTE.pseudo)
    end
    
    # * Méthode d'instance qui récupère le nom du *SuccesIndividuel* dans la base de donnée
    # * Retourne le *nom*
    def nom()
        return BaseDeDonnees.getNomSucces(@idSucces)
    end

    # * Méthode d'instance qui récupère la description du *SuccesIndividuel* dans la base de donnée
    # * Retourne la *description*
    def description()
        return BaseDeDonnees.getSuccesDescription(@idSucces)
    end

    # * Méthode d'instance qui récupère la condition de déblocage du *SuccesIndividuel* dans la base de donnée
    # * Retourne la *condition*
    def condition()
        return BaseDeDonnees.getSuccesCondition(@idSucces)
    end
    
    # * Méthode d'instance qui test la condition pour débloquer le *SuccesIndividuel*
    # * Retourne la *true* si le succès peut être débloqué, *false* sinon
    def verifierUnSucces()
        res = false
        eval(self.condition())
        return res
    end
end
