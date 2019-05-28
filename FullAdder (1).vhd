-- Sumador de un bit con tres entradas y dos salidas
-------------------------------------------------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY FullAdder IS
	PORT(		A		:	IN		STD_LOGIC;
				B		:	IN		STD_LOGIC;
				Cin	:	IN		STD_LOGIC;
				S		:	OUT	STD_LOGIC;	-- Suma
				Cout	:	OUT	STD_LOGIC);
END ENTITY FullAdder;
-------------------------------------------------------
ARCHITECTURE gateLevel OF FullAdder IS
	SIGNAL	p0		:	STD_LOGIC;
	SIGNAL	p1		:	STD_LOGIC;
	SIGNAL	p2		:	STD_LOGIC;
	SIGNAL	p3		:	STD_LOGIC;
	SIGNAL	p4		:	STD_LOGIC;
-------------------------------------------------------
BEGIN
	S 		<= p0 XOR Cin;
				p0 <= A XOR B;
	
	Cout	<= p3 OR p4;
				p3 <= A AND Cin;
				p4 <=	p1 OR p2;
						p1 <= A AND B;
						P2 <= B AND Cin;
END ARCHITECTURE gateLevel;