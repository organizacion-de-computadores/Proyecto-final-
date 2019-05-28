
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------------------
ENTITY mult IS 

	PORT(		X	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				Y	:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				status		: in std_logic_vector(7 downto 0);
				RESULTADO1		:OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				RESULTADO2		:OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
				INT_MULT			:OUT STD_LOGIC;
				clk				: in std_LOGIC
				);

END ENTITY mult;
-------------------------------------------------------
ARCHITECTURE multArch OF mult IS
		SIGNAL		F		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		G		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		H		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		I		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		S		:	STD_LOGIC_VECTOR(15 DOWNTO 0):="0000000000000000";
		SIGNAL		T		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		U		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		V		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		SIGNAL		J		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		K		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		R		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		Z		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		O		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		SIGNAL		P		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		
		SIGNAL 	Cout0_s	:	STD_LOGIC;
		SIGNAL 	Cout1_s	:	STD_LOGIC;
		SIGNAL 	Cout2_s	:	STD_LOGIC;
		SIGNAL 	Cout3_s	:	STD_LOGIC;
		SIGNAL 	Cout4_s	:	STD_LOGIC;
		SIGNAL 	Cout5_s	:	STD_LOGIC;
		SIGNAL 	Cout6_s	:	STD_LOGIC;
		
		SIGNAL	RESULTADO:	STD_LOGIC_VECTOR(15 DOWNTO 0);
		constant max_cont: INTEGER := 15;
		signal cont: INTEGER range 0 to max_cont;

BEGIN
	F(0) <= Y(0)AND X(0);
	F(1) <= Y(0)AND X(1);
	F(2) <= Y(0)AND X(2);
	F(3) <= Y(0)AND X(3);
	F(4) <= Y(0)AND X(4);
	F(5) <= Y(0)AND X(5);
	F(6) <= Y(0)AND X(6);
	F(7) <= Y(0)AND X(7);
	F(8) <= '0';
	F(9) <= '0';
	F(10) <= '0';
	F(11) <= '0';
	F(12) <= '0';
	F(13) <= '0';
	F(14) <= '0';
	F(15) <= '0';
	
	G(0) <= '0';
	G(1) <= Y(1)AND X(0);
	G(2) <= Y(1)AND X(1);
	G(3) <= Y(1)AND X(2);
	G(4) <= Y(1)AND X(3);
	G(5) <= Y(1)AND X(4);
	G(6) <= Y(1)AND X(5);
	G(7) <= Y(1)AND X(6);
	G(8) <= Y(1)AND X(7);
	G(9) <= '0';
	G(10) <= '0';
	G(11) <= '0';
	G(12) <= '0';
	G(13) <= '0';
	G(14) <= '0';
	G(15) <= '0';
	
	H(0) <= '0';
	H(1) <= '0';
	H(2) <= Y(2)AND X(0);
	H(3) <= Y(2)AND X(1);
	H(4) <= Y(2)AND X(2);
	H(5) <= Y(2)AND X(3);
	H(6) <= Y(2)AND X(4);
	H(7) <= Y(2)AND X(5);
	H(8) <= Y(2)AND X(6);
	H(9) <= Y(2)AND X(7);
	H(10) <= '0';
	H(11) <= '0';
	H(12) <= '0';
	H(13) <= '0';
	H(14) <= '0';
	H(15) <= '0';
	
	I(0) <= '0';
	I(1) <= '0';
	I(2) <= '0';
	I(3) <= Y(3)AND X(0);
	I(4) <= Y(3)AND X(1);
	I(5) <= Y(3)AND X(2);
	I(6) <= Y(3)AND X(3);
	I(7) <= Y(3)AND X(4);
	I(8) <= Y(3)AND X(5);
	I(9) <= Y(3)AND X(6);
	I(10) <= Y(3)AND X(7);
	I(11) <= '0';
	I(12) <= '0';
	I(13) <= '0';
	I(14) <= '0';
	I(15) <= '0';
	
	S(0) <= '0';
	S(1) <= '0';
	S(2) <= '0';
	S(3) <= '0';
	S(4) <= Y(4)AND X(0);
	S(5) <= Y(4)AND X(1);
	S(6) <= Y(4)AND X(2);
	S(7) <= Y(4)AND X(3);
	S(8) <= Y(4)AND X(4);
	S(9) <= Y(4)AND X(5);
	S(10) <= Y(4)AND X(6);
	S(11) <= Y(4)AND X(7);
	S(12) <= '0';
	S(13) <= '0';
	S(14) <= '0';
	S(15) <= '0';
	
	T(0) <= '0';
	T(1) <= '0';
	T(2) <= '0';
	T(3) <= '0';
	T(4) <= '0';
	T(5) <= Y(5)AND X(0);
	T(6) <= Y(5)AND X(1);
	T(7) <= Y(5)AND X(2);
	T(8) <= Y(5)AND X(3);
	T(9) <= Y(5)AND X(4);
	T(10) <= Y(5)AND X(5);
	T(11) <= Y(5)AND X(6);
	T(12) <= Y(5)AND X(7);
	T(13) <= '0';
	T(14) <= '0';
	T(15) <= '0';
	
	U(0) <= '0';
	U(1) <= '0';
	U(2) <= '0';
	U(3) <= '0';
	U(4) <= '0';
	U(5) <= '0';
	U(6) <= Y(6)AND X(0);
	U(7) <= Y(6)AND X(1);
	U(8) <= Y(6)AND X(2);
	U(9) <= Y(6)AND X(3);
	U(10) <= Y(6)AND X(4);
	U(11) <= Y(6)AND X(5);
	U(12) <= Y(6)AND X(6);
	U(13) <= Y(6)AND X(7);
	U(14) <= '0';
	U(15) <= '0';
	
	V(0) <= '0';
	V(1) <= '0';
	V(2) <= '0';
	V(3) <= '0';
	V(4) <= '0';
	V(5) <= '0';
	V(6) <= '0';
	V(7) <= Y(7)AND X(0);
	V(8) <= Y(7)AND X(1);
	V(9) <= Y(7)AND X(2);
	V(10) <= Y(7)AND X(3);
	V(11) <= Y(7)AND X(4);
	V(12) <= Y(7)AND X(5);
	V(13) <= Y(7)AND X(6);
	V(14) <= Y(7)AND X(7);
	V(15) <= '0';
	
SUMA1 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> F,
				 B => G,
				 Cin => '0',
				 S => J,
				 Overflow => Cout0_s); 	
	
SUMA2 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> H,
				 B => J,
				 Cin => Cout0_s,
				 S => K,
				 Overflow => Cout1_s);
				 
SUMA3 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> I,
				 B => K,
				 Cin => Cout1_s,
				 S => R,
				 Overflow => Cout2_s);
		 
SUMA4 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> S,
				 B => R,
				 Cin => Cout2_s,
				 S => Z,
				 Overflow => Cout3_s); 	
	
SUMA5 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> T,
				 B => Z,
				 Cin => Cout3_s,  
				 S => O,
				 Overflow => Cout4_s);
				 
SUMA6 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> U,
				 B => O,
				 Cin => Cout4_s,
				 S => P,
				 Overflow => Cout5_s);
				 
SUMA7 : ENTITY work.RippleCarryAdder
	PORT MAP	(A	=> V,
				 B => P,
				 Cin => Cout5_s,
				 S => RESULTADO,
				 Overflow => Cout6_s);
				 
process(status,RESULTADO,S)
	begin
	if (( status = "00000001")) THEn
       RESULTADO1<=RESULTADO(7 downto 0);
		 RESULTADO2<=RESULTADO(15 downto 8);
		 INT_MULT<='1';
		 else
		 RESULTADO1<="00000000";
		 RESULTADO2<="00000000";
		 INT_MULT<='0';
	end if;
	end process;
	
	int_bajo: process(clk,status, cont)
	begin
	if status="00000000" then
		int_MULT<='0';
		cont<=0;
		elsif clk'event and status="00000001" then
			if cont < max_cont then 
				cont <= cont+1;
				int_MULT<='1';
			else
				int_MULT<='0';
				cont <= max_cont;
			end if;
		end if;
	end process;

END ARCHITECTURE ;
