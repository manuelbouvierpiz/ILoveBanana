# encoding: UTF-8

##
# Auteurs : Alexandre Moutel et Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class Partie6Builder < TakuzuBuilder
    def initialize(unMonde, unePartie)
        super(__FILE__, "Partie")

		@image1.set_file(unMonde.image)

		@partie = unePartie
		
    end

	def initialize(unePartie)
		super(__FILE__, "Partie")

		@partie = unePartie
	end

	def Partie10Builder.creer(unMonde, unePartie)
		new(unMonde, unePartie)
	end

	def Partie10Builder.creer(unePartie)
		new(unePartie)
	end

	private_class_method :new
end
