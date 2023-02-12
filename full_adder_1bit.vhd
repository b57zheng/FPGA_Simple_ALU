library ieee;
use ieee.std_logic_1164.all;
-- Group 9, Hermela Gebretsion, Bowen Zheng

ENTITY full_adder_1bit IS
	port(
			INPUT_A : IN STD_LOGIC;
			INPUT_B : IN STD_LOGIC;
			CARRY_IN: IN STD_LOGIC;
			FULL_ADDER_CARRY_OUTPUT	: OUT STD_LOGIC;
			FULL_ADDER_SUM_OUTPUT	: OUT STD_LOGIC
			);
END full_adder_1bit;

ARCHITECTURE full_adder_1bit_logic OF full_adder_1bit IS
	begin
	FULL_ADDER_SUM_OUTPUT	<= (INPUT_A XOR INPUT_B) XOR CARRY_IN;
	FULL_ADDER_CARRY_OUTPUT	<= ((INPUT_A AND INPUT_B) OR (( CARRY_IN) AND (INPUT_A XOR INPUT_B)));
END ARCHITECTURE  full_adder_1bit_logic;