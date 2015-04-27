# encoding: UTF-8

# Valentin CHAILLOU et Damien PARMENON

# == Classe +Chargement+ :
#	- connaît les gems et classes à charger
#	- sait les charger
class Chargement

	# Variables de classe

	# * Variable de classe non accessible représentant les gems à charger
	@@gems = [['gtk2', 'gtk2'], ['mail', 'mail'], ['active_record', 'activerecord'], ['mysql2', 'mysql2']]

	# * Variable de classe non accessible représentant les classes à charger
	@@classes = [
		'Case.rb',
		'Grille.rb',
		'GrilleHardcore.rb',
		'Partie.rb',
		'PartieLibre.rb',
		'PartieDidacticiel.rb',
		'PartieMonde.rb',
		'PartieSauvegarde.rb',
		'PartieDefi.rb',
		'Monde.rb',
		'Aventure.rb',
		'BaseDeDonnees.rb',
		'ClassesBdd.rb',
		'Compte.rb',
		'Defi.rb',
		'Didacticiel.rb',
		'RaccourciClavier.rb',
		'Options.rb',
		'Statistiques.rb',
		'Succes.rb',
		'SuccesIndividuel.rb',
		'Jeu.rb',
		'Interface/AProposBuilder.rb',
		'Interface/ChoixGrilleBuilder.rb',
		'Interface/ChoixGrilleSuiteBuilder.rb',
		'Interface/ChoixMondeBuilder.rb',
		'Interface/ClassementBuilder.rb',
		'Interface/ConnexionBuilder.rb',
		'Interface/DefiBuilder.rb',
		'Interface/MenuPrincipalBuilder.rb',
		'Interface/OptionsBuilder.rb',
		'Interface/ReinitialisationConfirmationBuilder.rb',
		'Interface/PartieBuilder.rb',
		'Interface/PartieLibreBuilder.rb',
		'Interface/PartieMondeBuilder.rb',
		'Interface/PartieDefiBuilder.rb',
		'Interface/PartieDidacticielBuilder.rb',
		'Interface/PartieSauvegardeBuilder.rb',
		'Interface/PartieReussieBuilder.rb',
		'Interface/PartieLibreReussieBuilder.rb',
		'Interface/PartieMondeReussieBuilder.rb',
		'Interface/PartieDidacticielReussieBuilder.rb',
		'Interface/PartieSauvegardeReussieBuilder.rb',
		'Interface/PartieDefiReussiBuilder.rb',
		'Interface/PartieEchecBuilder.rb',
		'Interface/PartieDefiEchecBuilder.rb',
		'Interface/StatistiquesBuilder.rb',
		'Interface/SuccesBuilder.rb',
		'Interface/TailleDifficulteBuilder.rb',
		'Interface/InscriptionBuilder.rb',
		'Interface/ReglesBuilder.rb',
		'Interface/OubliMotDePasseBuilder.rb',
		'Interface/ChargementSauvegardeBuilder.rb'
	]
	
	# * Variable de classe accessible en lecture représentant la classe en train d'être chargée
	@@element = ""
	
	# * Variable de classe accessible en lecture représentant le pourcentage du chargement
	@@pourcentage = 0
	
	# Méthodes de classe
	
	private_class_method :new
	
	# * Méthode de classe qui permet d'accéder en lecture à la classe en train d'être chargée
	def Chargement.element
		return @@element
	end
	
	# * Méthode de classe qui permet d'accéder en lecture au pourcentage de chargement
	def Chargement.pourcentage
		return @@pourcentage
	end
	
	# * Méthode de classe qui charge toutes les gems et toutes les classes
	# * Est responsable de la création de la fenêtre de chargement
	def Chargement.charger
	
		### Test des gems ###
	
		@@gems.each do |unDoublon|
			begin
				require unDoublon[0]
			rescue LoadError
				print("Installation de la gem " + unDoublon[1] + "...\n")
				system("gem install " + unDoublon[1])
				exec("ruby", "TakuzuLanceur.rb")	# On redémarre ruby pour qu'il prenne en compte les changements concernant les gems
			end
		end

		### Chargement des classes ###
			
		print("Chargement")

		load 'Interface/TakuzuBuilder.rb'
		print(".")
		load 'Interface/ChargementBuilder.rb'
		print(".")
		
		# Lancement d'un nouveau Thread pour que la fenêtre ne bloque pas le chargement des classes
		unThread = Thread.new { ChargementBuilder.lancer }
		
		@@classes.each do |uneClasse|
			@@element = uneClasse
			@@pourcentage += ((1.0 / @@classes.size) * 100).to_i
			print(".")
			load @@element
		end
		
		print(" Terminé !\n")
		
		@@element = nil

		while unThread.alive?
			# On attend que la fenêtre de chargement se soit fermée
		end
		
	end
	
end

### Lancement de TakuzuAvengers ###

Chargement.charger

# We are 'go' for launch !
ConnexionBuilder.lancer
