# encoding: UTF-8

# Valentin CHAILLOU et Damien PARMENON

### Test des gems ###

desGems = [['gtk2', 'gtk2'], ['mail', 'mail'], ['active_record', 'activerecord'], ['mysql2', 'mysql2']]

desGems.each do |unDoublon|
	begin
		require unDoublon[0]
	rescue LoadError
		print("Installation de la gem " + unDoublon[1] + "...\n")
		system("gem install " + unDoublon[1])
		exec("ruby", "TakuzuLanceur.rb")	# On redémarre ruby pour qu'il prenne en compte les changements concernant les gems
	end
end

### Chargement des classes ###

desClasses = [
	'Case.rb',
	'Grille.rb',
	'GrilleHardcore.rb',
	'Partie.rb',
	'PartieLibre.rb',
	'PartieDidacticiel.rb',
	'PartieMonde.rb',
	'Monde.rb',
	'Aventure.rb',
	'BaseDeDonnees.rb',
	'ClassesBdd.rb',
	'Compte.rb',
	'Defi.rb',
	'Didacticiel.rb',
	'Options.rb',
	'RaccourciClavier.rb',
	'SauvegardeTemporaire.rb',
	'Statistiques.rb',
	'Succes.rb',
	'SuccesIndividuel.rb',
	'Jeu.rb',
	'Interface/TakuzuBuilder.rb',
	'Interface/AProposBuilder.rb',
	'Interface/ChoixGrilleBuilder.rb',
	'Interface/ChoixGrilleSuiteBuilder.rb',
	'Interface/ChoixMondeBuilder.rb',
	'Interface/ClassementBuilder.rb',
	'Interface/ConnexionBuilder.rb',
	'Interface/DefiBuilder.rb',
	'Interface/ListeDefiBuilder.rb',
	'Interface/MenuPrincipalBuilder.rb',
	'Interface/OptionsBuilder.rb',
	'Interface/PartieBuilder.rb',
	'Interface/PartieLibreBuilder.rb',
	'Interface/PartieMondeBuilder.rb',
	'Interface/PartieDidacticielBuilder.rb',
	'Interface/PartieReussieBuilder.rb',
	'Interface/PartieLibreReussieBuilder.rb',
	'Interface/PartieMondeReussieBuilder.rb',
	'Interface/PartieDidacticielReussieBuilder.rb',
	'Interface/PartieEchecBuilder.rb',
	'Interface/StatistiquesBuilder.rb',
	'Interface/SuccesBuilder.rb',
	'Interface/TailleDifficulteBuilder.rb',
	'Interface/InscriptionBuilder.rb',
	'Interface/ReglesBuilder.rb'
]

load 'Interface/ChargementBuilder.rb'
Gtk.init
laFenetre = ChargementWindow.new
Gtk.main
desClasses.each do |uneClasse|
	laFenetre.afficheClasse(uneClasse)
	load uneClasse
end
Gtk.main_quit

### Lancement de TakuzuAvengers ###

# We are 'go' for launch !
ConnexionBuilder.lancer
