

--Max Solaro


-- control unit test bench




library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- use that, it's a better coding guideline


entity controlUnit is
  port( OPcode		: in std_logic_vector(5 downto 0);
	Func		: in std_logic_vector(5 downto 0);
	aluControl 	: out std_logic_vector(3 downto 0);
	ALUSrc		: out std_logic;
	MemToReg	: out std_logic;
        S_DMemWr 	: out std_logic;
	s_regWr		: out std_logic;
	RegDst		: out std_logic);

end controlUnit;

architecture behavioral of controlUnit is

--MemToReg == 1 when opcode == 100011

--s_DMEMWR == 1 when opcode == 101011

begin

process (OPcode, Func)
begin
 case OPcode is
 when "001001" => --addiu
	ALUSrc	   <= '1';
	ALUControl <= "0000";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "001100" => --andi
	ALUSrc	   <= '1';
	ALUControl <= "0010";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "001111" => --lui
	ALUSrc	   <= '1';
	ALUControl <= "0010";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "100011" => --lw
	ALUSrc	   <= '1';
	ALUControl <= "0010";
	MemToReg   <= '1';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "001110" => --xori
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "010001" => --ori
	ALUSrc	   <= '1';
	ALUControl <= "0011";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "001010" => --slti
	ALUSrc	   <= '1';
	ALUControl <= "0111";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "001011" => --sltiu
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "101011" => --sw
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '1';
	s_RegWr    <= '0';
	RegDst     <= '0';

when "000100" => --beq
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '0';
	RegDst     <= '0';

when "000101" => --bme
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '0';
	RegDst     <= '0';

when "000010" => --j
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '0';
	RegDst     <= '0';

when "000011" => --jal
	ALUSrc	   <= '1';
	ALUControl <= "0110";
	MemToReg   <= '0';
	S_DMemWr   <= '0';
	s_RegWr    <= '1';
	RegDst     <= '0';

when "000000" =>
	case Func is	
	when "100000" => -- add
		ALUSrc	   <= '0';
		ALUControl <= "0000";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100001" => -- addu
		ALUSrc	   <= '0';
		ALUControl <= "0000";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100100" => -- and
		ALUSrc	   <= '0';
		ALUControl <= "0010";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100111" => -- nor
		ALUSrc	   <= '0';
		ALUControl <= "0101";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100110" => -- xor
		ALUSrc	   <= '0';
		ALUControl <= "0110";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100101" => -- or
		ALUSrc	   <= '0';
		ALUControl <= "0011";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "101010" => -- slt
		ALUSrc	   <= '0';
		ALUControl <= "0111";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "101011" => -- sltu
		ALUSrc	   <= '0';
		ALUControl <= "0111";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "000000" => -- sll
		ALUSrc	   <= '1';
		ALUControl <= "1001";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "000010" => -- srl
		ALUSrc	   <= '1';
		ALUControl <= "1010";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "000011" => -- sra
		ALUSrc	   <= '1';
		ALUControl <= "1010";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "000100" => -- sllv
		ALUSrc	   <= '0';
		ALUControl <= "1001";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "000110" => -- srlv
		ALUSrc	   <= '0';
		ALUControl <= "1010";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "000111" => -- srav
		ALUSrc	   <= '0';
		ALUControl <= "1010";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100010" => -- sub
		ALUSrc	   <= '0';
		ALUControl <= "0001";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "100011" => -- subu
		ALUSrc	   <= '0';
		ALUControl <= "0001";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '1';
		RegDst     <= '1';

	when "001000" => -- jr
		ALUSrc	   <= '0';
		ALUControl <= "0110";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '0';
		RegDst     <= '0';

	when others =>
		ALUSrc	   <= '0';
		ALUControl <= "0000";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '0';
		RegDst     <= '0';
end case;

when others =>
		ALUSrc	   <= '0';
		ALUControl <= "0000";
		MemToReg   <= '0';
		S_DMemWr   <= '0';
		s_RegWr    <= '0';
		RegDst     <= '0';

end case;
end process;
end behavioral;



















