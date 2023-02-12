library ieee;
use ieee.std_logic_1164.all;
-- Group 9, Hermela Gebretsion, Bowen Zheng

entity two_to_one is 
	port(
	in0 			: in std_logic_vector(3 downto 0);
	in1				: in std_logic_vector(3 downto 0);
	hex_select		: in std_logic;
	hex_out			: out std_logic_vector(3 downto 0)
	);
end two_to_one;
	
architecture two_to_one_logic of two_to_one is

begin

	with hex_select select
	
		hex_out <= 	in0 when '0',
					in1 when '1';
end two_to_one_logic;
	