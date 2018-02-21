----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:25:54 06/03/2017 
-- Design Name: 
-- Module Name:    debouncer - Behavioral 
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

entity debouncer is
   generic( duration: INTEGER);
	port( KEY_IN : in std_logic;
		   KEY_OUT: out std_logic := '0';
			CLK: in std_logic);
end debouncer;

architecture Behavioral of debouncer is

-- Returns number of bits required to represent val in binary vector
function bits_req(val : natural) return natural is
  variable res    : natural;  -- Result
  variable remain : natural;  -- Remainder used in iteration
begin
  res := 0;
  remain := val;
  while remain > 0 loop
    res := res + 1;
    remain := remain / 2;
  end loop;
  return res;
end function;

signal counter: UNSIGNED(bits_req(duration)-1 downto 0) := (others => '0');
signal prev_state: std_logic := '0';

begin

process( CLK ) is
begin
	if rising_edge(CLK) then
		prev_state <= KEY_IN;
		if( (prev_state xor KEY_IN) = '0' ) then
			counter <= counter + 1;
			if( counter = duration ) then
				KEY_OUT <= KEY_IN;
			end if;
		else
			counter <= TO_UNSIGNED(0, counter'LENGTH);
      end if;
	end if;
end process;


end Behavioral;

