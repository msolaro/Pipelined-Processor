

--Max Solaro


--ALU





library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- use that, it's a better coding guideline


entity ALU is
  port(A	: in std_logic;
	B	: in std_logic;
	alucontrol : in std_logic_vector(2 downto 0);
	overflow: out std_logic;
	carryout: out std_logic;
       output : out std_logic);

end alu;

architecture behavioral of alu is

begin

with alucontrol select

output <=
	(A xor B) when "000",
	a xor b when "001",
	a and b when "010",
	a or b when "011",
	a nand b when "100",
	a nor b when "101",
	a xor b when "110",
	((not a) and b) when "111",
	'0' when others;

with alucontrol select

carryout <=
	(A and B) when "000",
	((not a) and B) when "001",
	'0' when others;

end behavioral;