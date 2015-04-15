# encoding: UTF-8

##
# Auteur Alexandre Moutel, Parmenon Damien (Code Ruby)
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'

class ClassementBuilder < TakuzuBuilder

	def initialize
		super(__FILE__, "Classement")
		0.upto(7) { |n|
			@combobox1.set_entry("#{n}")
		}

		@combobox2.append_text("6")
		@combobox2.append_text("8")
		@combobox2.append_text("10")
		@combobox2.append_text("12")
    end

    def on_button2_clicked
    	ouvrirFenetre(StatistiquesBuilder.new)
    end

    def on_button3_clicked
    	ouvrirFenetre(SuccesBuilder.new)
    end
    Gtk.init
    ClassementBuilder.new
    Gtk.main

end
