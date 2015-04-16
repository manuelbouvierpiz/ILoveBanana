# encoding: UTF-8

##
# Auteurs : Alexandre Moutel et Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#

require 'gtk2'

load 'Interface/PartieBuilder.rb'

# == Classe PartieBuilder :
#	- est une PartieBuilder
#	- est considérée comme une classe abstraite
#	- connaît sa partie
class Partie10Builder < PartieBuilder
    def initialize(unePartie, unMonde)
        super(__FILE__, unePartie, unMonde)
		
    end

	def initialize(unePartie)
		super(__FILE__, unePartie)

	end

	def Partie10Builder.creer(unePartie, unMonde)
		new(unMonde, unePartie)
	end

	def Partie10Builder.creer(unePartie)
		new(unePartie)
	end

	private_class_method :new
end
