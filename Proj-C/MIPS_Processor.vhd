-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- USED-- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- USED--TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- USED--TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; --DONE-- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- USED-- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); --DONE-- TODO: use this signal as the final data memory data input


  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal v0             : std_logic_vector(N-1 downto 0); -- TODO: should be assigned to the output of register 2, used to implement the halt SYSCALL
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. This case happens when the syscall instruction is observed and the V0 register is at 0x0000000A. This signal is active high and should only be asserted after the last register and memory writes before the syscall are guaranteed to be completed.


  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

  signal s_Read_data1	: std_logic_vector(31 downto 0); --USED-- this signal carries readdata1 from reg file to alu
  signal s_NEXTPC		: std_logic_vector(31 downto 0);
  signal s_NEXTPC2		: std_logic_vector(31 downto 0);
  signal s_aluIn1		: std_logic_vector(31 downto 0);

	-- signals for control unit
  signal s_aluControl 	: std_logic_vector(3 downto 0);
  signal s_ALUSrc	: std_logic;
  signal s_MemToReg	: std_logic; --done
  --signal sig_S_DMemWr 	: std_logic; given to us by ZAMBRENO
  signal s_RegDst	: std_logic;
  signal s_branch	: std_logic;-------------------------------------------------------
  signal s_jump		: std_logic;---------------------------------------------
 -- signal s_func		: std_logic_vector(5 downto 0); s_instr(6 downto 0)
-- opcode
 
  signal s_extended	: std_logic_vector(31 downto 0);
  signal s_add2out	: std_logic_vector(31 downto 0);----------------------------------
  signal mux2mux	: std_logic_vector(31 downto 0);---------------------------------
  signal jumpaddress	: std_logic_vector(31 downto 0);----------------------------------
  signal s_pcvalue	: std_logic_vector(31 downto 0);

 -- ALU SIGNALS
  signal s_preALUmux	: std_logic_vector(N-1 downto 0);
  signal s_ALUmainout	: std_logic_vector(N-1 downto 0);
  signal s_zero			: std_logic;
  signal s_C 			: std_logic;
  signal s_andout 		: std_logic;

  signal s_alushift	: std_logic_vector(31 downto 0);----------------------------------
  signal newjump	: std_logic_vector(31 downto 0);----------------------------------
  signal s_ra 		: std_logic;
  signal s_jalguy	: std_logic_vector(4 downto 0);
  signal s_jalwrite	: std_logic_vector(31 downto 0);
  signal s_PC		: std_logic;
  signal temp_pc	: std_logic_vector(31 downto 0);
  signal lui_extend	: std_logic_vector(31 downto 0);
  signal lui_temp	: std_logic_vector(31 downto 0);
  signal s_lui		: std_logic;
  signal s_lw		: std_logic;
  signal s_addrImm	: std_logic_vector(31 downto 0);
  signal s_zero2	: std_logic;
  signal shifting 	: std_logic;
  --control unit
component controlunit
port( OPcode		: in std_logic_vector(5 downto 0);
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


--register file
component mipsregisterfile
port(	clk	: in std_logic;
	--i_RST	: in std_logic;
	enable	: in std_logic;
	rs	: in std_logic_vector(4 downto 0);
	rt	: in std_logic_vector(4 downto 0);
	rd	: in std_logic_vector(4 downto 0);
	Datain	: in std_logic_vector(31 downto 0);
	read1	: out std_logic_vector(31 downto 0);
	read2	: out std_logic_vector(31 downto 0));
end component;

--alu
component alushift
 port(inputA		: in std_logic_vector(N-1 downto 0);
	inputB		: in std_logic_vector(N-1 downto 0);
	shiftcontrol	: in std_logic_vector(1 downto 0); -- i dont think shift control does anything anymore. integrated into alu control
	--carryin		: in std_logic;
	shamt		: in std_logic_vector(4 downto 0);
	alucontrol	: in std_logic_vector(3 downto 0);
  	output	 	: out std_logic_vector(N-1 downto 0);
	overflow	: out std_logic;
	zero		: out std_logic);
end component;

-- 32 bit 2 to 1 mux -- generic?
component twocmux
  port(source  : in std_logic;
	A	: in std_logic_vector(N-1 downto 0);
	B	: in std_logic_vector(N-1 downto 0);
       output  : out std_logic_vector(N-1 downto 0));
end component;

component twodmux
  port(source  : in std_logic;
	A	: in std_logic_vector(4 downto 0);
	B	: in std_logic_vector(4 downto 0);
       output  : out std_logic_vector(4 downto 0));
end component;

--shift left
component shiftleft -- needs generic?
  port(input		: in std_logic_vector(N-1 downto 0);
	shamt		: in std_logic_vector(4 downto 0); -- just make this =2
        output 		: out std_logic_vector(N-1 downto 0));
end component;

component signextender 
port(input	 : in	std_logic_vector(16-1 downto 0);
	output	: out	std_logic_vector(32-1 downto 0));
end component;

component FullAdderStructural
 port(i_A  : in std_logic_vector(N-1 downto 0);
	i_B  : in std_logic_vector(N-1 downto 0);
	i_C  : in std_logic;
        o_C  : out std_logic;
        o_S  : out std_logic_vector(N-1 downto 0));
end component;

component xorg2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;



-------------- TODO needs-------------------------------------
--
-- PC?
component nbitregister
  port(CLK  : in std_logic;
	i_RST	: in std_logic;
	i_WE	: in std_logic;
	data	: in std_logic_vector(N-1 downto 0);
       output  : out std_logic_vector(N-1 downto 0));
end component;

component andg2
port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

begin

--nextadd: process(iRST)	
--begin-- if i_RST ==1 s_NextINstADDr == 400000(hex) else if rising edge of clk then next instr == jump
--if (iRST = '1')
-- then s_NextInstAddr <= x"00400000";
-- elsif(rising_edge(iCLK))
--- then 
--end if;
--end process;

--take from jump

setv0: process(v0, s_RegWrAddr, s_DMemData, s_RegWr, iCLK)
begin
    if((rising_edge(iCLK) AND (s_RegWrAddr = "00010")) and (s_RegWr = '1'))
        then v0 <= s_RegWrData;
    end if;
end process;



  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2), -- 11 down to 0
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);
 -- TODO: Implement the rest of your processor below this comment!

DMemMux: twocmux -- the mux after dmem that determines if alu result or Dmem data goes
  port map(	source  => s_MemToReg, --control signal
		A	=> s_DMemAddr, -- data from dmem
		B	=> s_DMemOut, -- comes from alu
    		output  => s_jalwrite); -- goes to datain register file

  RegisterFile: mipsregisterfile
  port map(	clk	=> iCLK,
		--i_rst	=> irst,
		enable	=> s_RegWr,
		rs	=> s_Inst(25 downto 21),
		rt	=> s_Inst(20 downto 16),
		rd	=> s_RegWrAddr,
		Datain	=> s_RegWrData, -- comes from DMemMux
		read1	=> s_Read_data1,
		read2	=> s_DMemData);



  writeRegMux: twodmux
  port map(	source  => s_RegDst, --control signal
		A	=> s_Inst(20 downto 16),
		B	=> s_Inst(15 downto 11),
    		output  => s_jalguy); --write register address

  
  
  preALUmux: twocmux
  port map(	source  => s_ALUSrc, --control unit
		A	=> s_DMemData,
		B	=> s_extended,--sign extender output	
    		output  => s_preALUmux); -- goes to alu
  
 ALU: alushift
 port map(inputA	=> s_aluIn1,
	inputB		=> s_preALUmux,
	shiftcontrol	=> s_aluControl(3 downto 2), -- comes from aluop i think
	--carryin		=> '0', ---------------TODO-------not sure what to do with this
	shamt		=> s_Inst(10 downto 6), -- part of the instruction
	alucontrol	=> s_aluControl, --control signal
  	output	 	=> s_ALUmainout, -- main alu output
	--overflow	=> '0',------------TODO-------- idk bout this one
	zero		=> s_zero); -- make a signal cal it zero?


	oALUOut <= s_ALUmainout; -----------------TODO must set aluout = output


 control: controlunit
 port map( 	OPcode		=> s_Inst(31 downto 26),
		Func		=> s_Inst(5 downto 0), -- func determines s_alucontrol and other stuff
		aluControl 	=> s_aluControl,
		ALUSrc		=> s_ALUsrc,
		MemToReg	=> s_MemToReg,
      		S_DMemWr 	=> s_DMemWr,
		s_regWr		=> s_RegWr,
		RegDst		=> s_RegDst,
		jump		=> s_jump,
		branch		=> s_branch,
		ra			=> s_ra,
		pc			=> s_pc,
		luiboi		=> s_lui,
		lw			=> s_lw);

 Extender: signextender
port map( 	input		=> s_Inst(15 downto 0),
		output		=> s_extended);

 adder1 : FullAdderStructural
 port map(i_A  		=> s_NextInstAddr,------------------------------------------------TODO--------- PC counter,
	i_B		=> "00000000000000000000000000000100", -- not sure if thatll work
	i_C		=> '0', -- not sure if itll work
        O_C  	=> s_C, --also not sure
        O_S   		=> s_pcvalue);
		 
PC : nbitregister
  port map(CLK		=> iCLK,
	i_RST		=> iRST,
	i_WE		=>  '1',
	data		=> s_NEXTPC2,
       output  		=> s_NextInstAddr);
	   
branchand: andg2
port map(i_A          => s_zero2,
       i_B            => s_branch,
       o_F            => s_andout);

adder2 : FullAdderStructural
 port map(i_A  		=> s_pcvalue,
			i_B		=> s_alushift, -- not sure if thatll work
			i_C		=> '0', -- , -- not sure if itll work
			--o_C  	=> '0', --also not sure
			o_S   		=> s_add2out);
		

 pcShift : shiftleft
port map (input		=> s_Inst,
	shamt		=> "00010",
        output 		=> jumpaddress); --- connect jump address with s_PCadded[31-28]

Shiftextend : shiftleft
port map (input		=> s_extended,
	shamt		=> "00010",
        output 		=> s_alushift);

--2 mux guys
 addmux1: twocmux
 port map(	source  => s_andout,------------------------ -----TODO doesnt exist yet, --control unit
		A	=> s_pcvalue,---------output of the first adder,
		B	=> s_add2out,----------output of the second adder
  		output  => mux2mux); -- goes to second mux
--
addmux2: twocmux
 port map(	source  => s_jump,
		A	=> mux2mux,--jump address plus pc?
		B	=> newjump,----------output of the second adder
   		output  => temp_pc);--------------new pc value----------); -- goes to second mux

jalmux: twodmux
 port map(	source  => s_ra,
		A	=> s_jalguy, -- connects 
		B	=> b"11111",----------output of the second adder
  		output  => s_RegWrAddr); -- goes to second mux
		
jalwritemux: twocmux
 port map(	source  => s_ra,
		A	=> s_jalwrite,--jump address plus pc?
		B	=> mux2mux,----------output of the second adder
   		output  => s_RegWrData);--------------new pc value----------); -- goes to second mux
		
jrmux: twocmux
 port map(	source  => s_pc,--if we are ra then
		A	=> temp_pc,--jump address plus pc?
		B	=> s_jalwrite,-- if 1 then next instruction = ra
   		output  => s_NEXTPC);--------------new pc value----------); -- goes to second mux

luiShift : shiftleft
port map (input		=> s_preALUmux,
	shamt		=> "10000",
        output 		=> lui_extend); --- connect jump address with s_PCadded[31-28]
		
luimux: twocmux
 port map(	source  => s_lui,
		A	=> s_ALUmainout,
		B	=> lui_extend,-- 
   		output  => s_DMemAddr);--------------new pc value----------); -- goes to second mux
		
		
shiftingmux:	twocmux
port map( source	=> shifting,
		A			=> s_Read_data1,--- read_data1
		B			=>s_DMemData,--read data2
		output		=> s_aluIn1);-- alu in 1
		
		
resetmux:	twocmux
port map( source	=> irst,
		A			=> s_NEXTPC, -- if rst = 0 nothing
		B			=> x"00400000",--else 
		output		=> s_NEXTPC2);-- alu in 1
		
	

s_addrImm <= "000000000000000000000000000" & s_Inst(25 downto 21);
shifting <= s_aluControl(3);
-- whats left TODO
-- 1. Make a pc
-- 2. pc wires
-- 3. update control unit to support branch and jump
-- 4. and gate for zero and branhc --- why are we anding zero with branch? zero = 0???

bnexor: xorg2
  port map(i_A       =>   s_zero,
       i_B          => s_RegDst,
       o_F          => s_zero2);



  newjump <= s_pcvalue(31 downto 28) & jumpaddress(27 downto 0);
  s_Halt <='1' when (s_Inst(31 downto 26) = "000000") and (s_Inst(5 downto 0) = "001100") and (v0 = "00000000000000000000000000001010") else '0';

  
  
  

end structure;
