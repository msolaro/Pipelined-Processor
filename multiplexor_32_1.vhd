library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.ALL;
use work.register_array.all;

entity multiplexor_32_1 is

  port(i_A  : in registerArray;
       i_Sel  : in std_logic_vector(4 downto 0);
       o_F  : out std_logic_vector(31 downto 0));

end multiplexor_32_1;

architecture dataflow of multiplexor_32_1 is

begin

  o_F <= i_A(to_integer(unsigned(i_Sel)));
  
end dataflow;
