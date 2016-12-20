library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity decoder is 
   Generic (
   ADDR_N_BITS : positive := 14;
   DATA_N_BITS : positive := 16
   );

   Port(
      -- Inputs
      clk_i : in std_logic := 'X';
      reset_i : in std_logic := 'X';

      data_i : in std_logic_vector(DATA_N_BITS downto 0);
      rdy_data_i : in std_logic := 'X';

      -- Outputs
      data_o : out std_logic_vector(DATA_N_BITS downto 0);
      data_out_available_o : out std_logic := 'X';
      
      -- Chip Select
      cs_adc_o : out std_logic := 'X';
      cs_io_o : out std_logic := 'X';
      cs_servo_o : out std_logic := 'X';

      -- BUS Data & @
      addr_bus_o : out std_logic_vector(ADDR_N_BITS downto 0);
      data_bus_io : inout std_logic_vector(DATA_N_BITS downto 0); 

      -- Signals
      rw_o : out std_logic := '0'

   );
end decoder;

architecture behaviour of decoder is

-- signals

begin
   reset : process(reset_i) is
   begin
   if rising_edge(reset_i) then
      addr_bus_o <= (others => '0');
      data_bus_io <= (others => '0');
      rw_o <= '0';
      cs_adc_o <= '0';
      cs_io_o <= '0';
      cs_servo_o <= '0';
      data_o <= (others => '0');
      data_out_available_o <= '0';
   end if;
   end process reset;

   ---input : process(clk_i, rdy_data_i) is
   ---begin
   ---end process input;
end behaviour;
