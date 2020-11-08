library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--they are the input signals for idex register, but had no idea what the output

entity  ex_mem_buffer is

port(
	clock				: in std_logic_vector;
	s_DMemOut 		: in std_logic_vector(31 downto 0);
	s_DMemAddr		: in std_logic_vector(31 downto 0);
	o_DMemOut 		: out std_logic_vector(31 downto 0);
	o_DMemAddr		: out std_logic_vector(31 downto 0);
	s_RegWrAddr		: in std_logic_vector(31 downto 0);
	o_RegWrAddr 	: out std_logic_vector(31 downto 0);
	s_MemToReg		: in std_logic;
	o_MemToReg		: out std_logic;
	s_ra			: in std_logic;
	o_ra			: out std_logic);
	--gonna need 2 more -- the wb from mem/wb and something else from mem/wb

);	
	

end ex_mem_buffer;

architecure behavior of ex_mem_buffer is

begin

	REG: process(clock)

	begin

		if(rising_edge(clock)) then
			if(reset ='1')then -- flush
				o_DMemOut 		<= (others => '0');
				o_DMemAddr		<= (others => '0');
				o_RegWrAddr		<= (others => '0');
				o_MemToReg		<= (others => '0');
				o_ra			<= (others => '0');
			elsif(enable ='1')then
				o_DMemOut		<= s_DMemOut; -- there might be issues with enable==0 and reset = 0
				o_DMemAddr		<= s_DMemAddr;
				o_RegWrAddr		<= s_RegWrAddr;
				o_MemToReg		<= s_MemToReg;
				o_ra			<= s_ra;
			end if;
		end if;
	
	end process;

end behavior;

--s_controlSignals(16 downto 0)