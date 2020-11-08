
---Max Solaro


library IEEE;
use IEEE.std_logic_1164.all;

entity twobMUX is
  port(source  : in std_logic;
	A	: in std_logic;
	B	: in std_logic;
       output  : out std_logic);

end twobMUX;

architecture structure of twobMUX is 

component invg
  port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;

component andg2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component org2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal aout	: std_logic;
signal bout	: std_logic;
signal sinverse	: std_logic;

begin
	sourceinverse: invg
	port MAP(i_A	=> source,
		o_F	=> sinverse);

	asource: andg2
 	port MAP(i_A           => A,
             i_B               => sinverse,
             o_F               => aout);

	bsource: andg2
	port MAP(i_A		=> B,
	     i_B		=> source,
	     o_F		=> bout);

	orOUT: org2
	port MAP(i_A		=> aout,
		i_B		=> bout,
		o_F		=> output);
	

  
end structure;