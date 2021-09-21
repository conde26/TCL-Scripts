#!/usr/bin/tclsh
#Autor: Jose Conde 
#Script para modificar el hostname en Linux

#Paletilla de colores
set amarillo "\33\[33m"
set verde "\33\[32m"
set rojo "\33\[31m"
set normal "\33\[0m"


#Variables para programa
set NombreAntiguo [exec hostname]

#Ayuda de Programa
if {[llength $argv] != 1 } {
   puts "\n$rojo\[!] Uso: $argv0 <Nombre_Nuevo>\n $normal"
   exit 1
}

#Cambiar Nombre Equipo
puts -nonewline "\n$amarillo\[!]$verde El nombre actual de tu equipo es:$amarillo $NombreAntiguo $normal\n"
puts -nonewline "\n$amarillo\[?]$verde Desea cambiar el nombre (y/n): $amarillo"; flush stdout
set respuesta [gets stdin]; puts "$normal"

#Respuesta cambio nombre
if { $respuesta == "y" } {
   set argumentos [lindex $argv 0]
   exec /bin/bash -c "hostname $argumentos"
   set nom [open "/etc/hostname" w+]; puts $nom "$argumentos"; close $nom
   set nom1 [open "/etc/hosts" w+]
   puts $nom1 "127.0.0.1       localhost
   127.0.1.1       $argumentos

   # The following lines are desirable for IPv6 capable hosts
   ::1     ip6-localhost ip6-loopback
   fe00::0 ip6-localnet
   ff00::0 ip6-mcastprefix
   ff02::1 ip6-allnodes
   ff02::2 ip6-allrouters"
   close $nom1
   puts "$amarillo\[!]$verde El nombre se cambio correctamente$normal"
   exit 0
} elseif { $respuesta == "n" } {
    puts "$amarillo\[!]$verde Esta bien, hasta la proxima $normal"
    exit 0
} else {
    puts "$rojo\[!] Respuesta no valida $normal"
    exit 1
}

