library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity if_id_buffer is

port(	i_Instruction	:	in std_logic_vector(31 downto 0);
	i_PC4		:	in std_logic_vector(31 downto 0);
	o_Instruction	:	out std_logic_vector(31 downto 0);
	o_PC4		:	out std_logic_vector(31 downto 0);
	clock		:	in std_logic;
	reset		:	in std_logic;
	enable		:	in std_logic);

end if_id_buffer;

architecure behavior of if_id_buffer is

begin

	REG: process(clock)

	begin

		if(rising-edge(clock)) then
			if(reset ='1')then
				o_Instruction 	<= (others => '0');
				o_PC4		<= (others => '0');
			elsif(enable ='1')then
				o_Instruction	<= i_Instruction;
				o_PC4		<= i_PC4;
			end if;
		end if;
	
	end process;

end behavior;
