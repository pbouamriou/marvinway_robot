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
 
# add wave clk_i
add wave cs_servo_i 
add wave -radix hexadecimal addr_bus_i  		
add wave -radix hexadecimal data_bus_io 

add wave -radix hexadecimal servomoteur_status 
add wave -radix hexadecimal servomoteur_frequence 
add wave -radix hexadecimal servomoteur_angle 

add wave write_i 

add wave servomoteur_o

proc ecritureAdresse {addresse  donnee} {
   force addr_bus_i [format {x"%X"} $addresse]	
   force data_bus_io [format {x"%X"} $donnee] 
   run 100ns  
   # force write_i 0	
   run 100ns	
   force write_i 1 
   run 100ns  
   force write_i 0	
   run 200ns 
   noforce data_bus_io
}
proc lectureAdresse {addresse } {
   noforce data_bus_io
   force addr_bus_i [format {x"%X"} $addresse]
   run 100ns	
   force read_i 1
   run 100ns	
   force read_i 0
   run 200ns	
} 



force reset_i 1
 
#*************************
#[Affectation des signaux]
#*************************
#Force Clk à 0 à l'instant présent t puis à 1 à l'instant t+10ns. Ce cycle est répété toutes les 20ns.
force clk_i 0 0, 1 {10 ns} -r 20ns 

force cs_servo_i 0	
force addr_bus_i  X"0"	
force write_i 0	
force read_i 0 
run 500ns
force reset_i 0 
force cs_servo_i  1	
run 100ns
 
 
ecritureAdresse 5 25000
ecritureAdresse 6 6535

run 50us
run 50us
ecritureAdresse 1 50000
ecritureAdresse 2 6535

run 50us
run 50us
ecritureAdresse 5 50000
ecritureAdresse 6 12000

force cs_servo_i 0
run 50us