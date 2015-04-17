# encoding: UTF-8

##
# Auteur Kuang Nanzhem, Modification Parmenon Damien
# Version 0.2 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'
class OptionsBuilder < TakuzuBuilder

	attr :adjBruitage, false
	attr :adjMusique, false
	
	def initialize() 
		super(__FILE__,"Options")
		@adjBruitage =  Gtk::Adjustment.new(1,1,100,1,1,0)
		@hscaleBruitage.adjustment = @adjBruitage
		@adjMusique =  Gtk::Adjustment.new(1,1,100,1,1,0)
		@hscaleMusique.adjustment = @adjMusique
		
		@adjBruitage.value = Compte.COMPTE.options.getVolumeBruitage
		@adjMusique.value = Compte.COMPTE.options.getVolumeMusique

		@entry1.set_text(Compte.COMPTE.options.getRaccourci(1))
		@entry2.set_text(Compte.COMPTE.options.getRaccourci(2))
		@entry3.set_text(Compte.COMPTE.options.getRaccourci(3))
		@entry4.set_text(Compte.COMPTE.options.getRaccourci(4))

		stringColor1 = Compte.COMPTE.options.couleur(1)
		stringColor2 = Compte.COMPTE.options.couleur(2)
		@colorbutton1.color = Gdk::Color.new(stringColor1[1..4].to_i(16), stringColor1[5..8].to_i(16), stringColor1[9..12].to_i(16))
		@colorbutton2.color = Gdk::Color.new(stringColor2[1..4].to_i(16), stringColor2[5..8].to_i(16), stringColor2[9..12].to_i(16))
	end
	
	def on_buttonPrecedent_clicked	
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end

	def on_buttonValider_clicked
		Compte.COMPTE.options.modifierVolumeBruitage(@adjBruitage.value)
		Compte.COMPTE.options.modifierVolumeMusique(@adjMusique.value)
		
		Compte.COMPTE.options.changerRaccourci(1, @entry1.text)
		Compte.COMPTE.options.changerRaccourci(2, @entry2.text)
		Compte.COMPTE.options.changerRaccourci(3, @entry3.text)
		Compte.COMPTE.options.changerRaccourci(4, @entry4.text)

		Compte.COMPTE.options.changerCouleur(1,@colorbutton1.color.to_s)
		Compte.COMPTE.options.changerCouleur(2,@colorbutton2.color.to_s)
		print @colorbutton2.color
		ouvrirFenetre(MenuPrincipalBuilder.new)
	end
end
