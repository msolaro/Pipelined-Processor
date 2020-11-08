library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


entity dataforward_ex is
  port(EXMEM_RegWrite  : in  std_logic;
       MEMWB_RegWrite  : in  std_logic;
       EXMEM_Rd        : in  std_logic_vector(4 downto 0);
       MEMWB_Rd        : in  std_logic_vector(4 downto 0);
       rs              : in  std_logic_vector(4 downto 0);
       rt              : in  std_logic_vector(4 downto 0);
       rs_src          : out std_logic_vector(1 downto 0);
       rt_src          : out std_logic_vector(1 downto 0);
end dataforward_ex;

architecture behavior of dataforward_ex is
  begin
    process(EXMEM_RegWrite,EXMEM_Rd,MEMWB_Rd,MEMWB_RegWrite,rs,rt)
      begin
        --Default the signals
        rs_src  <= "00";
        rt_src<= "00";
          
        --Forward Rs hazard
        if((EXMEM_RegWrite = '1') and (Not(EXMEM_Rd = "00000")) and (EXMEM_Rd = rs)) Then
          rs_src <= "01";
        elsif ((MEMWB_RegWrite = '1') and (not(MEMWB_Rd = "00000")) and (MEMWB_Rd = rs)) Then
          rs_src <= "10";
        end if;
        
        --Forward Rt hazard
        if ((EXMEM_RegWrite = '1') and (not(EXMEM_Rd = "00000")) and (EXMEM_Rd = rt)) Then
          rt_src <= "01";
        elsif ((MEMWB_RegWrite = '1') and (not(MEMWB_Rd = "00000")) and (MEMWB_Rd = rt)) Then
          rt_src <= "10";
        end if;
		  
      end process; 
end behavior;
