----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:59:06 05/30/2017 
-- Design Name: 
-- Module Name:    leds - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity leds is
    Port ( LED : OUT  STD_LOGIC_VECTOR(3 downto 0);
			  KEY1: IN STD_LOGIC;
			  --KEY2: IN STD_LOGIC;
			  --KEY3: IN STD_LOGIC;
			  --KEY4: IN STD_LOGIC;
			  CLK: IN STD_LOGIC
           );
end leds;

architecture Behavioral of leds is
	signal KEY1_DEBOUNCED: STD_LOGIC;
begin

	debouncer_1: entity work.debouncer
		generic map( duration => 960_000)
	   port map( KEY_IN => KEY1,
		          KEY_OUT => KEY1_DEBOUNCED,
				    CLK => CLK);
					 
	with KEY1_DEBOUNCED select
		LED <= "1111" when '1',
				 "0000" when '0',
				 "0000" when others;

	--KEY <= KEY1 and KEY2 and KEY3 and KEY4;
	--with KEY select
	--	LED <= "1111" when '1',
	--					  "0000" when '0',
	--					  "0000" when others;
end Behavioral;

