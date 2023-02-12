library ieee;
use ieee.std_logic_1164.all;
--Hermela Gebretsion 
--Bowen Zheng

ENTITY sum_operator IS
	port(
			in1: IN STD_LOGIC_vector(3 downto 0);
			in2: IN STD_LOGIC_vector(3 downto 0);
			in_select: IN STD_LOGIC_VECTOR(1 downto 0); -- 2 to 1 mux input selector
			out1: OUT STD_LOGIC_vector(3 downto 0);
			);
END sum_operator;
;

ARCHITECTURE sum_operator_logic OF sum_operator IS
	begin
	
with in_select(1 downto 0) select
in_select <= (logic_in0 AND logic_in1) when "00",
				 (logic_in0 OR logic_in1) when "01",
				 (logic_in0 XOR logic_in1) when "10",
			    (logic_in0 XNOR logic_in1) when "11";
END ARCHITECTURE  full_adder_1bit_logic;