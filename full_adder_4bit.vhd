library ieee;
use ieee.std_logic_1164.all;
-- Group 9, Hermela Gebretsion, Bowen Zheng
ENTITY full_adder_4bit is port(
	INPUT_B 		: in std_logic_vector(3 downto 0);
	INPUT_A 		: in std_logic_vector(3 downto 0);
	CARRY_IN		: in std_logic;
	CARRY_OUT_3 	: out std_logic;
	sum				: out std_logic_vector(3 downto 0)
	);
end full_adder_4bit;
	
architecture sum of full_adder_4bit is

component full_adder_1bit port (
   INPUT_A 					: in std_logic;
	INPUT_B 				: in std_logic;
	CARRY_IN				: in std_logic;
	FULL_ADDER_CARRY_OUTPUT	: out std_logic;
	FULL_ADDER_SUM_OUTPUT	: out std_logic
   ); 
   end component;

	--signals stores carry_out value from previous mux
	signal carry_out0 : std_logic;
	signal carry_out1 : std_logic;
	signal carry_out2 : std_logic;
	
begin 
	--to create 4-bit adder, chain together the carry_out of each 1 bit adder to the carry_in of the next 1 bit adder using 4 instances
	INST1: full_adder_1bit port map(INPUT_A(0), INPUT_B(0), CARRY_IN, carry_out0, sum(0)); 
	INST2: full_adder_1bit port map(INPUT_A(1), INPUT_B(1), carry_out0, carry_out1, sum(1)); 
	INST3: full_adder_1bit port map(INPUT_A(2), INPUT_B(2), carry_out1, carry_out2, sum(2));
	INST4: full_adder_1bit port map(INPUT_A(3), INPUT_B(3), carry_out2, carry_out_3, sum(3));

end sum;

	
