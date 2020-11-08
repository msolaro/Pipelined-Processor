

--Max Solaro


--ALU





library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- use that, it's a better coding guideline


entity ALU32Bit is
generic(N : integer := 32);
  port(A		: in std_logic_vector(N-1 downto 0);
	B		: in std_logic_vector(N-1 downto 0);
	alucontrol	: in std_logic_vector(3 downto 0);
	carryin		: out std_logic_vector(N-1 downto 0);
        output 		: out std_logic_vector(N-1 downto 0);
	overflow	: out std_logic;
	zero 		: out std_logic);

end alu32bit;

architecture behavioral of alu32bit is


signal andb, nota	: std_logic_vector(N-1 downto 0);

begin
nota <= (not a);
andb <= (nota and B);
G1: for i in 0 to N-1 generate
with alucontrol select

output <=
	std_logic_vector(unsigned(A(N-1 downto 0)) + unsigned(B(N-1 downto 0))) when "0000", -- ADD
	std_logic_vector(unsigned(A(N-1 downto 0)) - unsigned(B(N-1 downto 0))) when "0001", -- SUB
	a AND b when "0010",								     -- AND
	a or b when "0011",	
	a nand b when "0100",
	a nor b when "0101",
	a xor b when "0110",
	((not a) and b) when "0111", 								-- slt
	x"00000000" when others;
end generate;

G2: for i in 0 to N-1 generate
with alucontrol select

carryin <=
	(A and B) when "0000",
	andb when "0001",
	x"00000000" when others;



zero <= '0';

end generate;

end behavioral;