# encoding: UTF-8

# Valentin CHAILLOU et Damien PARMENON

### Test des gems ###

desGems = [["gtk2", "gtk2"], ["mail", "mail"], ["active_record", "activerecord"], ["mysql2", "mysql2"]]

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

load 'Aventure.rb'
load 'BaseDeDonnees.rb'
load 'Case.rb'
load 'ClassesBdd.rb'
load 'Compte.rb'
load 'Defi.rb'
load 'Didacticiel.rb'
load 'Grille.rb'
load 'GrilleHardcore.rb'
load 'Jeu.rb'
load 'Monde.rb'
load 'Options.rb'
load 'Partie.rb'
load 'PartieDidacticiel.rb'
load 'PartieLibre.rb'
load 'PartieMonde.rb'
load 'RaccourciClavier.rb'
load 'SauvegardeTemporaire.rb'
load 'Statistiques.rb'
load 'Succes.rb'
load 'SuccesIndividuel.rb'
load 'Interface/TakuzuBuilder.rb'
load 'Interface/AProposBuilder.rb'
load 'Interface/ChoixGrilleBuilder.rb'
load 'Interface/ChoixGrilleSuiteBuilder.rb'
load 'Interface/ChoixMondeBuilder.rb'
load 'Interface/ClassementBuilder.rb'
load 'Interface/ConnexionBuilder.rb'
load 'Interface/DefiBuilder.rb'
load 'Interface/ListeDefiBuilder.rb'
load 'Interface/MenuPrincipalBuilder.rb'
load 'Interface/OptionsBuilder.rb'
load 'Interface/PartieBuilder.rb'
load 'Interface/PartieReussieBuilder.rb'
load 'Interface/StatistiquesBuilder.rb'
load 'Interface/SuccesBuilder.rb'
load 'Interface/TailleDifficulteBuilder.rb'
load 'Interface/InscriptionBuilder.rb'

### Lancement de TakuzuAvengers ###

# We are 'go' for launch !
ConnexionBuilder.lancer
