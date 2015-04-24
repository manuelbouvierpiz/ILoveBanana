# encoding: UTF-8

##
# Damien Parmenon
#

class PartieDefiEchecBuilder < PartieEchecBuilder

	def initialize
        super()
        @labelEchec.text = "Vous avez perdu le défi."
    end
end
