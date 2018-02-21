--------------------------------------------------------------------------------
--
--   FileName:         pwm.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 8/1/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

	
ENTITY pwm IS
  GENERIC(
      sys_clk         : INTEGER := 50_000_000; --system clock frequency in Hz
      bits_resolution : INTEGER := 8;          --bits of resolution setting the duty cycle
      pwm_nb_output   : INTEGER := 3);         --number of output pwms and pwm_nb_output
  PORT(
		clk       : IN  STD_LOGIC;                                   
		reset_n   : IN  STD_LOGIC; 
		pwm_write : IN  STD_LOGIC;    
		pwm_freq  : IN  INTEGER RANGE 0 TO 100_000;    --PWM switching frequency in Hz    
		pwm_select: IN  INTEGER RANGE 0 TO pwm_nb_output-1; 
		duty      : IN  STD_LOGIC_VECTOR(bits_resolution-1 downto 0);
		pwm_out   : OUT STD_LOGIC_VECTOR(pwm_nb_output-1 DOWNTO 0));
END pwm;

ARCHITECTURE logic OF pwm IS

    
	TYPE counters IS ARRAY (0 TO pwm_nb_output-1) OF INTEGER ;
	SIGNAL count     : counters := (OTHERS => 0);    
	TYPE period_array IS ARRAY (0 TO pwm_nb_output-1) of INTEGER;
	SIGNAL period  : period_array := (others => 0);
	SIGNAL half_duty : period_array := (others => 0);
	SIGNAL risingEdgePwm_write :  STD_LOGIC := '0' ; 
  	
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
  
BEGIN
  PROCESS(clk, reset_n)
  BEGIN
    IF(reset_n = '0') THEN                                         
		count <= (OTHERS => 0); 
		period <= (OTHERS => 0);
		pwm_out <= (OTHERS => '0');                       
    ELSIF(clk'EVENT AND clk = '1') THEN  
		
		if risingEdgePwm_write = '1' then
			period(pwm_select) <= sys_clk/pwm_freq;	
			half_duty(pwm_select) <= conv_integer(duty)*period(pwm_select)/(2**bits_resolution)/2;
			count(pwm_select) <= 0;  	
		else
			FOR a in 0 to pwm_nb_output-1 loop
			
				IF(count(a) = period(a) - 1 ) then
				  count(a) <= 0;                    
				ELSE                                
				  count(a) <= count(a) + 1;         
				END IF;				
				IF(count(a) = half_duty(a)) THEN               
					pwm_out(a) <= '0';           
				ELSIF(count(a) = period(a) - half_duty(a)) THEN   
					pwm_out(a) <= '1';                
				END IF;
				
			end loop;	
		end if;

			
    END IF;
  END PROCESS;
  
	risingEdge_pwm_write :edgeDetector 
	generic map(
		EDGE_DETECTOR => '1'
	)
	port map(
		clk_i    =>  clk  ,
		reset_i  =>  reset_n,	
		signal_i =>  pwm_write,	
		signal_o =>  risingEdgePwm_write
	);
  
  
END logic;