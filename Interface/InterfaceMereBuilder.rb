

class InterfaceMereBuilder < Gtk::Builder
	@@fenetreActuelle = nil

	def initialize
		super()
		if @@fenetreActuelle != nil
			@@fenetreActuelle.fermeToi
		end
		@@fenetreActuelle = self
	end

	def fermeToi
    	self['window1'].destroy
	end
end
