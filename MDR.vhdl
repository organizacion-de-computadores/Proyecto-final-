-- ***********************************************
-- **  PROYECTO PDUA                            **
-- **  Modulo: 	MDR  (Registro de datos)      **
-- **  Creacion:	Julio 07								**
-- **  Revisión:	Marzo 08								**
-- **  Por:	   	MGH-CMUA-UNIANDES 				**
-- ***********************************************
-- Descripcion:
-- Registro de Datos
--                  Clk HMDR (habilitador) 
--                  _|___|_
--        RD_WR -->|       |
--  DATA_EX_in  -->|       |<-- DATA_ALU
--  DATA_EX_out <--|       |--> DATA_C
--                 |_______|   
--        
-- ***********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MDR is
    Port ( DATA_EX_in 	: in std_logic_vector(7 downto 0);
			  DATA_EX_out 	: out std_logic_vector(7 downto 0);
           DATA_ALU 		: in std_logic_vector(7 downto 0);
           DATA_C 		: out std_logic_vector(7 downto 0);
           HMDR			: in std_logic;
           RD_WR 			: in std_logic);
end MDR;

architecture Behavioral of MDR is

begin
 process(DATA_EX_in,DATA_ALU,HMDR,RD_WR)
 begin
 if HMDR = '0' then	 -- no acceso a memoria
    DATA_EX_out 	<= (others => 'Z');
    DATA_C 			<= DATA_ALU;
 elsif RD_WR = '0' then  --lectura
    DATA_C 			<= DATA_EX_in;
 else
	 DATA_EX_out 	<= DATA_ALU;
 	 DATA_C 			<= DATA_ALU;
 end if;
 end process;

end Behavioral;
