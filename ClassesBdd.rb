##
# Auteur RONAN YZEUX
# Version 0.1 : Date : Mon Mar 16 15:01:11 CET 2015
#

class Grilles < ActiveRecord::Base
	self.table_name = :grille
end

class GrilleFinis < ActiveRecord::Base
	self.table_name = :grille_fini
end

class Comptes < ActiveRecord::Base
	self.table_name = :compte
end

class Succes < ActiveRecord::Base
    self.table_name = :succes
end

class SuccesAccomplis < ActiveRecord::Base
    self.table_name = :succes_accompli
end

class Defis < ActiveRecord::Base
    self.table_name = :defi
end

class Monde < ActiveRecord::Base
    self.table_name = :monde
end

class RaccourciComptes < ActiveRecord::Base
    self.table_name = :raccourci_compte
end

class Sauvegardes < ActiveRecord::Base
    self.table_name = :sauvegarde
end
