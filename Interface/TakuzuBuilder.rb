# encoding: UTF-8
# Valentin CHAILLOU


# == Classe TakuzuBuilder :
#	- est considérée comme une classe abstraite
#	- est la classe mère de toute fenêtre
#	- connaît sa fenêtre précédente
#	- sait ouvrir une nouvelle fenêtre et sa fenêtre précédente
class TakuzuBuilder < Gtk::Builder
	
	# Variables d'instance
	
	# * Variable d'instance accessible en lecture/écriture qui représente la fenêtre précédente de cette fenêtre
	attr :fenetrePrecedente, true

	# * Variable d'instance (un entier) non accessible qui représente l'id du handler 'destroy'
	# * Sera utilisée lors de la désactivation du handler
	@handlerDestroy
	
	# Méthodes d'instance
	
	# Méthode d'instance qui initialise la fenêtre
	def initialize(unNom, unNomDeFenetre="Takuzu Avengers") # :nodoc:
		super()
	
		self.add_from_file(unNom.sub(".rb",".glade"))
		self['window1'].set_window_position Gtk::Window::POS_CENTER
		@handlerDestroy = self['window1'].signal_connect('destroy') { Gtk.main_quit }
		self['window1'].set_icon('Images/icone.png')
		self['window1'].show_all
		# Creation d'une variable d'instance par composant glade
		self.objects.each() { |p|
			instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
		}
		self.connect_signals{ |handler|
			puts handler
			method(handler)
		}
		
		self['window1'].set_title(unNomDeFenetre)
		
	end
	
	# * Méthode d'instance qui ouvre une nouvelle fenêtre et NE ferme PAS la précédente
	# ===== Attribut :
	#	- uneFenetre : une fenetre (telle que FenetreBuilder.new())
	def ouvrirFenetreNonFermante(uneFenetre)
		uneFenetre.fenetrePrecedente = self
	end
	
	# * Méthode d'instance qui ouvre une nouvelle fenêtre et ferme la précédente
	# ===== Attribut :
	#	- uneFenetre : une fenetre (telle que FenetreBuilder.new())
	def ouvrirFenetre(uneFenetre)
		ouvrirFenetreNonFermante(uneFenetre)
		self['window1'].signal_handler_disconnect(@handlerDestroy)	# Le signal n'arrête pas Gtk
		self['window1'].destroy
	end

	# * Méthode d'instance qui ouvre la fenêtre précédente (à n'utiliser qu'avec des fenêtres non fermantes)
	# * <b>ACHTUNG</b> : la fenêtre précédente est la fenêtre précédemment ouverte
	def ouvrirFenetrePrecedente()
		@fenetrePrecedente['window1'].show_all
		ouvrirFenetre(@fenetrePrecedente)
	end
end
