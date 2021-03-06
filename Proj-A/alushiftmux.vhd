--- max solaro





---Max Solaro


library IEEE;
use IEEE.std_logic_1164.all;


entity mux4in is
	port(sel	: in std_logic_vector(1 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	in2		: in std_logic_vector(31 downto 0);
	in3		: in std_logic_vector(31 downto 0);
	in4		: in std_logic_vector(31 downto 0);
	
	output		: out std_logic_vector(31 downto 0));

end mux4in;

architecture dataflow of mux4in is
begin
with sel select
output <= in1 when "00",
	in2 when "01",
	in3 when "10",
	in4 when "11",
	"00000000" when others;

end dataflow;

