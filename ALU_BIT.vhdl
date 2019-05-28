-- ***********************************************
-- **  PROYECTO PDUA                            **
-- **  Modulo: 	ALU SLICE   				   	**
-- **  Creacion:	Marzo 08 							**
-- **  Por:	   	MGH-CMUA-UNIANDES 				**
-- ***********************************************
-- Descripcion:
-- ALU Slice de 1 Bit
--            A     B    
--          __|_  __|_    
--          \   \/   /   
--   SELOP-->\      / -->Cout 
--      Cin-->\____/      
--               |
--               R
-- ***********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_BIT is
    Port ( A 		: in  STD_LOGIC;
           B 		: in  STD_LOGIC;
           Cin 	: in  STD_LOGIC;
           SELOP 	: in  STD_LOGIC_VECTOR (2 downto 0);
			  Cout 	: out  STD_LOGIC;
           R 		: out  STD_LOGIC);        
end ALU_BIT;

architecture Behavioral of ALU_BIT is
Begin

Process (A,B,Cin,SELOP)
Begin
 case SELOP is
 	when "000" => R <= B;			-- R = B
		Cout <= 'X';
 	when "001" => R <= not B;		-- R = /B
		Cout <= 'X';
 	when "010" => R <= A and B;	-- R = AB
		Cout <= 'X';
 	when "011" => R <= A or B;		-- R = A or B
		Cout <= 'X';
 	when "100" => R <= A xor B;	-- R = A xor B
		Cout <= 'X';
 	when "101" =>						-- R = A + B
		R <= A xor B xor Cin;
		Cout <= (A and B)or (Cin and (A or B));
	when "110" =>						-- R = B + 1
		R <= B xor Cin;
		Cout <= B and Cin;
	when "111" =>						-- R = /B + 1
		R <= (not B) xor Cin;
		Cout <= (not B) and Cin;
	when others => R <= 'X';
		Cout <= 'X';
 end case;
end process;

end Behavioral;

