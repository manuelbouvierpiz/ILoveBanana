# encoding: UTF-8

##
# Auteur Alexandre Moutel et Valentin CHAILLOU
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

load 'Interface/TakuzuBuilder.rb'

class Partie10Builder < TakuzuBuilder
    def initialize
        super(__FILE__, "Partie")

		@image1.set_file("Images/espace.png")

		self['window1'].show_all
		
    end

	Gtk.init
	Partie10Builder.new
	Gtk.main
end
