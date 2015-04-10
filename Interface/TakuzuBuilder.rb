# encoding: UTF-8
# Valentin CHAILLOU
require 'gtk2'

class TakuzuBuilder < Gtk::Builder
	
	def ouvrirFenetre(uneFenetre)
		self['window1'].destroy
		Gtk.main
	end
end