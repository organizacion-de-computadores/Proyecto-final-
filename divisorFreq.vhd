library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity divisor is
port (
	clk: 	in STD_LOGIC;
	clk_seg:		out STD_LOGIC
);
end divisor;

architecture div1  of divisor is
	constant max_cont: INTEGER := 100;
	signal cont: INTEGER range 0 to max_cont;
	signal clk_state: STD_LOGIC := '0';
	
begin
	gen_clock: process(clk, clk_state, cont)
	begin
		if clk'event and clk='1' then
			if cont < max_cont then 
				cont <= cont+1;
			else
				clk_state <= not clk_state;
				cont <= 0;
			end if;
		end if;
	end process;
	
	final: process (clk_state)
	begin
		clk_seg <= clk_state;
	end process;
	
end div1;