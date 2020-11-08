
---Max Solaro


library IEEE;
use IEEE.std_logic_1164.all;

entity twodMUX is
generic(N : integer := 5);
  port(source  : in std_logic;
	A	: in std_logic_vector(N-1 downto 0);
	B	: in std_logic_vector(N-1 downto 0);
       output  : out std_logic_vector(N-1 downto 0));

end twodMUX;

architecture structure of twodMUX is 

component twobMUX
  port(source  : in std_logic;
	A	: in std_logic;
	B	: in std_logic;
       output  : out std_logic);
end component;

begin

G1: for i in 0 to N-1 generate
  mux_i: twobmux 
    port map(A		 => A(i),
		B	=> B(i),
		source 	=> source,
		output => output(i));
  
end generate;

  
end structure;