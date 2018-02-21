--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:23:20 05/30/2017
-- Design Name:   
-- Module Name:   /home/philippe/Dev/marvinway/src/FPGA/Examples/pwm/test.vhd
-- Project Name:  pwm
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pwm
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pwm
    PORT(
         clk : IN  std_logic;
         reset_n : IN  std_logic;
         pwm_write : IN  std_logic;
         pwm_freq : IN  std_logic_vector(0 to 16);
         pwm_select : IN  std_logic_vector(0 to 1);
         duty : IN  std_logic_vector(7 downto 0);
         pwm_out : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_n : std_logic := '0';
   signal pwm_write : std_logic := '0';
   signal pwm_freq : std_logic_vector(0 to 16) := (others => '0');
   signal pwm_select : std_logic_vector(0 to 1) := (others => '0');
   signal duty : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pwm_out : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm PORT MAP (
          clk => clk,
          reset_n => reset_n,
          pwm_write => pwm_write,
          pwm_freq => pwm_freq,
          pwm_select => pwm_select,
          duty => duty,
          pwm_out => pwm_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
