

--- max solaro




-- alu and shifter

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;



entity alushift is 
generic(N : integer := 32);
  port(inputA		: in std_logic_vector(N-1 downto 0);
	inputB		: in std_logic_vector(N-1 downto 0);
	shiftcontrol	: in std_logic_vector(1 downto 0);
	carryin		: out std_logic_vector(N-1 downto 0);
	shamt		: in std_logic_vector(4 downto 0);
	alucontrol	: in std_logic_vector(3 downto 0);
    output 		: out std_logic_vector(N-1 downto 0);
	overflow	: out std_logic;
	zero		: out std_logic_Vector(N-1 downto 0));
	--shift control 00 == alu 01 ==srl 10 == sll 11== sra
	--alucontrol 0*** - alu
	--alucontrol 100* - sll
	--alucontrol 101* - sra
	--alucontrol 110* - srl
	
end alushift;

architecture mixed of alushift is


--signals

component alu32bit
port(A		: in std_logic_vector(N-1 downto 0);
	B		: in std_logic_vector(N-1 downto 0);
	alucontrol	: in std_logic_vector(3 downto 0);
	carryin		: out std_logic_vector(N-1 downto 0);
        output 		: out std_logic_vector(N-1 downto 0);
	overflow	: out std_logic;
	zero 		: out std_logic_vector(N-1 downto 0));
end component;

component shiftleft
 port(input		: in std_logic_vector(N-1 downto 0);
	--shiftcontrol	: in std_logic_vector(2 downto 0);
	shamt		: in std_logic_vector(4 downto 0);
        output 		: out std_logic_vector(N-1 downto 0));
end component;

component shifter
  port(input		: in std_logic_vector(N-1 downto 0);
	--shiftcontrol	: in std_logic_vector(2 downto 0);
	shamt		: in std_logic_vector(4 downto 0);
        output 		: out std_logic_vector(N-1 downto 0));
end component;

component ashifter
 port(input		: in std_logic_vector(N-1 downto 0);
	--shiftcontrol	: in std_logic_vector(2 downto 0);
	shamt		: in std_logic_vector(4 downto 0);
        output 		: out std_logic_vector(N-1 downto 0));

end component;

component mux4in
	port(sel	: in std_logic_vector(1 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	in2		: in std_logic_vector(31 downto 0);
	in3		: in std_logic_vector(31 downto 0);
	in4		: in std_logic_vector(31 downto 0);
	
	output		: out std_logic_vector(31 downto 0));
end component;




signal aluOut : std_logic_vector(N-1 downto 0);
signal ashiftout : std_logic_vector(N-1 downto 0);
signal shifterout : std_logic_Vector(N-1 downto 0);
signal shiftleftout : std_logic_vector(n-1 downto 0);

begin

alu: alu32bit
port map( A		=> inputA,
	B		=> inputB,
	alucontrol	=> alucontrol,
	carryin		=> carryin,
	output		=> aluout,
	overflow	=> overflow,
	zero		=> zero);

shift1: ashifter
port map( input 	=> inputA,
	shamt		=> shamt,
	output		=> ashiftout);

shift2: shifter
port map( input 	=> inputA,
	shamt		=> shamt,
	output		=> shifterout);

shift3: shiftleft
port map( input 	=> inputA,
	shamt		=> shamt,
	output		=> shiftleftout);

mux: mux4in
port map(sel 	=>shiftcontrol,
	in1	=> aluOut,
	in2	=> shifterout,
	in3	=> shiftleftout,
	in4	=> ashiftout,
	output	=> output);


end mixed;













