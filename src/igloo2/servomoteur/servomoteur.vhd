library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity servomoteur is
	generic (
		SERVOMOTEUR_N : positive := 2
	);
	port (
		clk_i : in std_logic := 'X';
		reset_i : in std_logic := 'X';
		
		cs_servo_i : in std_logic := 'X';
		
		addr_bus_i  : in std_logic_vector(14 downto 0);
		data_bus_io : inout std_logic_vector(16 downto 0);
		rw_i : in std_logic := '0';
		
		servomoteur_o : out std_logic_vector(SERVOMOTEUR_N downto 0)
	);
end servomoteur;

architecture behaviour of servomoteur is

	signal rw_latch : std_logic := '0';
	signal rw_current : std_logic := '0';
	signal rw_edge : std_logic := '0';
	
	type array_data_reg is array (SERVOMOTEUR_N downto 0) of std_logic_vector(7 downto 0);
	
	signal offset_servomoteur :  integer range SERVOMOTEUR_N downto 0 := 0; 
	
	signal servomoteur_status : array_data_reg;
	signal servomoteur_frequence : array_data_reg;
	signal servomoteur_angle : array_data_reg;
	

begin  
 	
	decodage : process (clk_i) is
	begin 	
		if reset_i = '1' then 
			servomoteur_o <= (others => '0');
			servomoteur_status    <= (others => (others => '0')); 
			servomoteur_frequence <= (others => (others => '0')); 
			servomoteur_angle     <= (others => (others => '0')); 
		end if;
		if rising_edge (clk_i)  then
			if cs_servo_i = '1' then
				rw_current <= rw_i;
				rw_latch <= rw_current;
				rw_edge <= rw_current xor rw_latch;
				offset_servomoteur <= to_integer(unsigned(addr_bus_i(14 downto 2)));
				
				-- front montant du signal rw_i on effectue une lecture
				if( (rw_edge = '1')  and (rw_current = '1')) then
					rw_edge <= '0';	
					
					-- case addr_bus_i(1 downto 0) is
						-- when "00" =>
							-- data_bus_io(7 downto 0) <= servomoteur_status(offset_servomoteur);	
						-- when "01" =>
							-- data_bus_io(7 downto 0) <= servomoteur_frequence(offset_servomoteur);	
						-- when "10" =>
							-- data_bus_io(7 downto 0) <= servomoteur_angle(offset_servomoteur);
						-- when others =>	
					-- end case;
					 
				end if;	
				
				-- front descendant du signal rw_i on effectue une ecriture 
				if( (rw_edge = '1')  and (rw_current = '0')) then
					rw_edge <= '0';	 
					case addr_bus_i(1 downto 0) is
						when "00" =>
							 servomoteur_status(offset_servomoteur) <= data_bus_io(7 downto 0) ;	
						when "01" =>
							 servomoteur_frequence(offset_servomoteur) <= data_bus_io(7 downto 0) ;	
						when "10" =>                     
							 servomoteur_angle(offset_servomoteur) <= data_bus_io(7 downto 0)  ;
						when others =>	
					end case;
				end if;
				
				
				
			end if;
		end if;
	end process decodage;



end behaviour;