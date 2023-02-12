library ieee;
Use ieee.std_logic_1164.all;
--Hermela Gebretsion 
--Bowen Zheng

ENTITY PB_inverters IS
	PORT
	(
		pb_n: IN std_logic_vector(3 downto 0);
		pb:	OUT std_logic_vector(3 downto 0)
	);
END PB_inverters;

ARCHITECTURE gates OF PB_inverters IS

Begin

pb <= not(pb_n);

END gates;