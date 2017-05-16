# Stop simu
restart

# Configuration
set UserTimeUnit ns

# Close all waves
restart -force -nowave

add wave clk_i
add wave reset_i
add wave -hexadecimal data_o

# Clk generation (20MHz)
force clk_i 0 0, 1 {25 ns} -R 50ns
force reset_i 1

run 75ns

force reset_i 0

run 100ns
