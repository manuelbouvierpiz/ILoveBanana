# encoding: UTF-8

# Kuang Nanzhen
# Modifications apportées par Valentin CHAILLOU
# Classe Compte
# Opérations sur le compte personnel
#======Classe Compte=====

# == Classe Compte :
#		- respecte le pattern <b>SINLGETON</b>
#		- connaît son pseudo, ses Statistiques, ses Options et ses Succes
#		- sait créer un Compte, connecter un Compte, donner son mail, son nom, son prénom, changer de mot de passe, vérifier une adresse et un identifiant, donner son score pour une Grille, dire si il a une sauvegarde et supprimer la sauvegarde
class Compte
	
	# Variable de classe
	
	# * Variable de classe représentant le *Compt*e selon le pattern singleton
	# * Accessible en lecture via la méthode de classe COMPTE
	@@COMPTE
	
	# * Variable d'instance accessible en lecture uniquement qui représente le pseudo du *Compte*
	attr_reader :pseudo
		
	# * Variable d'instance accessible en lecture uniquement qui représente les *Statistiques*
	attr :statistiques, false
	
	# * Variable d'instance accessible en lecture uniquement qui représente les *Options*
	attr :options, false
	
	# * Variable d'instance accessible en lecture uniquement qui représente les *Succes*
	attr :succes, false
	
	# Méthodes de classe
		
	# * Méthode de classe qui permet d'accéder au *Compte* en lecture
	# * Retourne le COMPTE (pattern singleton)
	def Compte.COMPTE
		return @@COMPTE
	end

	# * Méthode de classe qui demande le pseudo , le mot de passe et l'adresse email pour créer un *Compte*
	# * === Attributs :
	#		- unPseudo : un *String* représentant le pseudo du *Compte*
	#		- unMotDePasse : un *String* représentant le mot de passe du *Compte*
	# * *ATTENTION* : Etant donné que la classe respecte le pattern singleton, la méthode de classe change automatiquement la variable de classe COMPTE et renvoie nil
	# * <b>N'EST PAS UN CONSTRUCTEUR</b>
	def Compte.creer (unPseudo, unMotDePasse, unMail, unPrenom, unNom)
	  BaseDeDonnees.setCompte(unPseudo, unMotDePasse, unNom, unPrenom, unMail)
	end
	
	# * Méthode de classe qui permet de connecter l'utilisateur au *Jeu*
	# * === Attributs :
	#		- unPseudo : un *String* représentant le pseudo du *Compte*
	#		- unMotDePasse : un *String* représentant le mot de passe du *Compte*
	# * *ATTENTION* : Etant donné que la classe respecte le pattern singleton, la méthode de classe change automatiquement la variable de classe COMPTE et la renvoie
	# * Ne pas oublier qu'un login peut échouer. Dans ce cas, le pseudo est égal à nil
	def Compte.login (unPseudo, unMotDePasse)
	  @@COMPTE = loginPrive(unPseudo, unMotDePasse)
	  return @@COMPTE
	end
	
	# * Méthode de classe qui permet de connecter l'utilisateur à la partie
	# ===== Attributs :
	#   - unPseudo : un *String* représentant le pseudo du *Compte*
	#   - unMotDePasse : un *String* représentant le mot de passe du *Compte*
	# * *ATTENTION* : Etant donné que la classe respecte le pattern singleton, la méthode de classe change automatiquement la variable de classe COMPTE et la renvoie
	def Compte.loginPrive (unPseudo, unMotDePasse) # :nodoc:
	  new(unPseudo, unMotDePasse)
	end
	
	private_class_method :new
	private_class_method :loginPrive
	
	# * Méthode de classe qui vérifie la disponibilité d'un identifiant
	# * === Attribut :
	#		- unIdentifiant : un *String* représentant un pseudo dont il faut vérifier la disponibilité
	# * Retourne *true* si le pseudo est disponible, *false* sinon
	def Compte.verifierIdentifiant?(unIdentifiant)
		return BaseDeDonnees.estIdentifiantDisponible?(unIdentifiant)
	end
	
	# * Méthode de classe qui vérifie la disponibilité d'une adresse mail
	# * === Attribut :
	#		- unMail : un *String* représentant une adresse mail dont il faut vérifier la disponibilité
	# * Retourne *true* si l'adresse mail est disponible, *false* sinon
	def Compte.verifierMail?(unMail)
		return BaseDeDonnees.estMailDisponible?(unMail)
	end

	# * Méthode de classe qui vérifie si le mot de passe est bien celui du *Compte* dont le pseudo est donné
	# * === Attribut :
	#		- unPseudo : un *String* représentant un pseudo
	#		- unMotDePasse : un *String* représentant un mot de passe
	# * Retourne *true* si le mot de passe est bien celui du *Compte* dont le pseudo est donné, *false* sinon
	def Compte.verifierMotDePasse?(unPseudo, unMotDePasse)
		return BaseDeDonnees.estBonsIdentifiants?(unPseudo, unMotDePasse)
	end
	
	# * Méthode de classe qui permet de récupérer un *Compte* en lui attribuant un mot de passe aléatoire et un mail contenant le nouveau mot de passe
	# * === Attribuys :
	#		- unMail : un *String* représentant l'adresse mail du *Compte* à récupérer
	#		- unPseudo : un *String* représentant le pseudo du *Compte* à récupérer
	# * Retourne *self*
	def Compte.recuperer(unMail, unPseudo)
		
		options = { :address			  => "smtp.gmail.com",
			:port				 => 587,
			:domain			   => 'gmail.com',
			:user_name			=> 'TakuzuAvengers',
			:password			 => 'bananekiwidu72',
			:authentication	   => 'plain',
			:enable_starttls_auto => true  }

		Mail.defaults do
  			delivery_method :smtp, options
		end
		
		Mail.deliver do
			to unMail
			from 'TakuzuAvengers@gmail.com'
			subject 'Récupération de votre mot de passe TakuzuAvengers'
			body "Bonjour,\nVotre mot de passe est " + Compte.attribuerMotDePasseAleatoire(unPseudo) + "\nCordialement,\n\nLe groupe 1"
		end
		return self
	end

	# * Méthode de classe qui attribue un mot de passe aléatoire de 6 chiffres à un *Compte*
	# * === Attribut :
	#		- unPseudo : un *String* représentant le pseudo du *Compte* dont il faut modifier le mot de passe
	# * Retourne un *String* représentant le nouveau mot de passe
	def Compte.attribuerMotDePasseAleatoire(unPseudo)
		prng = Random.new(Time.now.to_i)
		unMotDePasse = prng.rand(100000..999999).to_s
		BaseDeDonnees.setMotDePasse(unPseudo, unMotDePasse)
		return unMotDePasse
	end
	
	# * Méthode de classe qui permet de vérifier si un pseudo et une adresse mail appartiennent bien au même *Compte*
	# * === Attributs :
	#		- unPseudo : un *String* représentant un pseudo
	#		- unMail : un *String* représentant une adresse mail
	# * Retourne *true* si les deux éléments font partie du même <b>Compte</b>, *false* sinon
	def Compte.verifierAdressePseudo?(unPseudo, unMail)
		if Compte.verifierMail?(unMail) || Compte.verifierIdentifiant?(unPseudo)
			return false
		end
		return unMail == BaseDeDonnees.getMail(unPseudo)
	end
	
	# Méthodes d'instance
	
	# * Méthode d'instance qui intialise le *Compte*
	def initialize(unPseudo, unMotDePasse)	# :nodoc:
		if BaseDeDonnees.estBonsIdentifiants?(unPseudo, unMotDePasse)
			@pseudo = unPseudo
		# Sinon erreur => Exception ?
		end
		@statistiques = Statistiques.new
		@options = Options.creer(unPseudo)
		@succes = Succes.new
	end
	
	# * Méthode d'instance qui retourne l'adresse mail du *Compte*
	# * Retourne un *String* représentant le mail du *Compte*
	def mail()
		return BaseDeDonnees.getMail(@pseudo)
	end
	
	# * Méthode d'instance qui retourne le nom du *Compte*
	# * Retourne un *String* représentant le nom du *Compte*
	def nom()
		return BaseDeDonnees.getNom(@pseudo)
	end
	
	# * Méthode d'instance qui retourne le prénom du *Compte*
	# * Retourne un *String* représentant le prénom du *Compte*
	def prenom()  
		return BaseDeDonnees.getPrenom(@pseudo)
	end

	# * Méthode d'instance qui permet de changer le mot de passe du *Compte*
	# * === Attribut :
	#		- unMotDePasse : un *String* représentant le nouveau mot de passe à attribuer au *Compte*
	# * Retourne *self*
	def changerMotDePasse(unMotDePasse)
		BaseDeDonnees.setMotDePasse(@pseudo, unMotDePasse)
		return seld
	end
	
	# * Méthode d'instance qui retourne le score réalisé sur une *Grille* par le *Compte*
	# * === Attribut :
	#		- uneGrille : une *Grille* dont il faut savoir le score du *Compte*
	# * Retourne un entier représentant le score du *Compte* sur la *Grille*
	def scorePourLaGrille(uneGrille)
		return BaseDeDonnees.getScore(@pseudo, uneGrille.idGrille)
	end
	
	# * Méthode d'instance qui permet de savoir si le *Compte* avait une partie en cours
	# * Retourne *true* si il a une partie sauvegardée, *false* sinon
	def aUneSauvegarde?()
		return BaseDeDonnees.estSauvegarde?(@pseudo)
	end
	
	# * Méthode d'instance qui permet de supprimer la sauvegarde du *Compte*
	# * Retourne *self*
	def supprimeSauvegarde()
		BaseDeDonnees.supprimeSauvegarde(@pseudo)
		return self
	end
	
	# * Méthode d'instance qui permet de réinitialiser le *Compte*
	# * <b>SUPPRIME TOUTE LA PROGRESSION DU COMPTE DANS LA BASE DE DONNEES</b>
	# * Retourne *self*
	def reinitialiser()
		BaseDeDonnees.viderFinir(@pseudo)
		BaseDeDonnees.viderReussir(@pseudo)
		Compte.COMPTE.reinitialiserAventure()
		return self
	end
	
	# * Méthode d'instance qui réinitialise l'*Aventure*
	# * Ne touche pas à la BDD, met juste à jour les *PartieMonde* qui pouvaient ne pas l'être suite à une optimisation
	# * Retourne *self*
	def reinitialiserAventure()
		0.upto(7) do |i|
			if(Jeu.JEU.aventure.mondes[i].estDebloque?)
				0.upto(39) do |j|
					if(Jeu.JEU.aventure.mondes[i].partie(j).estDebloque?)
						Jeu.JEU.aventure.mondes[i].partie(j).etat=(false)
					else
						break
					end
				end
				Jeu.JEU.aventure.mondes[i].etat=(false)
			else
				break
			end
		end
		return self
	end
end
