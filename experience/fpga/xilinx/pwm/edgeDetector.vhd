library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity edgeDetector is
	generic (
		EDGE_DETECTOR : std_logic := '0'
	);
	port (
		clk_i    : in std_logic := 'X';
		reset_i  : in std_logic := 'X';		
		signal_i : in std_logic := 'X';		
		signal_o :out std_logic := 'X'
	);
end edgeDetector;

architecture behaviour of edgeDetector is

	signal latch   : std_logic := '0';
	signal current : std_logic := '0';
	signal edge    : std_logic := '0';
	signal edgeDetecor : std_logic := '0';
	

begin  


	process (clk_i,reset_i,signal_i) is
	begin 	
		if reset_i = '0' then 
			edge <= signal_i;
		elsif rising_edge(clk_i) then
			current <= signal_i;
			latch <= current; 
			edge <= current xor latch;				
			if edge = '1' and signal_i = EDGE_DETECTOR then
				signal_o <= '1';
			else
				signal_o <= '0';			
			end if;			
		end if;		
	end process ; 
end architecture behaviour;
