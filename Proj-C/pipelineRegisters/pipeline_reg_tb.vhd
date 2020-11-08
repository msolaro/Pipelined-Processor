









--pipelin reg tb

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pipelineReg is
	port(
	iCLK            : in std_logic);
end tb_pipelineReg;



architecture behavior of tb_pipelineReg is

 component mem_wb_buffer
port(
	reset				: in std_logic;
	enable				: in std_logic;
	clock				: in std_logic;
	--
	s_DMemData 		: in std_logic_vector(31 downto 0);
	o_DMemData		: out std_logic_vector(31 downto 0);
	s_DMemWr		: in std_logic;
	o_DMemWr		: out std_logic;
	
	
	--everything for ex/mem
	s_DMemAddr		: in std_logic_vector(31 downto 0);
	o_DMemAddr		: out std_logic_vector(31 downto 0);
	s_RegWrAddr		: in std_logic_vector(31 downto 0);
	o_RegWrAddr 	: out std_logic_vector(31 downto 0);
	s_MemToReg		: in std_logic;
	o_MemToReg		: out std_logic;
	s_ra			: in std_logic;
	o_ra			: out std_logic);
	
  end component;
  
  component ex_mem_buffer
  port(
	reset				: in std_logic;
	clock				: in std_logic;
	enable				: in std_logic;
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
	end component;
	
	component id_ex_buffer
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
	end component;
	
	component if_id_buffer
	port(	i_Instruction	:	in std_logic_vector(31 downto 0);
	i_PC4		:	in std_logic_vector(31 downto 0);
	o_Instruction	:	out std_logic_vector(31 downto 0);
	o_PC4		:	out std_logic_vector(31 downto 0);
	clock		:	in std_logic;
	reset		:	in std_logic;
	enable		:	in std_logic);

end component;

--singals
signal tb_DmemData, tb_DmemAddr, tb_RegWrAddr,tb_DmemDatao, tb_DmemOut	: std_logic_vector(31 downto 0);
signal tb_DmemWr,id_ex_enable, id_ex_reset, tb_ra, tb_MemtoReg, mem_wb_reset, mem_wb_enable, ex_Mem_reset, ex_mem_enable : std_logic;
signal tb_Pc4	: std_logic_vector(31 downto 0);
signal tb_instruction, tb_signExtender	: std_logic_vector(31 downto 0);
signal if_id_reset, tb_regDst, if_id_enable, tb_pc, tb_lw, tb_luiboi, tb_branch, tb_jump, tb_RegWr,tb_ALUSrc: std_logic;
signal  tb_rt, tb_rs 	: std_logic_vector(4 downto 0);
signal tb_alucontrol	: std_logic_vector(3 downto 0);

begin
mem_wb : mem_wb_buffer
port map(clock => iclk,
	s_DmemAddr	=> tb_DmemAddr,
	s_DmemData	=> tb_DmemData,
	s_DmemWr	=> tb_DmemWr,
	s_RegWrAddr	=> tb_RegWrAddr,
	s_MemtoReg	=> tb_MemtoReg,
	s_ra		=> tb_ra,
	reset		=> mem_wb_reset,
	enable		=> mem_wb_enable,
	o_dmemData	=> tb_dmemDatao);


ex_mem: ex_mem_buffer
port map( clock => iCLK,
		reset	=> ex_mem_reset,
		enable	=> ex_mem_enable,
		s_DmemAddr => tb_DmemAddr,
		s_dMemOut	=> tb_DmemOut,
		s_ra		=> tb_ra,
		s_RegWrAddr => tb_RegWrAddr,
		s_MemToReg	=> tb_MemToReg);
		
		
if_id: if_id_buffer
port map( clock => iCLK,
		reset	=> if_id_reset,
		enable	=> if_id_enable,
		i_PC4	=> tb_Pc4,
		i_Instruction		=> tb_instruction);
		
		
id_ex: id_ex_buffer
port map( clock 	=> iclk,
		enable		=> id_ex_enable,
		reset		=> id_ex_reset,
		i_rs		=> tb_rs,
		i_rt		=> tb_rt,
		i_signExtender => tb_signExtender,
		i_aluControl	=> tb_aluControl,
		i_ALUSrc		=> tb_ALUSrc,
		i_MemToReg		=> tb_MemToReg,
		i_S_DMemWr		=> tb_DMemWr,
		i_s_regWr		=> tb_RegWr,
		i_RegDst		=> tb_regDst,
		i_jump			=> tb_jump,
		i_branch		=> tb_branch,
		i_ra			=> tb_ra,
		i_pc			=> tb_pc,
		i_luiboi		=> tb_luiboi,
		i_lw			=> tb_lw);
TB : process
begin


tb_DMemAddr	<= x"0101ffff";
tb_DMemData	<= x"11110000";
tb_DMemWr	<=  '1';
tb_RegWrAddr	<=  x"00001111";
tb_MemToReg	<=  '0';
tb_ra		<=  '1';
mem_wb_reset		<=  '0';
mem_wb_enable 		<=  '1';
if_id_reset			<=  '0';
if_id_enable 		<=  '1';
ex_mem_reset		<=  '0';
ex_mem_enable 		<=  '1';
id_ex_reset			<=  '0';
id_ex_enable 		<=  '1';
wait for 100 ns;

tb_DMemAddr	<= x"0101ffff";
tb_DMemData	<= x"11110000";
tb_DMemWr	<=  '1';
tb_RegWrAddr	<=  x"00001111";
tb_MemToReg	<=  '0';
tb_ra		<=  '1';
mem_wb_reset		<=  '1';
mem_wb_enable 		<=  '0';
if_id_reset			<=  '1';
if_id_enable 		<=  '0';
ex_mem_reset		<=  '1';
ex_mem_enable 		<=  '0';
id_ex_reset			<=  '1';
id_ex_enable 		<=  '0';
wait for 100 ns;


tb_DMemAddr	<= x"0101ffff";
tb_DMemData	<= x"11110000";
tb_DMemWr	<=  '1';
tb_RegWrAddr	<=  x"00001111";
tb_MemToReg	<=  '0';
tb_ra		<=  '1';
mem_wb_reset		<=  '0';
mem_wb_enable 		<=  '0';
if_id_reset			<=  '0';
if_id_enable 		<=  '0';
ex_mem_reset		<=  '0';
ex_mem_enable 		<=  '0';
id_ex_reset			<=  '0';
id_ex_enable 		<=  '0';
wait for 100 ns;


tb_DMemAddr	<= x"0101ffff";
tb_DMemData	<= x"11110000";
tb_DMemWr	<=  '1';
tb_RegWrAddr	<=  x"00001111";
tb_MemToReg	<=  '0';
tb_ra		<=  '1';
mem_wb_reset		<=  '0';
mem_wb_enable 		<=  '1';
if_id_reset			<=  '0';
if_id_enable 		<=  '1';
ex_mem_reset		<=  '0';
ex_mem_enable 		<=  '1';
id_ex_reset			<=  '0';
id_ex_enable 		<=  '1';
wait for 100 ns;


tb_DMemAddr	<= x"0101ffff";
tb_DMemData	<= x"11110000";
tb_DMemWr	<=  '1';
tb_RegWrAddr	<=  x"00001111";
tb_MemToReg	<=  '0';
tb_ra		<=  '1';
mem_wb_reset		<=  '1';
mem_wb_enable 		<=  '1';
if_id_reset			<=  '1';
if_id_enable 		<=  '1';
ex_mem_reset		<=  '1';
ex_mem_enable 		<=  '1';
id_ex_reset			<=  '1';
id_ex_enable 		<=  '1';
wait for 100 ns;



end process;
end behavior;