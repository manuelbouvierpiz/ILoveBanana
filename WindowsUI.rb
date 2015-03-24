##
# Auteur NANZHEN KUANG
# Version 0.1 : Date : Tue Mar 24 15:42:08 CET 2015
#
begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk2'
Gtk.init

class WindowsUI
    @window
    
    def initialize()
        @window = Window.new()
    end


end # Marqueur de fin de classe
