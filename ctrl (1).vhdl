-- ***********************************************
-- **  PROYECTO PDUA                            **
-- **  Modulo: 	CONTROL                       **
-- **  Creacion:	Julio 07								**
-- **  Por:			Mauricio Guerrero H.          **
-- **  Revisi�n:	Marzo 08								**
-- **             Conjunto de Instrucciones     **
-- **  Por:       Mauricio Guerrero H. 			**
-- **             Diego Mendez Chaves           **
-- ***********************************************
-- Descripcion:     CLK|    |Rst_n
--               ______|____|___________________ 
--              |    _________     __________   |
--        HRI-->|-->|         |   |          |  |
-- INST(7..3)-->|-->| OPCODE  |-->|Dir_H     |  |
--              |   |_________|   |  MEMORIA |->|-> Uinst
--              |    _________    |    uINST |  |
-- uDIR(2..0)-->|-->|   uPC   |-->| Dir_L    |  |
--              |   |_________|   |__________|  |
--              |    �|`                        |
--              |    _|_______                  |                                    |
--       COND-->|-->| EVAL    |                 |
--      FLAGS-->|-->|_SALTOS__|                 |
-- (C,N,Z,P,INT)|_______________________________|       

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  UNIDAD DE CONTROL MG

entity ctrl is
    Port ( clk 	: in std_logic;
           rst_n 	: in std_logic;
		     urst_n : in std_logic;
           HRI 	: in std_logic;
           INST 	: in std_logic_vector(4 downto 0);
           C 		: in std_logic;
           Z 		: in std_logic;
           N 		: in std_logic;
           P 		: in std_logic;
           INT 	: in std_logic;
			  INT_MULT 	: in std_logic;
			  INT_TIMER 	: in std_logic;
			  INT_GPIO 	: in std_logic;
           COND 	: in std_logic_vector(3 downto 0);
           DIR 	: in std_logic_vector(2 downto 0);
           UI 		: out std_logic_vector(27 downto 0));
end ctrl;

architecture Behavioral of ctrl is
signal load : std_logic;	     
signal uaddr: std_logic_vector(7 downto 0);

begin
 RI: process(clk)
 begin
   if (clk'event and clk = '1') then
	if rst_n = '0' then 
	    uaddr(7 downto 3) <= (others => '0');
	  elsif HRI = '1' then
	    uaddr(7 downto 3) <= INST;
     elsif urst_n = '0' then
	  	  uaddr(7 downto 3) <= (others => '0');
	end if; 	
   end if;
 end process;

 CONT: process(clk)
 begin
   if (clk'event and clk = '1') then
	if rst_n = '0' or urst_n = '0' or HRI = '1' then
	      uaddr(2 downto 0) <= (others => '0');
   	elsif load = '1' then
	      uaddr(2 downto 0) <= DIR;
      else
	      uaddr(2 downto 0) <= uaddr(2 downto 0) + 1;
	end if;
   end if;
 end process;

 EVS: process(C,Z,N,P,INT,INT_MULT,INT_TIMER,INT_GPIO,COND)
 begin
   case cond is
     when "0000" => load <= '0';
     when "0001" => load <= '1';
     when "0010" => load <= Z;
     when "0011" => load <= N;
     when "0100" => load <= C;
     when "0101" => load <= P;
     when "0110" => load <= INT;
	  when "0111" => load <= INT_MULT;
	  when "1000" => load <= INT_TIMER;
	  when "1001" => load <= INT_GPIO;
     when others => load <= '0';
   end case;
 end process;

 MUI: process(uaddr)
 begin
   case uaddr is
   -- HF BUSB(3) SELOP(3) DESP(2) BUSC(3) HR MAR MBR RW IOM HRI RUPC COND(3) OFFS(3)  

   -- FETCH 							    
	when "00000000" => UI <= "0000100000XXXX01000010110100"; -- JINT 100 (MAR=SP)
	when "00000001" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "00000010" => UI <= "0000011000000010001010000XXX"; -- PC= PC+1,RD MREQ	
	when "00000011" => UI <= "0000000000000000101100000XXX"; -- MDR=DEX, INST=MDR, RD MREQ	
															  			   -- Reset UPC   
	-- INT
	when "00000100" => UI <= "0000000000XXXX00111010000XXX"; -- [SP]<-PC,WR MREQ
	when "00000101" => UI <= "0000111000000110001010000XXX"; -- SP++	
	when "00000110" => UI <= "0010000000XXXX01001010000XXX"; -- MAR=vector,RD,MREQ
	when "00000111" => UI <= "0000000000000010101000000XXX"; -- PC<-[vector],rst upc
	
   --00001	 MOV ACC,A 
	when "00001000" => UI <= "1001100000011110000000000XXX"; -- ACC = A , Reset UPC
	when "00001001" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00001010" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00001011" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00001100" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00001101" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00001110" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";  -- Las posiciones no utilizadas
	when "00001111" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";  -- no importan (no existen)

   --00010  MOV A,ACC
	when "00010000" => UI <= "1011100000001110000000000000";  -- PC = ACC, Reset UPC
	when "00010001" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00010010" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00010011" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00010100" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00010101" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00010110" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "00010111" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";

   --00011	 MOV ACC,CTE
	when "00011000" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC, RD MREQ
	when "00011001" => UI <= "0000011000000010001010000XXX"; -- PC = PC + 1, RD MREQ
	when "00011010" => UI <= "0000000000011110101000000XXX"; -- ACC = DATA, RD MREQ, Reset UPC
	when "00011011" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";

   --00100  MOV ACC,[DPTR]
	when "00100000" => UI <= "0001000000XXXX01001010000XXX"; -- MAR = DPTR, RD MREQ
	when "00100001" => UI <= "0XXXXXXXXX011110101000000XXX"; -- MDR=DEX,RD MREQ,ACC=MDR,RST UPC 
	when "00100010" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";

   --00101  MOV DPTR,ACC
	when "00101000" => UI <= "1011100000001010000000000XXX"; -- DPTR = ACC , Reset UPC
	when "00101001" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";

   -- 00110 MOV [DPTR],ACC	
	when "00110000" => UI <= "0001000000XXXX01001010000XXX"; -- MAR=DPTR
	when "00110001" => UI <= "1011100000XXXX00111000000XXX"; -- MDR = ACC, WR MREQ, RST UPC
	when "00110010" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";	  

    -- HF BUSB(3) SELOP(3) DESP(2) BUSC(3) HR MAR MBR RW IOM HRI RUPC COND(3) OFFS(3)  

   -- 00111 INV ACC
	when "00111000" => UI <= "1011100100011110000000000XXX"; -- ACC = not ACC, Reset UPC
	when "00111001" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
    -- 01000 AND ACC,A	 
   when "01000000" => UI <= "1001101000011110000000000XXX"; -- ACC = ACC and A, Reset UPC
	when "01000001" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"; -- 
	
	-- 01001 ADD ACC,A
	when "01001000" => UI <= "1001110100011110000000000XXX"; -- ACC = ACC + A, Reset UPC
	when "01001001" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	-- 01010 JMP DIR
	when "01010000" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "01010001" => UI <= "0000011000000010001010000XXX"; -- PC= PC+1,RD MREQ
	when "01010010" => UI <= "XXXXXXXXXX000010101000000XXX"; -- MDR=DEX,RD MREQ,PC=MDR,RST UPC
	when "01010011" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	-- 01011 JZ DIR
	when "01011000" => UI <= "0XXXXXXXXXXXXX00000010010010"; -- JZ 010 
	when "01011001" => UI <= "0000011000000010000000000XXX"; -- PC=PC+1;Reset upc
	when "01011010" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "01011011" => UI <= "0XXXXXXXXX000010101000000XXX"; -- MDR=DEX,RD MREQ,PC=MDR,RST UPC
	when "01011100" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"; 

	-- 01100 JN DIR
	when "01100000" => UI <= "0XXXXXXXXXXXXX00000010011010"; -- JN 010 
	when "01100001" => UI <= "0000011000000010000000000XXX"; -- PC=PC+1,Reset upc
	when "01100010" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "01100011" => UI <= "0XXXXXXXXX000010101000000XXX"; -- MDR=DEX,RD MREQ,PC=MDR,RST UPC
	when "01100100" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	-- 01101 JC DIR
	when "01101000" => UI <= "0XXXXXXXXXXXXX00000010100010"; -- JC 010 
	when "01101001" => UI <= "0000011000000010000000000XXX"; -- PC=PC+1,Reset upc
	when "01101010" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "01101011" => UI <= "0XXXXXXXXX000010101000000XXX"; -- MDR=DEX,RD MREQ,PC=MDR,RST UPC
	when "01101100" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"; 
	
	-- 01110  CALL DIR       
	when "01110000" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC
	when "01110001" => UI <= "0XXXXXXXXX010110101010000XXX"; -- MDR=DEX,RD MREQ,TEMP=DIR
	when "01110010" => UI <= "0000011000000010001010000XXX"; -- PC= PC+1
	when "01110011" => UI <= "0000100000XXXX01001010000XXX"; -- MAR = SP
	when "01110100" => UI <= "0000000000XXXX00111010000XXX"; -- MDR = PC,WR MREQ,[SP]<-PC 
	when "01110101" => UI <= "0000111000000110001010000XXX"; -- SP= SP+1
	when "01110110" => UI <= "0010100000000010000000000XXX"; -- PC=temp, rst upc
	when "01110111" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	-- 01111  RET
	when "01111000" => UI <= "0011100000010110000010000XXX"; -- temp=acc
	when "01111001" => UI <= "0000100000011110000010000XXX"; -- ACC = SP
	when "01111010" => UI <= "0011010100000110000010000XXX"; -- SP= ACC+(-1)
	when "01111011" => UI <= "0000100000XXXX01001010000XXX"; -- MAR = SP
	when "01111100" => UI <= "0XXXXXXXXX000010101010000XXX"; -- MDR=DEX,RD MREQ,PC=MDR
	when "01111101" => UI <= "0010100000011110000000000XXX"; -- ACC = TEMP, RST upc
	when "01111110" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	when "01111111" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	-- 10000 MOVP ACC, [DPTR]	
	when "10000000" => UI <= "0001000000XXXX01001010000XXX"; -- MAR = DPTR, RD MREQ
	when "10000001" => UI <= "0XXXXXXXXX011110100000000XXX"; -- MDR=DEX,RD MREQ,ACC=MDR,RST UPC 
	when "10000010" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";

	-- 10001 MOVP [DPTR],ACC	
	when "10001000" => UI <= "0001000000XXXX01001010000XXX"; -- MAR=DPTR
	when "10001001" => UI <= "1011100000XXXX00110000000XXX"; -- MDR = ACC, WR MREQ, RST UPC
	when "10001010" => UI <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	
	-- FETCH MULT							    
	when "10010000" => UI <= "0000100000XXXX01000010111100"; -- JINT 100 (MAR=SP)
	when "10010001" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "10010010" => UI <= "0000011000000010001010000XXX"; -- PC= PC+1,RD MREQ	
	when "10010011" => UI <= "0000000000000000101100000XXX"; -- MDR=DEX, INST=MDR, RD MREQ	
															  			   -- Reset UPC   
	-- INT MULT
	when "10010100" => UI <= "0000000000XXXX00111010000XXX"; -- [SP]<-PC,WR MREQ
	when "10010101" => UI <= "0000111000000110001010000XXX"; -- SP++	
	when "10010110" => UI <= "0100000000XXXX01001010000XXX"; -- MAR=vector,RD,MREQ
	when "10010111" => UI <= "0000000000000010101000000XXX"; -- PC<-[vector],rst upc
	
	-- FETCH TIMER						    
	when "10011000" => UI <= "0000100000XXXX01000011000100"; -- JINT 100 (MAR=SP)
	when "10011001" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "10011010" => UI <= "0000011000000010001010000XXX"; -- PC= PC+1,RD MREQ	
	when "10011011" => UI <= "0000000000000000101100000XXX"; -- MDR=DEX, INST=MDR, RD MREQ	
															  			   -- Reset UPC   
	-- INT TIMER
	when "10011100" => UI <= "0000000000XXXX00111010000XXX"; -- [SP]<-PC,WR MREQ
	when "10011101" => UI <= "0000111000000110001010000XXX"; -- SP++	
	when "10011110" => UI <= "0100100000XXXX01001010000XXX"; -- MAR=vector,RD,MREQ
	when "10011111" => UI <= "0000000000000010101000000XXX"; -- PC<-[vector],rst upc
	
	-- FETCH GPIO						    
	when "10100000" => UI <= "0000100000XXXX01000011001100"; -- JINT 100 (MAR=SP)
	when "10100001" => UI <= "0000000000XXXX01001010000XXX"; -- MAR = PC,RD MREQ
	when "10100010" => UI <= "0000011000000010001010000XXX"; -- PC= PC+1,RD MREQ	
	when "10100011" => UI <= "0000000000000000101100000XXX"; -- MDR=DEX, INST=MDR, RD MREQ	
															  			   -- Reset UPC   
	-- INT GPIO
	when "10100100" => UI <= "0000000000XXXX00111010000XXX"; -- [SP]<-PC,WR MREQ
	when "10100101" => UI <= "0000111000000110001010000XXX"; -- SP++	
	when "10100110" => UI <= "0101000000XXXX01001010000XXX"; -- MAR=vector,RD,MREQ
	when "10100111" => UI <= "0000000000000010101000000XXX"; -- PC<-[vector],rst upc
	
	when others => UI <= (others => 'X');
  end case;
 end process;
end Behavioral;
