
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-------------------------------------------------------
ENTITY bus_bidir IS
	PORT 		( 	enable_DATOS		: IN		STD_LOGIC; 								-- Bus de control
				   DatoIN       		: IN  	STD_LOGIC; 	-- Son los datos que entran al buffer negado
					BusData				: INOUT	STD_LOGIC;		-- Señal que almacena el valor de datos IN
					DatoOUT				: OUT		STD_LOGIC); 	-- Datos que salen del buffer negado
	END ENTITY ;
-------------------------------------------------------
ARCHITECTURE functional OF bus_bidir IS

BEGIN PROCESS (enable_DATOS, busdata, datoIN) 
	BEGIN	
		IF (enable_DATOS='1') THEN
			busdata <= datoIN;
			datoOUT<='Z';
		ELSE
			datoOUT<= busdata;	
		END IF;	
	END PROCESS;
	
	
END ARCHITECTURE functional;