library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity inputOutput is
	generic (
		IN_OUT_N : positive := 2
	);
	port (
		clk_i : in std_logic := 'X';
		reset_i : in std_logic := 'X';
		
		cs_inout_i : in std_logic := 'X';
		
		addr_bus_i  : in std_logic_vector(14 downto 0);
		data_bus_io : inout std_logic_vector(15 downto 0);
		read_i  : in std_logic := 'X';
		write_i : in std_logic := 'X';
		
		input_output_io : inout std_logic_vector(IN_OUT_N-1 downto 0)
	);
end inputOutput;

architecture behaviour of inputOutput is


	signal fallingEdgeRead : std_logic := '0';
	signal risingEdgeWrite : std_logic := '0';
	
	signal offset_inout :  integer range IN_OUT_N-1 downto 0 := 0; 

	type array_data_reg is array (IN_OUT_N-1 downto 0) of std_logic_vector(15 downto 0);
		
	signal input_output_direction : array_data_reg;
	signal input_output_value : array_data_reg; 
		 
	signal not_reset: std_logic := '0';
		
	component edgeDetector is
	generic (
		EDGE_DETECTOR : std_logic := '0'
	);
	port (
		clk_i    : in std_logic ;
		reset_i  : in std_logic ;		
		signal_i : in std_logic ;		
		signal_o :out std_logic 	
	);
	end component;

begin  

	decodage : process (clk_i,reset_i) is
	begin 	
		if reset_i = '1' then 
			data_bus_io   <= (others => 'Z');		 
			input_output_direction  <= (others => (others => '0')); 
			input_output_value 		<= (others => (others => '1')); 
		end if;
		if rising_edge (clk_i)  then
			if cs_inout_i = '1' then			
				offset_inout <= to_integer(unsigned(addr_bus_i(14 downto 2)));
				if fallingEdgeRead = '1'  then 
					case addr_bus_i(1 downto 0) is
						when "00" =>
							data_bus_io(15 downto 0) <= input_output_direction(offset_inout);	
						when "01" =>
							data_bus_io(15 downto 0) <= input_output_value(offset_inout);	
						when others =>	
					end case;	
				end if;
				if risingEdgeWrite = '1' then
					case addr_bus_i(1 downto 0) is
						when "00" =>
							 input_output_direction(offset_inout) <= data_bus_io(15 downto 0) ;	
						when "01" =>
							 input_output_value(offset_inout) <= data_bus_io(15 downto 0) ;	
						when others =>		
					end case;					
				end if;
			else
				data_bus_io <= (others => 'Z');	
			end if;
		end if;
	end process decodage;
	
	
	fallingEdge_Read :edgeDetector 
	generic map(
		EDGE_DETECTOR => '0'
	)
	port map(
		clk_i    =>  clk_i  ,
		reset_i  =>  reset_i,	
		signal_i =>  read_i,	
		signal_o =>  fallingEdgeRead
	);

	risingEdge_Write :edgeDetector 
	generic map(
		EDGE_DETECTOR => '1'
	)
	port map(
		clk_i    =>  clk_i  ,
		reset_i  =>  reset_i,	
		signal_i =>  write_i,	
		signal_o =>  risingEdgeWrite
	);



end behaviour;