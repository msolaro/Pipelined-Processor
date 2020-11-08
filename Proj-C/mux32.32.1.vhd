--- max solaro





---Max Solaro


library IEEE;
use IEEE.std_logic_1164.all;


entity bigmux is
	port(sel	: in std_logic_vector(4 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	in2		: in std_logic_vector(31 downto 0);
	in3		: in std_logic_vector(31 downto 0);
	in4		: in std_logic_vector(31 downto 0);
	in5		: in std_logic_vector(31 downto 0);
	in6		: in std_logic_vector(31 downto 0);
	in7		: in std_logic_vector(31 downto 0);
	in8		: in std_logic_vector(31 downto 0);
	in9		: in std_logic_vector(31 downto 0);
	in10		: in std_logic_vector(31 downto 0);
	in11		: in std_logic_vector(31 downto 0);
	in12		: in std_logic_vector(31 downto 0);
	in13		: in std_logic_vector(31 downto 0);
	in14		: in std_logic_vector(31 downto 0);
	in15		: in std_logic_vector(31 downto 0);
	in16		: in std_logic_vector(31 downto 0);
	in17		: in std_logic_vector(31 downto 0);
	in18		: in std_logic_vector(31 downto 0);
	in19		: in std_logic_vector(31 downto 0);
	in20		: in std_logic_vector(31 downto 0);
	in21		: in std_logic_vector(31 downto 0);
	in22		: in std_logic_vector(31 downto 0);
	in23		: in std_logic_vector(31 downto 0);
	in24		: in std_logic_vector(31 downto 0);
	in25		: in std_logic_vector(31 downto 0);
	in26		: in std_logic_vector(31 downto 0);
	in27		: in std_logic_vector(31 downto 0);
	in28		: in std_logic_vector(31 downto 0);
	in29		: in std_logic_vector(31 downto 0);
	in30		: in std_logic_vector(31 downto 0);
	in31		: in std_logic_vector(31 downto 0);
	in32		: in std_logic_vector(31 downto 0);
	output		: out std_logic_vector(31 downto 0));

end bigmux;

architecture dataflow of bigmux is
begin
with sel select
output <= in1 when "00000",
	in2 when "00001",
	in3 when "00010",
	in4 when "00011",
	in5 when "00100",
	in6 when "00101",
	in7 when "00110",
	in8 when "00111",
	in9 when "01000",
	in10 when "01001",
	in11 when "01010",
	in12 when "01011",
	in13 when "01100",
	in14 when "01101",
	in15 when "01110",
	in16 when "01111",
	in17 when "10000",
	in18 when "10001",
	in19 when "10010",
	in20 when "10011",
	in21 when "10100",
	in22 when "10101",
	in23 when "10110",
	in24 when "10111",
	in25 when "11000",
	in26 when "11001",
	in27 when "11010",
	in28 when "11011",
	in29 when "11100",
	in30 when "11101",
	in31 when "11110",
	in32 when "11111",
	x"00000000" when others;

end dataflow;

