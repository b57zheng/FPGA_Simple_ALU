library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Group 9, Hermela Gebretsion, Bowen Zheng


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n			: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
); 

end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
	component SevenSegment port (
		hex   		: in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	: out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
		); 
   end component;
	
	component segment7_mux port (
		clk         : in std_logic := '0';
		DIN2        : in std_logic_vector(6 downto 0);
		DIN1        : in std_logic_vector(6 downto 0);
		DOUT        : out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
		);
	end component;
	
	component logic_processor port(
		logic_in0		: in std_logic_vector(3 downto 0);
		logic_in1		: in std_logic_vector(3 downto 0);
		logic_select    : in std_logic_vector(1 downto 0);
		logic_out		: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component PB_inverters port(
		pb_n  : in std_logic_vector(3 downto 0); -- push buttons
		pb 	  : out std_logic_vector(3 downto 0) -- outputs inverted push button signals
		);
	end component;
	
	component full_adder_4bit port(
		INPUT_A 		: in std_logic_vector(3 downto 0);
		INPUT_B 		: in std_logic_vector(3 downto 0);
		CARRY_IN		: in std_logic;
		CARRY_OUT_3 	: out std_logic;
		SUM				: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component two_to_one port(
		in0 		: in std_logic_vector(3 downto 0);
		in1			: in std_logic_vector(3 downto 0);
		hex_select	: in std_logic;
		hex_out 	: out std_logic_vector(3 downto 0)
		);
	end component;
 
-- Create any signals, or temporary variables to be used
--
-- std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
	signal hex_A		: std_logic_vector(3 downto 0); -- 4-bit signal carries the values of switches 0 to 3
	signal hex_B		: std_logic_vector(3 downto 0); -- 4-bit signal carries the values of switches 4 to 7
	
	signal seg7_A		: std_logic_vector(6 downto 0); -- 7 segement display signals for switches 0 to 3
	signal seg7_B		: std_logic_vector(6 downto 0); -- 7 segement display signals for switches 4 to 7
	
	signal pb			: std_logic_vector(3 downto 0); -- signals of all 4 push buttons
	signal carry_out 	: std_logic;						  -- full_adder4bit output signal					
	signal sum 			: std_logic_vector(3 downto 0); -- full_adder4bit output signal		
	signal signal_C 	: std_logic_vector(3 downto 0); -- signal used to concatenate carry_out and "000"
	signal signal_A		: std_logic_vector(3 downto 0); -- 4 bit signal to be used as hex_out value in INST7, will be converted to 7 bits for display
	signal signal_B		: std_logic_vector(3 downto 0); -- 4 bit signal to be used as hex_out value in INST8, will be converted to 7 bits for display
	
-- Here the circuit begins

	begin

		hex_A 	 <= sw(3 downto 0); 				-- connects hex_A to swtiches 0 to 3
		hex_B 	 <= sw(7 downto 4); 				-- connects hex_B to swtiches 4 to 7
		signal_C <= "000" & carry_out;		-- concatenate 3-bit signal and 1-bit signal to a 4-bit signal
	

--COMPONENT HOOKUP
--
--generate the seven segment coding

	INST1: sevensegment port map(signal_A, seg7_A); 																			-- convert signal_A from 4 bits to seven bits
	
	INST2: sevensegment port map(signal_B, seg7_B); 																			-- convert signal_B from 4 bits to seven bits
	
	INST3: segment7_mux port map(Clkin_50, seg7_A, seg7_B, seg7_data(6 downto 0), seg7_char2, seg7_char1); 	-- ouputs seven segement display
	
	INST4: PB_Inverters port map(pb_n, pb);																						-- inverts the polarity of the push buttons,
																																				-- pb(3 downto 0) from active low to active high
																																				
	INST5: logic_processor port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));									-- 2-to-1 mux selector controls whether LEDS 
																																				-- are on/off based on pb(1 downto 0)
																																				
	INST6: full_adder_4bit port map(hex_A, hex_B, '0', carry_out, sum(3 downto 0));									-- carry_in defined as 0 to start daisy-chain of full_adder_1bit logic
	
	INST7: two_to_one port map(hex_B, signal_C, pb(2), signal_B); 															-- 2-to-1 mux selects input, when pb(2) is '0' select hex_B, 
																																				-- when pb(2) is '1' select signal_C
																																				
	INST8: two_to_one port map(hex_A, sum, pb(2), signal_A);																 	-- 2-to-1 mux selects input, when pb(2) is '0' select hex_A,
																																				-- when pb(2) is '1' select sum
	
end SimpleCircuit;

