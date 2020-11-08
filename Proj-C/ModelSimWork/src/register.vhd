



-- Max Solaro
library IEEE;
use IEEE.std_logic_1164.all;


entity nbitregister is
generic(N : integer := 32);
  port(CLK  : in std_logic;
	i_RST	: in std_logic;
	i_WE	: in std_logic;
	data	: in std_logic_vector(N-1 downto 0);
       output  : out std_logic_vector(N-1 downto 0));

end nbitregister;


architecture structure of nbitregister is

component gdff
	port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin

G1: for i in 0 to N-1 generate
  reg_i: gdff 
    port map( i_CLK	=> CLK,
		i_RST	=> i_RST,
		i_WE	=> i_WE,
		i_D	=> data(i),
		o_Q	=> output(i));
  
end generate;

end structure; 