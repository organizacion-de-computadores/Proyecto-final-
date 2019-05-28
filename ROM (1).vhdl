-- ***********************************************
-- **  PROYECTO PDUA                            **
-- **  Modulo: 	ROM                           **
-- **  Creacion:	Julio 07								**
-- **  Revisi�:	Marzo 08								**
-- **  Por:		   MGH-CMUA-UNIANDES 				**
-- ***********************************************
-- Descripcion:
-- ROM (Solo lectura)
--                      cs  
--                  _____|_
--           rd -->|       |
--          dir -->|       |--> data
--                 |_______|   
--        
-- ***********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is
    Port ( cs,rd	: in std_logic;
           dir 	: in std_logic_vector(6 downto 0);
           data 	: out std_logic_vector(7 downto 0));
end ROM;

architecture Behavioral of ROM is

begin
process(cs,rd,dir)
begin
if cs = '1' and rd = '0' then
       case dir is
	    when "0000000" => data <= "01010000";  -- JMP MAIN
	    when "0000001" => data <= "00000011";  -- MAIN 
	    when "0000010" => data <= "00010111";  -- RAI Vector de Interrupcion
	    when "0000011" => data <= "00011000";  --MAIN: MOV ACC,CTE --envio un 11 a X
	    when "0000100" => data <= "00000000";  -- CTE (0x00)  
	    when "0000101" => data <= "00101000";  -- MOV DPTR,ACC
	    when "0000110" => data <= "00011000";  -- MOV ACC,CTE 
		 when "0000111" => data <= "00001011";  -- CTE (0xB0) 
	    when "0001000" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
	    when "0001001" => data <= "00011000";  -- MOV ACC,CTE   -- envio un 10 a Y
	    when "0001010" => data <= "00000001";  -- CTE (0x01) 
	    when "0001011" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0001100" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "0001101" => data <= "00001010";  -- CTE (0xA0) 
		 when "0001110" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
		 when "0001111" => data <= "00011000";  -- MOV ACC,CTE  -- envio un 1 al enable de la mult
	    when "0010000" => data <= "00000100";  -- CTE (0x04) 
	    when "0010001" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0010010" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "0010011" => data <= "00000001";  -- CTE (0x01) 
		 when "0010100" => data <= "10001000";  -- MOVP[DPTR],ACC
		 when "0010101" => data <= "00101100";  --  Vector de Interrupcion de mult
		 
		 when "0010110" => data <= "00011000";  -- MOV ACC,CTE  -- envio un 0 al reset del timer
	    when "0010111" => data <= "00000101";  -- CTE (0x05) 
	    when "0011000" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0011001" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "0011010" => data <= "00000000";  -- CTE (0x00) 
		 when "0011011" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
		 when "0011100" => data <= "00011000";  -- MOV ACC,CTE 	 -- envio un 1 al reset del timer
		 when "0011101" => data <= "00000001";  -- CTE (0x01) 
		 when "0011110" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
		 when "0011111" => data <= "00011000";  -- MOV ACC,CTE    -- envio un 10 al tiempo de conteo
	    when "0100000" => data <= "00000111";  -- CTE (0x07) 
	    when "0100001" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0100010" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "0100011" => data <= "00001010";  -- CTE (0xA0) 
		 when "0100100" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
		 when "0100101" => data <= "00011000";  -- MOV ACC,CTE   -- envio un 1 al enable del timer
	    when "0100110" => data <= "00000110";  -- CTE (0x06) 
	    when "0100111" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0101000" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "0101001" => data <= "00000001";  -- CTE (0x01) 
		 when "0101010" => data <= "10001000";  -- MOVP[DPTR],ACC
		 when "0101011" => data <= "01000011";  -- Vector de Interrupcion timer
		 
		 when "0101100" => data <= "01010000";  -- JMP FIN 
		 when "0101101" => data <= "00101100";  -- FIN
		 
	    when "0101110" => data <= "00011000";  -- INT MULT: MOV ACC,CTE  -- paso a ACC el resultado de la mult
		 when "0101111" => data <= "00000010";  -- CTE (0x02)
	    when "0110000" => data <= "00101000";  -- MOV DPTR,ACC
	    when "0110001" => data <= "10000000";  -- MOVP ACC,[DPTR]
		 when "0110010" => data <= "00010000";  -- MOV A,ACC  -- guardo el resultado en una posicion de la RAM
		 when "0110011" => data <= "00011000";  -- MOV ACC,CTE
	    when "0110100" => data <= "00000100";  -- CTE (1000100) 
	    when "0110101" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0110110" => data <= "00001000";  -- MOV ACC,A 	  
		 when "0110111" => data <= "00110000";  -- MOV[DPTR],ACC
		 
		 when "0111000" => data <= "00011000";  -- MOV ACC,CTE   -- envio a dato in del gpio 
	    when "0111001" => data <= "00001010";  -- CTE (0xA0) 
	    when "0111010" => data <= "00101000";  -- MOV DPTR,ACC
		 when "0111011" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "0111100" => data <= "10011001";  -- CTE (10011001) 
		 when "0111101" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
		 when "0111110" => data <= "00011000";  -- MOV ACC,CTE   -- envio "unos" a ddrx para escribir en pines
	    when "0111111" => data <= "00001011";  -- CTE (0xB0) 
	    when "1000000" => data <= "00101000";  -- MOV DPTR,ACC
		 when "1000001" => data <= "00011000";  -- MOV ACC,CTE 	 
		 when "1000010" => data <= "11111111";  -- CTE (11111111) 
		 when "1000011" => data <= "10001000";  -- MOVP[DPTR],ACC
		 when "1000100" => data <= "01111000";  -- RET
		
		 when "1000101" => data <= "00011000";  -- INT TIMER: MOV ACC,CTE -- envio "ceros" a ddrx para leer los pines
		 when "1000110" => data <= "00001011";  -- CTE (0xB0)
		 when "1000111" => data <= "00101000";  -- MOV DPTR,ACC
		 when "1001000" => data <= "00011000";  -- MOV ACC,CTE 
		 when "1001001" => data <= "00000000";  -- CTE (00000000) 
		 when "1001010" => data <= "10001000";  -- MOVP[DPTR],ACC
		 
		 when "1001011" => data <= "00011000";  -- MOV ACC,CTE  -- paso a ACC el dato de salida de los pines
		 when "1001100" => data <= "00001100";  -- CTE (0xC0)
	    when "1001101" => data <= "00101000";  -- MOV DPTR,ACC
	    when "1001110" => data <= "10000000";  -- MOVP ACC,[DPTR]
		 when "1001111" => data <= "01111000";  -- RET 
 
		 
		 when others => data <= (others => 'X'); 
       end case;
else data <= (others => 'Z');
end if;  
end process;
end;