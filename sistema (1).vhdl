-- *******************************************************
-- **                      PDUA                         **
-- **              PROCESADOR DIDACTICO                 **
-- **    Arquitectura y Diseno de Sistemas Digitales    **
-- **            UNIVERSIDAD DE LOS ANDES               **
-- **       CMUA: Centro de Microelectronica            **
-- *******************************************************
-- ** Version  0.0 Junio 2007                           **
-- ** Revision 0.1 Noviembre 2007                       **
-- ** Revision 0.2 Marzo 2008                           **
-- *******************************************************
-- Descripcion:                 
--               ______________________________________
--              |                ______   _____        |
--              |               | ROM  | | RAM |       |
--              |               |______| |_____|       |
--              |    _________                         |
--       CLK -->|-->|         |                        |
--     Rst_n -->|-->|  PDUA   |----------------> D_out | 
--       INT -->|-->|         |<---------------- D_in  |    
--              |   |         |----------------> Dir   |    
--              |   |         |----------------> Ctrl  |  
--              |   |_________|                        |
--              |                                      |
--              |______________________________________|  

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sistema is
    Port ( clk 	: in 	std_logic;
           rst_n 	: in 	std_logic;
           int 	: in 	std_logic;
			  pines_gpio: inout std_LOGIC_VECTOR(7 downto 0);
			  bus_data_out : out	std_logic_vector(7 downto 0));
end sistema;

architecture Behavioral of sistema is

component pdua is
    Port ( clk 	: in 	std_logic;
           rst_n 	: in 	std_logic;
			  int    : in  std_logic;
           int_mult		: in std_logic;
			  int_timer		: in std_logic;
			  int_gpio		: in std_logic;
           iom 	: out 	std_logic;
           rw 		: out 	std_logic;
           bus_dir 	: out 	std_logic_vector(7 downto 0);
           bus_data_in : in 	std_logic_vector(7 downto 0);
			  bus_data_out : out	std_logic_vector(7 downto 0));
end component;

component ROM is
    Port ( cs,rd	: in std_logic;
           dir 	: in std_logic_vector(6 downto 0);
           data 	: out std_logic_vector(7 downto 0));
end component;

component RAM is
    Port ( cs,rw 		: in 	std_logic;
           dir 		: in 	std_logic_vector(2 downto 0);
           data_in 	: in 	std_logic_vector(7 downto 0);
			  data_out 	: out std_logic_vector(7 downto 0)
			  ); 
end component;

component PERIFERICO is
    Port ( cs,rw : in 	std_logic;
           dir 		: in 	std_logic_vector(7 downto 0);
           data_in 	: in 	std_logic_vector(7 downto 0);
			  data_out 	: out std_logic_vector(7 downto 0);
			  X_mult		: out std_logic_vector(7 downto 0);
			  Y_mult		: out std_logic_vector(7 downto 0);
			  status		: OUT std_logic_vector(7 downto 0);
			  resultado1: in std_logic_vector(7 downto 0);
			  resultado2: in std_logic_vector(7 downto 0);
			  reset: out std_LOGIC_VECTOR (7 downto 0);
			  enable: out std_LOGIC_VECTOR(7 downto 0);
			  tiempo_cont: in std_LOGIC_VECTOR (7 downto 0);
			  tiempo_usuario :out std_LOGIC_VECTOR(7 downto 0);
			  fin				: in std_LOGIC_VECTOR(7 downto 0);
			  dato_in_gpio: out std_LOGIC_VECTOR(7 downto 0);		  
			  DDRx: out    std_logic_vector(7 downto 0);
			  dato_out_gpio: in std_LOGIC_VECTOR(7 downto 0)
			  );
end component; 

component mult is
    Port ( X       : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
           Y       : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			  status		: in std_logic_vector(7 downto 0);
			  RESULTADO1		 :	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			  RESULTADO2		 :	OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			  INT_MULT     :OUT STD_LOGIC;
			  clk : in std_LOGIC);
end component;

component timer is
    PORT (
        clk    		: IN  STD_LOGIC;
		  reset  		: IN  STD_LOGIC_VECTOR(7 downto 0);
		  enable 		: IN  STD_LOGIC_VECTOR(7 downto 0);
        con_out		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		  con_usuario  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		  fin				: out std_LOGIC_VECTOR(7 downto 0);
		  int_timer    : out std_logic 
    );
end component;

component GPIO is

  port (
	 dato_in		  : in std_LOGIC_VECTOR(7 downto 0);		  
	 pin          : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 DDRx         : in    std_logic_vector(7 downto 0);
	 dato_out	  : out std_LOGIC_VECTOR(7 downto 0);
	 int_gpio	  :out std_logic
	  
    );
end component GPIO;

signal rwi,cs_ROM,cs_RAM,iom,int_mult_signal,int_timer_signal, int_gpio_signal	: std_logic;
signal datai,datao,diri,STATUS_SIGNAL		: std_logic_vector(7 downto 0);
signal X_signal,Y_signal, resULTADO1_signal, resULTADO2_signal : std_LOGIC_VECTOR(7 downto 0);
SIGNAL cs_peri : STD_LOGIC;
signal reset_signal, enable_signal, tiempo_cont, tiempo_usuario : std_LOGIC_VECTOR(7 downto 0);
signal fin_timer,dato_in_gpio_signal, DDRx_signal, dato_out_gpio_signal: std_LOGIC_VECTOR(7 downto 0);

begin

U1: pdua 	port map (clk,rst_n,int,int_mult_signal,int_timer_signal,int_gpio_signal,iom,rwi,diri,datai,datao);
U2: ROM  	port map (cs_ROM,rwi,diri(6 downto 0),datai);
U3: RAM 	port map (cs_RAM,rwi,diri(2 downto 0),datao,datai);
U4: PERIFERICO port map(cs_peri,rwi,diri(7 downto 0),datao,datai,X_signal,Y_signal,STATUS_SIGNAL,resULTADO1_signal,resULTADO2_signal,reset_signal,enable_signal,tiempo_cont,tiempo_usuario,fin_timer,dato_in_gpio_signal,ddrx_signal,dato_out_gpio_signal);
U5: mult port map(X_signal,Y_signal,STATUS_SIGNAL,resULTADO1_signal,resULTADO2_signal,int_mULT_signal,clk);
U6: timer port map(clk, reset_signal, enable_signal, tiempo_cont, tiempo_usuario,fin_timer,int_timer_signal);
U7: GPIO port map(dato_in_gpio_signal, pines_gpio, ddrx_signal, dato_out_gpio_signal, int_gpio_signal);
bus_data_out <= datao;

-- Decodificador
cs_ROM <= iom and not diri(7);
cs_RAM <= iom and diri(7); 
cs_peri<= not iom;
end Behavioral;
