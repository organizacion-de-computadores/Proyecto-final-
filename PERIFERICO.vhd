library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PERIFERICO is
    Port ( cs,rw	   : in std_logic;
           dir 	   : in std_logic_vector(7 downto 0);
           data_in 	: in std_logic_vector(7 downto 0);
			  data_out 	: out std_logic_vector(7 downto 0);
			  X_mult		: out std_logic_vector(7 downto 0);
			  Y_mult		: out std_logic_vector(7 downto 0);
			  status		: out std_logic_vector(7 downto 0);
			  resultado1: in std_logic_vector(7 downto 0);
			  resultado2: in std_logic_vector(7 downto 0);
			  reset: out std_LOGIC_VECTOR (7 downto 0);
			  enable: out std_LOGIC_VECTOR(7 downto 0);
			  tiempo_cont:in std_LOGIC_VECTOR (7 downto 0);
			  tiempo_usuario :out std_LOGIC_VECTOR(7 downto 0);
			  fin  :in std_LOGIC_VECTOR(7 downto 0);
			  dato_in_gpio: out std_LOGIC_VECTOR(7 downto 0);		  
	        DDRx: out    std_logic_vector(7 downto 0);
	        dato_out_gpio: in std_LOGIC_VECTOR(7 downto 0));
end PERIFERICO;

architecture Behavioral of PERIFERICO is

type memoria is array (15 downto 0) of std_logic_vector(7 downto 0);
signal mem: memoria;

begin
process(cs,rw,dir,data_in,mem)
begin
if cs = '1' then
   if rw = '0' then  -- Read
       case dir is
	    --when "00000000" => data_out <= mem(0);--X_mult
	    --when "00000001" => data_out <= mem(1);--y_mult
	    when "00000010" => data_out <= mem(2);--Resultado1
	    when "00000011" => data_out <= mem(3);--Resultado2
	    --when "00000100" => data_out <= mem(4);--status
	    --when "00000101" => data_out <= mem(5);--reset
	    --when "00000110" => data_out <= mem(6);--enable
	    --when "00000111" => data_out <= mem(7);--tiempo_usuario
		 when "00001000" => data_out <= mem(8);--tiempo_cont
	    when "00001001" => data_out <= mem(9);--fin
	    --when "00001010" => data_out <= mem(10);--dato_in_gpio
	    --when "00001011" => data_out <= mem(11);--ddrx
	    when "00001100" => data_out <= mem(12);--dato_out_gpio
	    when "00001101" => data_out <= mem(13);
	    when "00001110" => data_out <= mem(14);
	    when "00001111" => data_out <= mem(15);

	    when others => data_out <= (others => 'X'); 
       end case;
   else 					-- Write
       case dir is
	    when "00000000" => mem(0) <= Data_in;--X_mult
	    when "00000001" => mem(1) <= Data_in;--Y_mult
	    --when "00000010" => mem(2) <= Data_in;--Resultado1
	    --when "00000011" => mem(3) <= Data_in;--Resultado2
	    when "00000100" => mem(4) <= Data_in;--status
	    when "00000101" => mem(5) <= Data_in;--reset
	    when "00000110" => mem(6) <= Data_in;--enable
	    when "00000111" => mem(7) <= Data_in;--tiempo_usuario
		 --when "00001000" => mem(8) <= Data_in;;--tiempo_cont
	    --when "00001001" => mem(9) <= Data_in;--fin
	    when "00001010" => mem(10) <= Data_in;--dato_in_gpio
	    when "00001011" => mem(11) <= Data_in;--ddrx
	    --when "00001100" => mem(12) <= Data_in;--dato_out_gpio
	    when "00001101" => mem(13) <= Data_in;
	    when "00001110" => mem(14) <= Data_in;
	    when "00001111" => mem(15) <= Data_in;

	    when others => mem(15) <= Data_in;
       end case;
    end if;
else data_out <= (others => 'Z');
end if;
mem(2)<=resultado1;
mem(3)<=resultado2;
X_mult<=mem(0);
Y_mult<=mem(1);
status<=mem(4);

reset<=mem(5);
enable<=mem(6);
tiempo_usuario<=mem(7);
mem(8)<=tiempo_cont;
mem(9)<=fin; 
  
dato_in_gpio<=mem(10);
ddrx<=mem(11);
mem(12)<=dato_out_gpio;
  
end process;
end Behavioral;
