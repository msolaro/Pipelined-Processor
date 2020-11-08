library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--they are the input signals for idex register, but had no idea what the output

entity  ex_mem_buffer is

port(
	reset				: in std_logic;
	clock				: in std_logic;
	enable				: in std_logic;
	--
	s_DMemData 		: in std_logic_vector(31 downto 0);
	o_DMemData		: out std_logic_vector(31 downto 0);
	s_DMemWr		: in std_logic;
	o_DMemWr		: out std_logic;
	
	
	--everything for mem/wb
	s_DMemAddr		: in std_logic_vector(31 downto 0);
	o_DMemAddr		: out std_logic_vector(31 downto 0);
	s_RegWrAddr		: in std_logic_vector(31 downto 0);
	o_RegWrAddr 	: out std_logic_vector(31 downto 0);
	s_MemToReg		: in std_logic;
	o_MemToReg		: out std_logic;
	s_ra			: in std_logic;
	o_ra			: out std_logic);
	--gonna need 2 more -- the wb from mem/wb and something else from mem/wb

	

end ex_mem_buffer;

architecture behavior of ex_mem_buffer is

begin

	REG: process(clock)

	begin

		if(rising_edge(clock)) then -- flush
			if(reset ='1')then
				o_DMemAddr		<= (others => '0');
				o_RegWrAddr		<= (others => '0');
				o_MemToReg		<= '0';
				o_DMemWr		<= '0';
				o_DMemData		<= (others => '0');
				o_ra			<= '0';
			elsif(enable ='1')then -- there might be issues with enable==0 and reset = 0
				o_DMemAddr		<= s_DMemAddr;
				o_RegWrAddr		<= s_RegWrAddr;
				o_MemToReg		<= s_MemToReg;
				o_DMemWr		<= s_DMemWr;
				o_DMemData		<= s_DMemData;
				o_ra			<= s_ra;
			end if;
		end if;
	
	end process;

end behavior;

--s_controlSignals(16 downto 0)