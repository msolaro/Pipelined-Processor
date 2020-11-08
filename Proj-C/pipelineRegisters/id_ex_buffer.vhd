library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--they are the input signals for idex register, but had no idea what the output

entity id_ex_buffer is

port(	i_rs			: in std_logic_vector(4 downto 0);
	i_rt			: in std_logic_vector(4 downto 0);

	i_signExtender		: in std_logic_vector(31 downto 0);

	o_rs			: out std_logic_vector(4 downto 0);
	o_rt			: out std_logic_vector(4 downto 0);

	o_signExtender		: out std_logic_vector(31 downto 0);

	i_aluControl 		: in std_logic_vector(3 downto 0);
	i_ALUSrc		: in std_logic;
	i_MemToReg		: in std_logic;
    	i_S_DMemWr 		: in std_logic;
	i_s_regWr		: in std_logic;
	i_RegDst		: in std_logic;
	i_jump			: in std_logic;
	i_branch		: in std_logic;
	i_ra			: in std_logic;
	i_pc			: in std_logic;
	i_luiboi		: in std_logic;
	i_lw			: in std_logic;

	o_aluControl 		: out std_logic_vector(3 downto 0);
	o_ALUSrc		: out std_logic;
	o_MemToReg		: out std_logic;
    	o_S_DMemWr 		: out std_logic;
	o_s_regWr		: out std_logic;
	o_RegDst		: out std_logic;
	o_jump			: out std_logic;
	o_branch		: out std_logic;
	o_ra			: out std_logic;
	o_pc			: out std_logic;
	o_luiboi		: out std_logic;
	o_lw			: out std_logic;
	
	clock			: in std_logic;
	reset			: in std_logic;
	enable			: in std_logic);

end id_ex_buffer;

architecture behavior of id_ex_buffer is

begin

	REG: process(clock)

	begin

		if(rising_edge(clock)) then
			if(reset ='1')then
				o_rs		<= (others => '0');
				o_rt		<= (others => '0');
				
				o_signExtender 	<= (others => '0');

				o_aluControl 	<= (others => '0');
				o_ALUSrc	<= '0';
				o_MemToReg	<= '0';
    				o_S_DMemWr 	<= '0';
				o_s_regWr	<= '0';	
				o_RegDst	<= '0';	
				o_jump		<= '0';
				o_branch	<= '0';	
				o_ra		<= '0';
				o_pc		<= '0';
				o_luiboi	<= '0';	
				o_lw		<= '0';
			elsif(enable ='1')then
				o_rs 		<= i_rs;
				o_rt 		<= i_rt;

				o_signExtender 	<= i_signExtender;

				o_aluControl 	<= i_aluControl;
				o_ALUSrc	<= i_ALUSrc;
				o_MemToReg	<= i_MemToReg;
    				o_S_DMemWr 	<= i_S_DMemWr;
				o_s_regWr	<= i_s_regWr;	
				o_RegDst	<= i_RegDst;	
				o_jump		<= i_jump;
				o_branch	<= i_branch;	
				o_ra		<= i_ra;
				o_pc		<= i_pc;
				o_luiboi	<= i_luiboi;	
				o_lw		<= i_lw;
			end if;
		end if;
	
	end process;

end behavior;