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
		data_bus_io : inout std_logic_vector(15 downto 0);
		read_i  : in std_logic := 'X';
		write_i : in std_logic := 'X';
		
		servomoteur_o : out std_logic_vector(SERVOMOTEUR_N-1 downto 0)
	);
end servomoteur;

architecture behaviour of servomoteur is


	signal fallingEdgeRead : std_logic := '0';
	signal risingEdgeWrite : std_logic := '0';
		
	type array_data_reg is array (SERVOMOTEUR_N-1 downto 0) of std_logic_vector(15 downto 0);
	
	signal offset_servomoteur :  integer range SERVOMOTEUR_N-1 downto 0 := 0; 
	
	signal servomoteur_status : array_data_reg;
	signal servomoteur_frequence : array_data_reg;
	signal servomoteur_angle : array_data_reg;
	
	signal servomoteur_dutyCycle : array_data_reg;
	
	signal pwm_freq_select  :  INTEGER RANGE 0 TO 100_000:= 100_000;
	signal duty_select :  STD_LOGIC_VECTOR(15 downto 0) ;
	 
	signal not_reset: std_logic := '0';
	
	component pwm is
	generic(
		sys_clk         : integer := 50000000;   --system clock frequency in Hz
		bits_resolution : integer := 16;          --bits of resolution setting the duty cycle
		pwm_nb_output   : integer := 1           --number of output pwms and phases
	);       
	port(
		clk       : IN  STD_LOGIC;                                   
		reset_n   : IN  STD_LOGIC; 
		pwm_write : IN  STD_LOGIC;    
		pwm_freq  : IN  INTEGER RANGE 0 TO 100_000;    --PWM switching frequency in Hz    
		pwm_select: IN  INTEGER RANGE 0 TO pwm_nb_output-1; 
		duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 downto 0);
		pwm_out   : OUT STD_LOGIC_VECTOR(pwm_nb_output-1 DOWNTO 0)
	);        
	end component;
	
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
			servomoteur_status    <= (others => (others => '0')); 
			servomoteur_frequence <= (others => (others => '1')); 
			servomoteur_angle     <= (others => (others => '0')); 
			servomoteur_dutyCycle <= (others => (others => '0')); 
		end if;
		if rising_edge (clk_i)  then
			if cs_servo_i = '1' then			
				offset_servomoteur <= to_integer(unsigned(addr_bus_i(14 downto 2)));
				if fallingEdgeRead = '1'  then 
					case addr_bus_i(1 downto 0) is
						when "00" =>
							data_bus_io(15 downto 0) <= servomoteur_status(offset_servomoteur);	
						when "01" =>
							data_bus_io(15 downto 0) <= servomoteur_frequence(offset_servomoteur);	
						when "10" =>
							data_bus_io(15 downto 0) <= servomoteur_angle(offset_servomoteur);
						when others =>	
					end case;	
				end if;
				if risingEdgeWrite = '1' then
					case addr_bus_i(1 downto 0) is
						when "00" =>
							 servomoteur_status(offset_servomoteur) <= data_bus_io(15 downto 0) ;	
						when "01" =>
								servomoteur_frequence(offset_servomoteur) <= data_bus_io(15 downto 0) ;	
						when "10" =>  
								servomoteur_angle(offset_servomoteur) <= data_bus_io(15 downto 0)  ;
						when others =>		
					end case;					
				end if;
				--conversion consignes
				if servomoteur_status(offset_servomoteur)(0) = '0' then  
					servomoteur_dutyCycle(offset_servomoteur) <= (others => '0') ;	
				end if;
				
				servomoteur_dutyCycle(offset_servomoteur)(15 downto 5) <= servomoteur_angle(offset_servomoteur)(10 downto 0);				
				
			else
				data_bus_io <= (others => 'Z');	
			end if;
		end if;
	end process decodage;
	
	not_reset <= not reset_i;
	pwm_freq_select <= to_integer( unsigned( servomoteur_frequence(offset_servomoteur)));
	duty_select <= servomoteur_dutyCycle(offset_servomoteur) + "0000110011001100";
	
	premierePwm : pwm
	generic map(
		sys_clk         =>  50_000_000,       --system clock frequency in Hz
		bits_resolution =>  16,                --bits of resolution setting the duty cycle
		pwm_nb_output   =>  SERVOMOTEUR_N     --number of output pwms and phases
	)
	port map (
		clk        => clk_i,     
		reset_n    => not_reset, 
		pwm_write  => write_i,
		pwm_freq   => pwm_freq_select,     --PWM switching frequency in Hz
		pwm_select => offset_servomoteur,
		duty       => duty_select, 		   --duty cycle
		pwm_out    => servomoteur_o        --pwm outputs 
	);
	
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