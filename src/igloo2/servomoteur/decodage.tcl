restart 

#****************************************************  
#[Configuration de l'unité de temps de la simulation]
#****************************************************
set UserTimeUnit ns
#*******************
#[Global Variables ]
#*******************

#**************************************
#[Déclaration des signaux de l'élément]
#**************************************
restart -force -nowave 
 
add wave rw_edge 
add wave -radix hexadecimal addr_bus_i  		
add wave -radix hexadecimal data_bus_io   


add wave -radix hexadecimal servomoteur_status 
add wave -radix hexadecimal servomoteur_frequence 
add wave -radix hexadecimal servomoteur_angle 	


proc ecritureAdresse {addresse  donnee} {
   force addr_bus_i [format {x"%X"} $addresse]	 
   force data_bus_io [format {x"%X"} $donnee]
   force rw_i 1
   run 100ns	
   force rw_i 0 
   run 200ns
}
proc lectureAdresse {addresse } {
   force addr_bus_i [format {x"%X"} $addresse]
   noforce data_bus_io
   force rw_i 0
   run 100ns	
   force rw_i 1
   run 200ns	
} 



force reset_i 1
 
#*************************
#[Affectation des signaux]
#*************************
#Force Clk à 0 à l'instant présent t puis à 1 à l'instant t+10ns. Ce cycle est répété toutes les 20ns.
force clk_i 0 0, 1 {10 ns} -r 20ns 

force cs_servo_i  1		
force addr_bus_i  X"0"		
force data_bus_io X"0"
noforce data_bus_io
run 500ns
force reset_i 0 

puts " Ecriture servomoteur 0 "
ecritureAdresse 0 3	
ecritureAdresse 1 3	
ecritureAdresse 2 3	

puts " Ecriture servomoteur 1 "
ecritureAdresse 4 5	
ecritureAdresse 5 5	
ecritureAdresse 6 5	


puts " Ecriture servomoteur 2 "
ecritureAdresse 8 8	
ecritureAdresse 9 8
ecritureAdresse 10 8


# puts " Lecture servomoteur 0 "
# lectureAdresse 0
# puts " Donnees attendu 3"       
# puts " Donnees lu      [examine -decimal data_bus_io]"
# lectureAdresse 1
# puts " Donnees attendu 4"       
# puts " Donnees lu      [examine -decimal data_bus_io]"
# lectureAdresse 2
# puts " Donnees attendu 5"       
# puts " Donnees lu      [examine -decimal data_bus_io]"


run 200ns	
