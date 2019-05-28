-- ***********************************************
-- **  PROYECTO PDUA                            **
-- **  Modulo: 	ALU							   	**
-- **  Creacion:	Julio 07								**
-- **  Revisi�:	Marzo 08								**
-- **  Por:	   	MGH-CMUA-UNIANDES 				**
-- ***********************************************
-- Descripcion:
-- ALU Bit_Slice de N Bits
--            A     B      Clk  HF (habilitador) 
--          __|_  __|_     _|___|_
--          \   \/   /    |       |
--   SELOP-->\      / --> |       |--> C,N,Z,P 
--            \____/      |_______|   (Banderas)
--               |RES
--            ___|___
--   DESP -->|_______|
--              |
--              S 
-- ***********************************************
 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    	Port (CLK,HF: in std_logic;
				A 	   : in 	std_logic_vector(7 downto 0);
            B		: in 	std_logic_vector(7 downto 0);
            SELOP : in 	std_logic_vector(2 downto 0);
            DESP 	: in 	std_logic_vector(1 downto 0);
            S		: out 	std_logic_vector(7 downto 0);	  				
            C,N,Z,P : out 	std_logic
		 );
end ALU;

architecture Bit_Slice of ALU is

component ALU_BIT is
    Port ( A 		: in  STD_LOGIC;
           B 		: in  STD_LOGIC;
           Cin 	: in  STD_LOGIC;
           SELOP 	: in  STD_LOGIC_VECTOR (2 downto 0);
			  Cout 	: out  STD_LOGIC;
           R 		: out  STD_LOGIC);
end component;

signal RES 	: std_logic_vector(7 downto 0);
signal Cr 	: std_logic_vector(7 downto 0);
signal Cm1	: std_logic; 

begin
Slices:
for i in 7 downto 0 generate
	BIT0:
	if i=0 generate
		B0: ALU_BIT port map (A(i),B(i),Cm1,SELOP,Cr(i),RES(i));
	end generate;
	BITN:
	if i /= 0 generate
		BN: ALU_BIT port map (A(i),B(i),Cr(i-1),SELOP,Cr(i),RES(i));
end generate;
end generate;

Cm1 <= SELOP(2) and SELOP(1);		-- Carry de entrada a la ALU ='1'
											-- para las operaciones
											-- 110  B+1
											-- 110  Complemento a 2 de B
											
Banderas:		-- Negativo, Paridad, Carry
process(clk)
begin
If (clk = '0' and clk'event) then
	If HF = '1' then
		N <= RES(7); 
		If RES = "00000000" then Z <='1'; else Z <='0'; 
		end if;
		P <= not (RES(7) xor RES(6) xor RES(5) xor RES(4) xor RES(3) xor RES(2) xor RES(1) xor RES(0));
		C <= Cr(7);
	end if;
end if;
end process;
 
Desplazador:
process(DESP,RES)
begin
case DESP is
	when "00" => S <= RES;							-- No desplaza
	when "01" => S <= '0' & RES(7 downto 1);	-- Desplaza a la derecha
	when "10" => S <= RES(6 downto 0) & '0';	-- Desplaza a la izquierda
	when others => S <= (others => 'X');
end case;
end process;

end Bit_Slice;



