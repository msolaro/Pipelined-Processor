library IEEE;
use IEEE.std_logic_1164.all;

entity xor2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end xor2;

architecture dataflow of xor2 is
begin

  o_F <= i_A xor i_B;
  
end dataflow;
