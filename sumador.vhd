
LIBRARY IEEE; 
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY RippleCarryAdder IS
	GENERIC (MAX_WIDTH	:	integer := 16);
	PORT(		A				:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				B				:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				Cin			:	IN		STD_LOGIC; -- Cin=1 Resta; Cin=0 Suma
				S				:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);	-- Suma
				Overflow 	:	OUT	STD_LOGIC);		-- 1 si hay overflow; 0 si no hay overflow
END ENTITY RippleCarryAdder;
-------------------------------------------------------
ARCHITECTURE gateLevel OF RippleCarryAdder IS
	SIGNAL 	Cout0_s	:	STD_LOGIC;
	SIGNAL 	Cout1_s	:	STD_LOGIC;
	SIGNAL 	Cout2_s	:	STD_LOGIC;
	SIGNAL 	Cout3_s	:	STD_LOGIC;
	SIGNAL 	Cout4_s	:	STD_LOGIC;
	SIGNAL 	Cout5_s	:	STD_LOGIC;
	SIGNAL 	Cout6_s	:	STD_LOGIC;
	SIGNAL 	Cout7_s	:	STD_LOGIC;
	SIGNAL 	Cout8_s	:	STD_LOGIC;
	SIGNAL 	Cout9_s	:	STD_LOGIC;
	SIGNAL 	Cout10_s	:	STD_LOGIC;
	SIGNAL 	Cout11_s	:	STD_LOGIC;
	SIGNAL 	Cout12_s	:	STD_LOGIC;
	SIGNAL 	Cout13_s	:	STD_LOGIC;
	SIGNAL 	Cout14_s	:	STD_LOGIC;
-------------------------------------------------------
BEGIN

FullAdder1 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(0),
				 B => B(0),
				 Cin => Cin,
				 S => S(0),
				 Cout => Cout0_s); 	
	
FullAdder2 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(1),
				 B => B(1),
				 Cin => Cout0_s,
				 S => S(1),
				 Cout => Cout1_s);
				 
FullAdder3 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(2),
				 B => B(2),
				 Cin => Cout1_s,
				 S => S(2),
				 Cout => Cout2_s);

FullAdder4 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(3),
				 B => B(3),
				 Cin => Cout2_s,
				 S => S(3),
				 Cout => Cout3_s);
				 
FullAdder5 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(4),
				 B => B(4),
				 Cin => Cout3_s,
				 S => S(4),
				 Cout => Cout4_s);

FullAdder6 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(5),
				 B => B(5),
				 Cin => Cout4_s,
				 S => S(5),
				 Cout => Cout5_s);
				 
FullAdder7 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(6),
				 B => B(6),
				 Cin => Cout5_s,
				 S => S(6),
				 Cout => Cout6_s);
		
FullAdder8 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(7),
				 B => B(7),
				 Cin => Cout6_s,
				 S => S(7),
				 Cout => Cout7_s);
FullAdder9 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(8),
				 B => B(8),
				 Cin => Cout7_s,
				 S => S(8),
				 Cout => Cout8_s); 	
	
FullAdder10 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(9),
				 B => B(9),
				 Cin => Cout8_s,
				 S => S(9),
				 Cout => Cout9_s);
				 
FullAdder11 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(10),
				 B => B(10),
				 Cin => Cout9_s,
				 S => S(10),
				 Cout => Cout10_s);

FullAdder12 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(11),
				 B => B(11),
				 Cin => Cout10_s,
				 S => S(11),
				 Cout => Cout11_s);
				 
FullAdder13 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(12),
				 B => B(12),
				 Cin => Cout11_s,
				 S => S(12),
				 Cout => Cout12_s);

FullAdder14 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(13),
				 B => B(13),
				 Cin => Cout12_s,
				 S => S(13),
				 Cout => Cout13_s);
				 
FullAdder15 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(14),
				 B => B(14),
				 Cin => Cout13_s,
				 S => S(14),
				 Cout => Cout14_s);
		
FullAdder16 : ENTITY work.FullAdder
	PORT MAP	(A	=> A(15),
				 B => B(15),
				 Cin => Cout14_s,
				 S => S(15),
				 Cout => Overflow);
END ARCHITECTURE gateLevel;