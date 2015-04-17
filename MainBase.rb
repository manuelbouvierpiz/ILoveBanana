##
# Auteur RONAN YZEUX
# Version 0.1 : Date : Sat Jan 17 17:13:04 CET 2015
#
#require "rubygems"
require "active_record"
#load "SuccesIndividuel.rb"
#load "Case.rb"


# sudo apt-get install mysql-client libmysqlclient-dev 


puts BaseDeDonnee.getDifficulte(1)
puts BaseDeDonnee.getScore("pseudo12", 1)
puts BaseDeDonnee.getNbClicsMax(1)
puts BaseDeDonnee.getTempsMax(1)
puts BaseDeDonnee.getTemps("pseudo12", 1)
puts BaseDeDonnee.estGrilleResolue?("pseudo12", 1)
#puts BaseDeDonnee.setGrilleTermine("pseudo20", 1, 10, 2, 80, 0, 1, 40000)
puts BaseDeDonnee.getNbClics("pseudo12", 1)
puts BaseDeDonnee.getMail("pseudo12")
puts BaseDeDonnee.getNom("pseudo12")
puts BaseDeDonnee.getPrenom("pseudo12")
puts BaseDeDonnee.getCouleurUn("pseudo12")
puts BaseDeDonnee.estBonsIdentifiants?("pseudo12", "allo")
BaseDeDonnee.setCouleurUn("pseudo12", 4)
puts BaseDeDonnee.getCouleurDeux("pseudo12")
BaseDeDonnee.setCouleurDeux("pseudo12", 5)
BaseDeDonnee.setMotDePasse("pseudo12", "123456")
puts BaseDeDonnee.getVolumeMusique("pseudo12")
BaseDeDonnee.setVolumeMusique("pseudo12", 2)
puts BaseDeDonnee.getVolumeBruitage("pseudo12")
BaseDeDonnee.setVolumeBruitage("pseudo12", 3)
puts BaseDeDonnee.estSuccesDebloque?(1, "pseudo12")
puts BaseDeDonnee.getTempsTotal("pseudo12")
puts BaseDeDonnee.getScoreTotal("pseudo12", 6)
puts BaseDeDonnee.getScoreDifficulte("pseudo12", 6, 3)
res = BaseDeDonnee.getClassement(6, 3)
print res[0][0], " , ", res[0][1], " , ", res[0][2]
puts
print res[1][0], " , ", res[1][1], " , ", res[1][2]
#BaseDeDonnee.addGrille("BaseBineroParNiveau.txt")
puts
puts BaseDeDonnee.getSuccesDescription(2)
#res2 = BaseDeDonnee.getSucces()
#puts res2[0]
#puts res2[1]
res3 = BaseDeDonnee.getSauvegardeGrilleSauvegardee("pseudo12")
0.upto(5) do |z|
   0.upto(5) do |y|
       print res3[z][y]
   end
   print "\n"
end

puts res3.length
BaseDeDonnee.supprimeSauvegarde("pseudo13")
#BaseDeDonnee.setSauvegarde("pseudo13", 50, 36, 0, 0, 2, res3)
#BaseDeDonnee.setCompte("pseudo20", "titi", "jean", "bernard", "bernard@hotmail.fr")






