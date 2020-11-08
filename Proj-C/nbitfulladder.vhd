--- Max Solaro





library IEEE;
use IEEE.std_logic_1164.all;

entity nbitfulladder is
  generic(N : integer := 32);
  port(A  : in std_logic_vector(N-1 downto 0);
	B  : in std_logic_vector(N-1 downto 0);
	carryin  : in std_logic_vector(N-1 downto 0);
        carryout  : out std_logic_vector(N-1 downto 0);
        sum  : out std_logic_vector(N-1 downto 0));

end nbitfulladder;

architecture structure of nbitfulladder is 

component fulladder
  port(A          : in std_logic;
	B	: in std_logic;
	carryin	: in std_logic;
	carryout : out std_logic;
       sum          : out std_logic);
end component;

begin

--loop
G1: for i in 0 to N-1 generate
  fulladder_i: fulladder 
    port map(A		 => A(i),
		B	=> B(i),
		Carryin	=> carryin(i),
		carryout	=> carryout(i),
		sum => sum(i));
  
end generate;

  
end structure;