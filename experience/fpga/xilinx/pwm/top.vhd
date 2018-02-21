----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:23:49 05/30/2017 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
	Port( CLK : in std_logic;
			KEY1 : in std_logic;
			KEY2 : in std_logic;
			KEY3 : in std_logic;
			KEY4 : in std_logic;
			LED : out std_logic_vector(3 downto 0)
		 );
end top;

architecture Behavioral of top is
	COMPONENT pwm
	 GENERIC(
      sys_clk         : INTEGER;         --number of output pwms and pwm_nb_output
		pwm_nb_output   : INTEGER);
    PORT(
         clk : IN  std_logic;
         reset_n : IN  std_logic;
         pwm_write : IN  std_logic;
         pwm_freq : IN INTEGER RANGE 0 TO 100_000;
         pwm_select : IN INTEGER RANGE 0 TO 0;
         duty : IN  std_logic_vector(7 downto 0);
         pwm_out : OUT  std_logic_vector(0 downto 0)
        );
   END COMPONENT;
	
	COMPONENT debouncer
		GENERIC(
			duration : INTEGER);
		PORT( KEY_IN : in std_logic;
		      KEY_OUT: out std_logic;
				CLK: in std_logic);
	END COMPONENT;
	
	SIGNAL KEY_DEBOUNCE: std_logic_vector(3 downto 0);
	SIGNAL PWM_WRITE: std_logic;
	SIGNAL CONSIGNE : std_logic_vector(7 downto 0);
	SIGNAL PWM_OUT: std_logic_vector(0 downto 0);
	SIGNAL RESET: std_logic := '1';
	
begin

     top_debouncer1: debouncer
		 GENERIC MAP(
		    duration => 480_000)
		 PORT MAP(
			KEY_IN => KEY1, -- S3
			KEY_OUT => KEY_DEBOUNCE(1),
			CLK => CLK
		 );
		 
		 top_debouncer2: debouncer
		 GENERIC MAP(
		    duration => 480_000)
		 PORT MAP(
			KEY_IN => KEY2, -- S2
			KEY_OUT => KEY_DEBOUNCE(2),
			CLK => CLK
		 );
		 
		 top_debouncer3: debouncer
		 GENERIC MAP(
		    duration => 480_000)
		 PORT MAP(
			KEY_IN => KEY3, -- S1
			KEY_OUT => KEY_DEBOUNCE(3),
			CLK => CLK
		 );
		 
		 top_debouncer4: debouncer
		 GENERIC MAP(
		    duration => 480_000)
		 PORT MAP(
			KEY_IN => KEY4, -- S4
			KEY_OUT => KEY_DEBOUNCE(0),
			CLK => CLK
		 );

		top_pwm: pwm
			GENERIC MAP(
				sys_clk => 48_000_000,
				pwm_nb_output   => 1)
			PORT MAP (
          clk => CLK,
          reset_n => RESET,
          pwm_write => PWM_WRITE,
          pwm_freq => 500,
          pwm_select => 0,
          duty => CONSIGNE,
          pwm_out => PWM_OUT
        ); 
		  
		  
	process(CLK) is
	begin
		if(rising_edge(CLK)) then
			if(KEY_DEBOUNCE(0) = '0') then
				PWM_WRITE <= '1';
				CONSIGNE <= X"00";
			elsif (KEY_DEBOUNCE(1) = '0') then
			   PWM_WRITE <= '1';
				CONSIGNE <= X"3F";
			elsif (KEY_DEBOUNCE(2) = '0') then
			   PWM_WRITE <= '1';
				CONSIGNE <= X"7F";
			elsif (KEY_DEBOUNCE(3) = '0') then
			   PWM_WRITE <= '1';
				CONSIGNE <= X"AF";
			else 
				PWM_WRITE <= '0';
			end if;
		end if;
	end process;
		  
		  
	LED(0) <= NOT(PWM_OUT(0));
	LED(1) <= NOT(PWM_OUT(0));
	LED(2) <= NOT(PWM_OUT(0));
	LED(3) <= NOT(PWM_OUT(0));

end Behavioral;

