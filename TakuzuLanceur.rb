load 'Aventure.rb'
load 'BaseDeDonnees.rb'
load 'Case.rb'
# Valentin CHAILLOU et Damien PARMENON

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

### Test des gems ###

desGems = [['mail', 'mail'], ['active_record', 'activerecord'], ['mysql2', 'mysql2']]

begin
	require 'gtk2'
rescue
	puts("GTK2 n'est pas installé sur votre système")
end

desGems.each do |unDoublon|
	begin
		require unDoublon[0]
	rescue
		begin
			system("gem install " + unDoublon[1])
			require unDoublon[0]
		rescue
			print("La gem " + unDoublon[1] + "est manquante. Veuillez l'installer manuellement")
		end
	end
end

# We are 'go' for launch !
ConnexionBuilder.lancer
