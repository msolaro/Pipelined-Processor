









-- control unit test bench

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_controlUnit is

end tb_controlUnit;



architecture behavior of tb_controlUnit is

 component controlUnit
    port(OPcode		: in std_logic_vector(5 downto 0);
	Func		: in std_logic_vector(5 downto 0);
	aluControl 	: out std_logic_vector(3 downto 0);
	ALUSrc		: out std_logic;
	MemToReg	: out std_logic;
        S_DMemWr 	: out std_logic;
	s_regWr		: out std_logic;
	RegDst		: out std_logic;
		jump		: out std_logic;
	branch		: out std_logic;
	ra			: out std_logic;
	pc			: out std_logic;
	luiboi		: out std_logic;
	lw			: out std_logic);
	
  end component;

signal tb_opcode, tb_func : std_logic_vector(5 downto 0);
signal tb_aluControl	: std_logic_vector(3 downto 0);
signal tb_ALUSrc, tb_MemToReg, tb_s_dmemWr, tb_s_regWr, tb_RegDst, tb_jump, tb_branch, tb_ra, tb_pc, tb_luiboi, tb_lw : std_logic;

begin
ctrl : controlUnit
port map(OPcode		=> tb_opcode,
	Func		=> tb_func,
	aluControl 	=> tb_aluControl,
	ALUSrc		=> tb_ALUSrc,
	MemToReg	=> tb_Memtoreg,
	s_dmemwr 	=> tb_s_dmemWr,
	s_regWr 	=> tb_s_regWr,
	RegDst		=> tb_RegDst,
	jump		=> tb_jump,
	branch		=> tb_branch,
	ra			=> tb_ra,
	pc			=> tb_pc,
	luiboi		=> tb_luiboi,
	lw			=> tb_lw);

TB : process
begin

tb_opcode <= "100011";

wait for 100 ns;

tb_opcode <= "001001";

wait for 100 ns;

tb_opcode <= "000000";
tb_func <= "000000";
wait for 100 ns;

tb_opcode <= "001010";
tb_func <= "000000";
wait for 100 ns;


tb_opcode <= "000011";
tb_func <= "000000";
wait for 100 ns;


tb_opcode <= "000000";
tb_func <= "100000";
wait for 100 ns;


tb_opcode <= "000000";
tb_func <= "100111";
wait for 100 ns;


tb_opcode <= "000000";
tb_func <= "000011";
wait for 100 ns;


tb_opcode <= "000010";
tb_func <= "000000";
wait for 100 ns;

tb_opcode <= "000101";
tb_func <= "000000";
wait for 100 ns;

tb_opcode <= "000011";
tb_func <= "000000";
wait for 100 ns;

tb_opcode <= "000000";
tb_func <= "000000";
wait for 100 ns;

end process;
end behavior;