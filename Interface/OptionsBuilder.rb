# encoding: UTF-8

##
# Version 0.2 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
load 'Interface/TakuzuBuilder.rb'
load 'Interface/MenuPrincipalBuilder.rb'
load 'Options.rb'
load 'Compte.rb'
class OptionsBuilder < TakuzuBuilder
	
	attr :pseudo ,false

	@adjBruitage
	@adjMusique
	
	def initialize() 
		super(__FILE__,"Options")
	end
	
	def on_buttonPrecedent_clicked
		
		BaseDeDonnees.setVolumeBruitage(Compte.COMPTE.pseudo,@adjBruitage.value)
		BaseDeDonnees.setVolumeMusique(Compte.COMPTE.pseudo,@adjMusique.value)
		
		BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, 1, @entry1)
		BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, 2, @entry2)
		BaseDeDonnees.setRaccourci(Compte.COMPTE.pseudo, 3, @entry3)

		BaseDeDonnees.setCouleurUn(Compte.COMPTE.pseudo,@colorbutton1.color)
		BaseDeDonnees.setCouleurDeux(Compte.COMPTE.pseudo,@colorbutton2.color)

		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
	
	
	def DefiBuilder.lancer()
		Gtk.init
		OptionsBuilder.new()
		Gtk.main
    	end

	def OptionsBuilder.ceer()
		@adjBruitage =  Gtk::Adjustment.new(BaseDeDonnees.getVolumeBruitage(Compte.COMPTE.pseudo),0,100,1,1,0)
		@hscaleBruitage.adjustment = @adjBruitage
		@adjMusique =  Gtk::Adjustment.new(BaseDeDonnees.getVolumeMusique(Compte.COMPTE.pseudo),0,100,1,1,0)
		@hscaleMusique.adjustment = @adjMusique
		
		@entry1 = BaseDeDonnees.getRaccourci(Compte.COMPTE.pseudo,1)
		@entry2 = BaseDeDonnees.getRaccourci(Compte.COMPTE.pseudo,2)
		@entry3 = BaseDeDonnees.getRaccourci(Compte.COMPTE.pseudo,3)

		@colorbutton1.color = BaseDeDonnees.getCouleurUn(Compte.COMPTE.pseudo)
		@colorbutton2.color = BaseDeDonnees.getCouleurDeux(Compte.COMPTE.pseudo)
	end
end
