
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-------------------------------------------------------
entity mult_tb is
end mult_tb;
-------------------------------------------------------
ARCHITECTURE testbench OF mult_tb IS
	SIGNAL	clk_tb 			:	std_logic;
	SIGNAL	rst_n_tb 		: 	std_logic;
	SIGNAL	int_tb 			: 	std_logic; --
	SIGNAL	bus_data_out_tb,pinES_TB :		std_logic_vector(7 downto 0);
-------------------------------------------------------
BEGIN
	DUT: ENTITY work.sistema
	PORT MAP	(	clk => clk_tb,
					rst_n => rst_n_tb,
					int => int_tb,
					pines_gpio=>PINES_TB,
					bus_data_out => bus_data_out_tb);
signal_generation: PROCESS
	BEGIN
		-- TEST VECTOR 1
		rst_n_tb 	<= '0';
		WAIT FOR 1 us;
		-- TEST VECTOR 2
		rst_n_tb 	<= '1';
		WAIT FOR 1000000 us;
		END PROCESS signal_generation;
-------------------------------------------------------
--------------------- RELOJ  -------------------------- 
init:PROCESS
	BEGIN
		LOOP
			clk_tb<='0';
			WAIT FOR 20 ns;
			
			clk_tb<='1';
			WAIT FOR 20 ns;
	
			IF (NOW>=100000 us) THEN 
				WAIT;
			END IF;
		END LOOP;
	END PROCESS init;
END ARCHITECTURE testbench;