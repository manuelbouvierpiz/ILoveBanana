# encoding: UTF-8

##
# Auteur Pierre Jacoboni
# Version 0.1 : Date : Mon Jul 01 10:17:02 CEST 2013
#
require 'gtk2'

#changer le path unshift pour chercher dans le répertoire père
$LOAD_PATH.unshift File.expand_path("../../Interface", __FILE__)
load 'TakuzuBuilder.rb'

class Partie_8Builder < TakuzuBuilder
    def initialize
        super(__FILE__, "Partie")
    end
end
