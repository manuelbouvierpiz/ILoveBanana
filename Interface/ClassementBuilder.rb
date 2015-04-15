# encoding: UTF-8

##
# Auteur Alexandre Moutel
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

class ClassementBuilder < Gtk::Builder

	def initialize
		super(__FILE__, "Classement")
    end
end
