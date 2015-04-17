# encoding: UTF-8

##
# Version 0.2 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'
load 'Interface/MenuPrincipalBuilder.rb'
load 'Options.rb'
class OptionsBuilder < TakuzuBuilder
	
	attr :pseudo ,false

	@adjBruitage
	@adjMusique
	
	def initialize(pseudo) 

		super(__FILE__,"Options")
	end
	
	def on_buttonPrecedent_clicked
		
		BaseDeDonnees.setVolumeBruitage(@pseudo,@adjBruitage.value)
		BaseDeDonnees.setVolumeMusique(@pseudo,@adjMusique.value)
		
		BaseDeDonnees.setRaccourci(pseudo, 1, @entry1)
		BaseDeDonnees.setRaccourci(pseudo, 2, @entry2)
		BaseDeDonnees.setRaccourci(pseudo, 3, @entry3)

		BaseDeDonnees.setCouleurUn(pseudo,@colorbutton1.color)
		BaseDeDonnees.setCouleurDeux(pseudo,@colorbutton2.color)

		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
	
	
	def DefiBuilder.lancer(pseudo)
		Gtk.init
		OptionsBuilder.new(pseudo)
		Gtk.main
    	end

	def OptionsBuilder.ceer(pseudo)
		@pseudo = pseudo 

		@adjBruitage =  Gtk::Adjustment.new(BaseDeDonnees.getVolumeBruitage(pseudo),0,100,1,1,0)
		@hscaleBruitage.adjustment = @adjBruitage
		@adjMusique =  Gtk::Adjustment.new(BaseDeDonnees.getVolumeMusique(pseudo),0,100,1,1,0)
		@hscaleMusique.adjustment = @adjMusique
		
		@entry1 = BaseDeDonnees.getRaccourci(pseudo,1)
		@entry2 = BaseDeDonnees.getRaccourci(pseudo,2)
		@entry3 = BaseDeDonnees.getRaccourci(pseudo,3)

		@colorbutton1.color = BaseDeDonnees.getCouleurUn(pseudo)
		@colorbutton2.color = BaseDeDonnees.getCouleurDeux(pseudo)
	end
end
