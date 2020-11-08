--- max solaro




-- THE mips register file

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;



entity mipsregisterfile is 
port(	clk	: in std_logic;
	enable	: in std_logic;
	rs	: in std_logic_vector(4 downto 0);
	rt	: in std_logic_vector(4 downto 0);
	rd	: in std_logic_vector(4 downto 0);
	datain	: in std_logic_vector(31 downto 0);
	read1	: out std_logic_vector(31 downto 0);
	read2	: out std_logic_vector(31 downto 0));
end mipsregisterfile;

architecture mixed of mipsregisterfile is


type register_array is array (31 downto 0) of std_logic_vector(31 downto 0);
signal registers : register_array := (others => (others => '0'));
signal decoded : std_logic_vector(31 downto 0);

component bigmux
port(sel	: in std_logic_vector(4 downto 0);
	in1		: in std_logic_vector(31 downto 0);
	in2		: in std_logic_vector(31 downto 0);
	in3		: in std_logic_vector(31 downto 0);
	in4		: in std_logic_vector(31 downto 0);
	in5		: in std_logic_vector(31 downto 0);
	in6		: in std_logic_vector(31 downto 0);
	in7		: in std_logic_vector(31 downto 0);
	in8		: in std_logic_vector(31 downto 0);
	in9		: in std_logic_vector(31 downto 0);
	in10		: in std_logic_vector(31 downto 0);
	in11		: in std_logic_vector(31 downto 0);
	in12		: in std_logic_vector(31 downto 0);
	in13		: in std_logic_vector(31 downto 0);
	in14		: in std_logic_vector(31 downto 0);
	in15		: in std_logic_vector(31 downto 0);
	in16		: in std_logic_vector(31 downto 0);
	in17		: in std_logic_vector(31 downto 0);
	in18		: in std_logic_vector(31 downto 0);
	in19		: in std_logic_vector(31 downto 0);
	in20		: in std_logic_vector(31 downto 0);
	in21		: in std_logic_vector(31 downto 0);
	in22		: in std_logic_vector(31 downto 0);
	in23		: in std_logic_vector(31 downto 0);
	in24		: in std_logic_vector(31 downto 0);
	in25		: in std_logic_vector(31 downto 0);
	in26		: in std_logic_vector(31 downto 0);
	in27		: in std_logic_vector(31 downto 0);
	in28		: in std_logic_vector(31 downto 0);
	in29		: in std_logic_vector(31 downto 0);
	in30		: in std_logic_vector(31 downto 0);
	in31		: in std_logic_vector(31 downto 0);
	in32		: in std_logic_vector(31 downto 0);
	output		: out std_logic_vector(31 downto 0));

end component;

component decoder532
port(input	: in std_logic_vector(4 downto 0);
	enable 		: in std_logic;
	output		: out std_logic_vector(31 downto 0));

end component;

begin
decoder_i: decoder532
	port map(input		=> rd,
		enable		=> enable,
		output		=> decoded);

bigmux1: bigmux
port map( sel	=> rs,
	output	=> read1,
	in1	=> registers(0),
	in2	=> registers(1),
	in3	=> registers(2),	
	in4	=> registers(3),
	in5	=> registers(4),
	in6	=> registers(5),	
	in7	=> registers(6),
	in8	=> registers(7),
	in9	=> registers(8),
	in10	=> registers(9),
	in11	=> registers(10),
	in12	=> registers(11),
	in13	=> registers(12),
	in14	=> registers(13),
	in15	=> registers(14),
	in16	=> registers(15),
	in17	=> registers(16),
	in18	=> registers(17),
	in19	=> registers(18),
	in20	=> registers(19),
	in21	=> registers(20),
	in22	=> registers(21),
	in23	=> registers(22),
	in24	=> registers(23),
	in25	=> registers(24),
	in26	=> registers(25),
	in27	=> registers(26),
	in28	=> registers(27),
	in29	=> registers(28),
	in30	=> registers(29),
	in31	=> registers(30),
	in32	=> registers(31));


bigmux2: bigmux
port map( sel	=> rt,
	output	=> read2,
	in1	=> registers(0),
	in2	=> registers(1),
	in3	=> registers(2),	
	in4	=> registers(3),
	in5	=> registers(4),
	in6	=> registers(5),	
	in7	=> registers(6),
	in8	=> registers(7),
	in9	=> registers(8),
	in10	=> registers(9),
	in11	=> registers(10),
	in12	=> registers(11),
	in13	=> registers(12),
	in14	=> registers(13),
	in15	=> registers(14),
	in16	=> registers(15),
	in17	=> registers(16),
	in18	=> registers(17),
	in19	=> registers(18),
	in20	=> registers(19),
	in21	=> registers(20),
	in22	=> registers(21),
	in23	=> registers(22),
	in24	=> registers(23),
	in25	=> registers(24),
	in26	=> registers(25),
	in27	=> registers(26),
	in28	=> registers(27),
	in29	=> registers(28),
	in30	=> registers(29),
	in31	=> registers(30),
	in32	=> registers(31));

process(clk)
begin
if(rising_edge(CLK))
then
	for i in 0 to 31 loop
		if (decoded(i) = '1') and (enable = '1') then
			registers(i) <= datain;
		end if;
	end loop;
end if;


end process;

end mixed;

















