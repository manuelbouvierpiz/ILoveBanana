require 'gtk2'

class ChargementWindow < Gtk::Window

	def initialize
		super()
		self.title = "Chargement"
		self.set_default_size(500, 500)
		self.window_position=(Gtk::Window::POS_CENTER_ALWAYS)
		self.signal_connect('destroy') { Gtk.main_quit }
		self.show_all
	end

	def afficheClasse(uneClasse)
		self.add(Gtk::Label.new("Chargement de " + uneClasse, false))
		self.show_all
	end
end