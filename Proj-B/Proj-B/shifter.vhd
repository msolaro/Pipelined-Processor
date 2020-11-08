-- Max Solaro




-- Shifter








library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- use that, it's a better coding guideline


entity shifter is
generic(N : integer := 32);
  port(input		: in std_logic_vector(N-1 downto 0);
	--shiftcontrol	: in std_logic_vector(2 downto 0);
	shamt		: in std_logic_vector(4 downto 0);
        output 		: out std_logic_vector(N-1 downto 0));

end shifter;



architecture structural of shifter is

component twocmux
	port(source	: in std_logic;
		A	: in std_logic_vector(N-1 downto 0);
		B	: in std_logic_vector(N-1 downto 0);
		output	: out std_logic_vector(N-1 downto 0));

end component;

signal test		: std_logic_vector(N-1 downto 0);
signal onebitshift	: std_logic_vector(N-1 downto 0);
signal twobitshift	: std_logic_vector(N-1 downto 0);
signal fourbitshift	: std_logic_vector(N-1 downto 0);
signal eightbitshift	: std_logic_vector(N-1 downto 0);
--signal sixteenbitshift	: std_logic_vector(N-1 downto 0);
--signal source 		: std_logic;
--
signal muxtwo		: std_logic_vector(N-1 downto 0);
signal muxthree		: std_logic_vector(N-1 downto 0);
signal muxfour		: std_logic_vector(N-1 downto 0);
signal muxfive		: std_logic_vector(N-1 downto 0);

begin
--test <= shift_right(signed(input),1);
--source <= shamt(0);


test <= '0' & input(31 downto 1);


firstshift: twocmux
	Port map(A	=> input,
		B	=> test,
		source	=> shamt(0),
		output	=> onebitshift);



--source <= shamt(1);
 --<= "00" & input(N-1 downto 2);


muxtwo <= "00" & onebitshift(N-1 downto 2);
secondshift: twocmux
	Port map(A	=> onebitshift,
		B	=> muxtwo,
		source	=> shamt(1),
		output	=> twobitshift);

--source <= shamt(2);
--test <= "0000" & input(N-1 downto 4);
muxthree <= "0000" & twobitshift(N-1 downto 4);
thirdshift: twocmux
	Port map(A	=> twobitshift,
		B	=> muxthree,
		source	=> shamt(2),
		output	=> fourbitshift);

--source <= shamt(3);
--test <= "00000000" & input(N-1 downto 8);
muxfour <= "00000000" & fourbitshift(N-1 downto 8);
fourthshift: twocmux
	Port map(A	=> fourbitshift,
		B	=> muxfour,
		source	=> shamt(3),
		output	=> eightbitshift);


--source <= shamt(4);
--test <= "0000000000000000" & input(N-1 downto 16);
muxfive <= "0000000000000000" & eightbitshift(N-1 downto 16);
fifthshift: twocmux
	Port map(A	=> eightbitshift,
		B	=> muxfive,
		source	=> shamt(4),
		output	=> output);
end structural;