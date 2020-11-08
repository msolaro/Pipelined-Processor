library IEEE;
use IEEE.std_logic_1164.all;

entity FullAdderStructural is
  
  generic(N: integer := 32);
  
  port(i_A : in std_logic_vector(N-1 downto 0);
       i_B : in std_logic_vector(N-1 downto 0);
       i_C : in std_logic;
       o_S : out std_logic_vector(N-1 downto 0);
       o_C : out std_logic);

end FullAdderStructural;

architecture structure of FullAdderStructural is
  
  component FullAdder is
    port(i_OperandA : in std_logic;
       i_OperandB : in std_logic;
       i_Carry    : in std_logic;
       o_Sum      : out std_logic;
       o_Carry    : out std_logic);
  end component;
  
  signal temp_Carryin : std_logic_vector(N downto 0);
  
  begin
    temp_Carryin(0) <= i_C;
    
    G1: for i in 0 to N-1 generate
      FullAdder_i: FullAdder
        port map(i_OperandA => i_A(i),
                 i_OperandB => i_B(i),
                 i_Carry => temp_Carryin(i),
                 o_Sum => o_S(i),
                 o_Carry => temp_Carryin(i+1));
      end generate;
      
      o_C <= temp_Carryin(N);
      
    
  end structure;