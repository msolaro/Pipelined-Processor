library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use work.register_array.all;

entity register_file is

	port(	i_CLK		: in std_logic;
		i_RST		: in std_logic;
		i_WE		: in std_logic;
		Data		: in std_logic_vector(31 downto 0);
		i_rs		: in std_logic_vector(4 downto 0);
		i_rt		: in std_logic_vector(4 downto 0);
		i_rd		: in std_logic_vector(4 downto 0);
		o_rs		: out std_logic_vector(31 downto 0);
		o_rt		: out std_logic_vector(31 downto 0));
		
end register_file;

architecture structural of register_file is

	component dff_32
  	port(	i_CLK        	: in std_logic;     
       		i_RST        	: in std_logic;     
       		i_WE         	: in std_logic;     
       		i_D          	: in std_logic_vector(31 downto 0);     
       		o_Q         	: out std_logic_vector(31 downto 0));   

	end component;

	component multiplexor_32_1 

  	port(	i_A  		: in registerArray;
       		i_Sel  		: in std_logic_vector(4 downto 0);
       		o_F  		: out std_logic_vector(31 downto 0));

	end component;

	component decoder_5_32 

	port(	i_A	: in std_logic_vector(4 downto 0);
	     	i_En	: in std_logic;
	     	o_B	: out std_logic_vector(31 downto 0));

	end component;

	signal o_Array	: registerArray; 
	signal o_rd	: std_logic_vector(31 downto 0);

	begin 

	read_multiplexor_32_1 : multiplexor_32_1

	port map(	i_A	=> o_Array,
			i_Sel	=> i_rt,
			o_F	=> o_rt);

	read_multiplexor_32_1_2 : multiplexor_32_1

	port map(	i_A	=> o_Array,
			i_Sel	=> i_rs,
			o_F	=> o_rs);
	
	reg_0 : dff_32
	
	port map(	i_CLK	=> i_CLK,
			i_RST	=> i_RST,
			i_WE	=> '0',
			i_D	=> Data,
			o_Q	=> o_Array(0));

	L1: for i in 1 to 31 generate

	reg_i : dff_32

	port map(	i_CLK	=> i_CLK,
			i_RST	=> i_RST,
			i_WE	=> i_WE,
			i_D	=> Data,
			o_Q	=> o_Array(i));

	end generate;

	
			
end structural;