library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hazard_unit is
  port(	idex_MemRead       	: in std_logic_vector(4 downto 0);
		idex_RegRt			: in std_logic_vector(4 downto 0);
		ifid_RegRs			: in std_logic_vector(4 downto 0);
		ifid_RegRt			: in std_logic_vector(4 downto 0);
		pc_enable			: out std_logic;
		muxonReg			: out std_logic;
		ifid_enable			: out std_logic);
end hazard_unit;

architecture behavior of hazard_unit is
signal eq0 : std_logic;
signal eq1 : std_logic;
signal eq2 : std_logic;
signal stall: std_logic;
begin
  process(idex_MemRead)
  begin
    if(idex_MemRead = '1') then
	   eq0 <= '1';
	 else
	   eq0 <= '0';
	 end if;
	end process;
  process(idex_RegRt, ifid_RegRs)
  begin
    if(idex_RegRt = ifid_RegRs) then
	   eq1 <= '1';
	 else
	   eq1 <= '0';
	 end if;
	end process;
	process(idex_RegRt,ifid_RegRt)
	begin
	  if(idex_RegRt = ifid_RegRt) then
	    eq2 <= '1';
	  else
	    eq2 <= '0';
	  end if;
   end process;
	stall <= ((eq1 or eq2) and eq0);
	
	pc_enable<=stall;
	muxonReg<=stall;
	ifid_enable<=stall;
end behavior;
