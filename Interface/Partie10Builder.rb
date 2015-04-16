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
		@pixbuf = Gdk::Pixbuf.new("Images/espace.png")
		@pixmap = @pixbuf.render_pixmap_and_mask(0.95)[0]
		
		self['window1'].signal_connect('expose-event') {
		#	self['window1'].window.draw_pixbuf(self['window1'].style.bg_gc(Gtk::STATE_NORMAL), @pixbuf, 0, 0, 0, 0, -1, -1, Gdk::RGB::Dither::NONE, 0, 0)
			self['window1'].window.set_back_pixmap(@pixmap, false)
		}

		# TODO => Créer un Gtk::Style à partir du pixmap puis associer la fenêtre au Gtk::Style
    end

	Gtk.init
	Partie10Builder.new
	Gtk.main
end
