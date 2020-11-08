---



--test



--Max Solaro



--sign extender



library ieee;
use ieee.numeric_std.all;
use IEEE.std_logic_1164.all;


entity signextender is

  port(input	 : in	std_logic_vector(16-1 downto 0);
	output	: out	std_logic_vector(32-1 downto 0));

end signextender;


architecture behavior of signextender is
begin
	output <= std_logic_vector(resize(signed(input), output'length));
end architecture;