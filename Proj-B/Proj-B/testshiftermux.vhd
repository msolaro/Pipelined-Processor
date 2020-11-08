--- max solaro





---Max Solaro


library IEEE;
use IEEE.std_logic_1164.all;


entity testmux4in is
	port(sel	: in std_logic_vector(2 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	in2		: in std_logic_vector(31 downto 0);
	in3		: in std_logic_vector(31 downto 0);
	in4		: in std_logic_vector(31 downto 0);
	
	output		: out std_logic_vector(31 downto 0));

end testmux4in;

architecture dataflow of testmux4in is
begin
with sel select
output <= in1 when "000",
	in1 when "001",
	in1 when "010",
	in1 when "011",
	in2 when "110",
	in3 when "100",
	in4 when "101",
	"00000000000000000000000000000000" when others;

end dataflow;

