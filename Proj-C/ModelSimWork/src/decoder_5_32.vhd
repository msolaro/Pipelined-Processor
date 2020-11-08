library IEEE;
use ieee.std_logic_1164.all;

entity decoder_5_32 is

	port(i_A	: in std_logic_vector(4 downto 0);
	     i_En	: in std_logic;
	     o_B	: out std_logic_vector(31 downto 0));

end decoder_5_32;

architecture behavioral of decoder_5_32 is

begin 

	proc1 : process(i_A,i_En) 

	begin

	o_B <= (others => '0');

	if(i_En = '1') then

		case (i_A) is

			when "00000" => o_B(0) <='1';
			when "00001" => o_B(1) <='1';
			when "00010" => o_B(2) <='1';
			when "00011" => o_B(3) <='1';
			when "00100" => o_B(4) <='1';
			when "00101" => o_B(5) <='1';
			when "00110" => o_B(6) <='1';
			when "00111" => o_B(7) <='1';
			when "01000" => o_B(8) <='1';
			when "01001" => o_B(9) <='1';
			when "01010" => o_B(10) <='1';
			when "01011" => o_B(11) <='1';
			when "01100" => o_B(12) <='1';
			when "01101" => o_B(13) <='1';
			when "01110" => o_B(14) <='1';			when "01111" => o_B(15) <='1';
			when "10000" => o_B(16) <='1';
			when "10001" => o_B(17) <='1';
			when "10010" => o_B(18) <='1';
			when "10011" => o_B(19) <='1';
			when "10100" => o_B(20) <='1';
			when "10101" => o_B(21) <='1';
			when "10110" => o_B(22) <='1';
			when "10111" => o_B(23) <='1';
			when "11000" => o_B(24) <='1';
			when "11001" => o_B(25) <='1';
			when "11010" => o_B(26) <='1';
			when "11011" => o_B(27) <='1';
			when "11100" => o_B(28) <='1';
			when "11101" => o_B(29) <='1';
			when "11110" => o_B(30) <='1';
			when "11111" => o_B(31) <='1';
			when others => o_B <= (others => '0');
		
		end case;

	end if;

	end process proc1;

end behavioral;