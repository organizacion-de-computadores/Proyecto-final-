--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 

entity GPIO is

  port (
	 dato_in		  : in std_LOGIC_VECTOR(7 downto 0);		  
	 pin          : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 DDRx         : in    std_logic_vector(7 downto 0);
	 dato_out	  : out std_LOGIC_VECTOR(7 downto 0);
	 int_gpio	  :out std_logic
	  
    );
end entity GPIO;

architecture behavioral of GPIO is

BEGIN
pin1 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(0),
				 datoIN => dato_in(0),
				 BUSDATA => pin(0),
				 datoOUT => dato_out(0)); 	
	
pin2 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(1),
				 datoIN => dato_in(1),
				 BUSDATA => pin(1),
				 datoOUT => dato_out(1));
				 
pin3 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(2),
				 datoIN => dato_in(2),
				 BUSDATA => pin(2),
				 datoOUT => dato_out(2));

pin4 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(3),
				 datoIN => dato_in(3),
				 BUSDATA => pin(3),
				 datoOUT => dato_out(3));

pin5 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(4),
				 datoIN => dato_in(4),
				 BUSDATA => pin(4),
				 datoOUT => dato_out(4));
				 
pin6 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(5),
				 datoIN => dato_in(5),
				 BUSDATA => pin(5),
				 datoOUT => dato_out(5));

pin7 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(6),
				 datoIN => dato_in(6),
				 BUSDATA => pin(6),
				 datoOUT => dato_out(6));
				
pin8 : ENTITY work.bus_bidir
	PORT MAP	(enable_datos=> ddrx(7),
				 datoIN => dato_in(7),
				 BUSDATA => pin(7),
				 datoOUT => dato_out(7));

--PROCESS (ddrx) 
	--BEGIN	
		--IF ((ddrx(5)and ddrx(6))='1') THEN
			--int_gpio<='1';
		--ELSE
			--int_gpio<='0';	
		--END IF;	
	--END PROCESS;		 
		
end architecture behavioral;