# encoding: UTF-8
# Valentin CHAILLOU
require 'gtk2'

class TakuzuBuilder < Gtk::Builder
	
	def initialize
	
		self.add_from_file(__FILE__.sub(".rb",".glade"))
		self['window1'].set_window_position Gtk::Window::POS_CENTER
		self['window1'].signal_connect('destroy') { Gtk.main_quit }
		self['window1'].show_all
		# Creation d'une variable d'instance par composant glade
		self.objects.each() { |p|
		instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
		}
		self.connect_signals{ |handler|
		puts handler
		method(handler)
		}
		
	end
	
	def ouvrirFenetre(uneFenetre)
		self['window1'].destroy
		Gtk.main
	end
end
