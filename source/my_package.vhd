-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_package.vhd
--
-- Abstract: Constants and types for the project 
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package my_package is
   constant REG_WIDTH : integer := 8;
   
   constant RST_VAL : std_logic := '0';
   
   subtype my_bus_type is std_logic_vector(REG_WIDTH-1 downto 0);
   
   -- Operation select signal for the ALU
   subtype my_ALU_op_type is std_logic_vector(3 downto 0);
   constant ALU_NOP : my_ALU_op_type := "0000";
   constant ALU_ADD : my_ALU_op_type := "0001";
   constant ALU_SUB : my_ALU_op_type := "0010";
   constant ALU_INC : my_ALU_op_type := "0011";
   constant ALU_DEC : my_ALU_op_type := "0100";
   constant ALU_RAL : my_ALU_op_type := "0101";
   constant ALU_RAR : my_ALU_op_type := "0110";
   constant ALU_SHL : my_ALU_op_type := "0111";
   constant ALU_SHR : my_ALU_op_type := "1000";
   
   -- Select signal for address-bus
   subtype my_addr_bus_sel_type is std_logic_vector(1 downto 0);
   constant SEL_A_NOP  : my_addr_bus_sel_type := "00";
   constant SEL_A_PC   : my_addr_bus_sel_type := "01";
   constant SEL_A_ADR1 : my_addr_bus_sel_type := "10";
   constant SEL_A_ADR2 : my_addr_bus_sel_type := "11";
   
   -- Select signal for data-bus
   subtype my_data_bus_sel_type is std_logic_vector(1 downto 0);
   constant SEL_D_NOP : my_data_bus_sel_type := "00";
   constant SEL_D_ALU : my_data_bus_sel_type := "01";
   constant SEL_D_MEM : my_data_bus_sel_type := "10";
   
   -- Opcodes:
   constant OP_NOP        : my_bus_type := b"0000_0000";
   -- Opcodes: Memory related instructions
   constant OP_LD_ADR1    : my_bus_type := b"0000_0001";
   constant OP_LD_ADR2    : my_bus_type := b"0000_0010";
   constant OP_LD_ACC     : my_bus_type := b"0000_0011";
   constant OP_LD_TEMP    : my_bus_type := b"0000_0100";
   constant OP_LD_LC      : my_bus_type := b"0000_0101";
   constant OP_LD_JUMPREG : my_bus_type := b"0000_0110";
   constant OP_ST_ACC1    : my_bus_type := b"0000_0111";
   constant OP_ST_ACC2    : my_bus_type := b"0000_1000";
   
   -- Opcodes: Jump and adress modifications
   constant OP_JPF        : my_bus_type := b"0000_1001";  
   constant OP_JPB        : my_bus_type := b"0000_1010";   
   constant OP_JPF_G      : my_bus_type := b"0000_1011";
   constant OP_JPB_G      : my_bus_type := b"0000_1100";
   constant OP_JPF_Z      : my_bus_type := b"0000_1101";
   constant OP_JPB_Z      : my_bus_type := b"0000_1110";
   constant OP_JPF_LC     : my_bus_type := b"0000_1111";
   constant OP_JPB_LC     : my_bus_type := b"0001_0000";
   constant OP_INC_ADR1   : my_bus_type := b"0001_0001";
   constant OP_INC_ADR2   : my_bus_type := b"0001_0010";
   
   -- Opcodes: Arithmetic instructions
   constant OP_CMP        : my_bus_type := b"0001_0011";
   constant OP_ADD        : my_bus_type := b"0001_0100";
   constant OP_SUB        : my_bus_type := b"0001_0101";
   constant OP_INC        : my_bus_type := b"0001_0110";
   constant OP_DEC        : my_bus_type := b"0001_0111";
   constant OP_RAL        : my_bus_type := b"0001_1000";
   constant OP_RAR        : my_bus_type := b"0001_1001";
   constant OP_SHL        : my_bus_type := b"0001_1010";
   constant OP_SHR        : my_bus_type := b"0001_1011";
   
   -- Memory types and constants
   constant MEMORY_DEPTH : integer := 8;
   type my_mem_type is array( (2**MEMORY_DEPTH - 1) downto 0 ) of my_bus_type;
   
   constant EMPTY_MEMORY : my_mem_type := ( others => (others => '0') );
   constant TEST_PROGRAM_1 : my_mem_type := (
      -- A = B + C
      0      => OP_LD_ADR1, --ADR1 = &B 
      1      => X"FB",      --&B
      2      => OP_LD_ADR2, --ADR2 = &C
      3      => X"FC",      --&C
      4      => OP_LD_ACC,  --ACC = B
      5      => OP_LD_TEMP, --TMP = C
      6      => OP_ADD,     --ACC = ACC+TMP = B+C
      7      => OP_LD_ADR1, --ADR1 = &A
      8      => X"FA",      --&A
      9      => OP_ST_ACC1, --A = ACC = B+C
      -- End of program memory
      10     => OP_LD_JUMPREG, --Start of infinite loop
      11     => X"01",
      12     => OP_JPB,        --End of infinite loop
      -- Start of data memory
      16#FB# => X"07",      --B
      16#FC# => X"05",      --C
      others => OP_NOP
   );
      
   constant TEST_PROGRAM_2 : my_mem_type := (
      -- IF A >= 0 THEN B = C (A > 0)
       0     => OP_LD_ADR1, --ADR1 = &0
       1     => X"F0",      --&0
       2     => OP_LD_ACC,  --ACC = 0
       3     => OP_LD_ADR2, --ADR2 = &A
       4     => X"FA",      --&A
       5     => OP_LD_TEMP, --TMP = A
       6     => OP_LD_JUMPREG, --JMPREG = 6
       7     => X"06",
       8     => OP_CMP,     --0 > A
       9     => OP_JPF_G,   -- Jump if >
       10    => OP_LD_ADR1, --ADR1 = &C
       11    => X"FC",      --&C
       12    => OP_LD_ADR2, --ADR2 = &B
       13    => X"FB",      --&B
       14    => OP_LD_ACC,  --ACC = C
       15    => OP_ST_ACC2, --B = ACC = C
      -- End of program memory
       16    => OP_LD_JUMPREG, --Start of infinite loop
       17    => X"01",
       18    => OP_JPB,        --End of infinite loop
      -- Start of data memory
      16#F0# => X"00",      --0
      16#FA# => X"07",      --A
      16#FB# => X"07",      --B
      16#FC# => X"05",      --C
      others => OP_NOP
   );
   
   constant TEST_PROGRAM_3 : my_mem_type := (
      -- IF A >= 0 THEN B = C (A < 0)
       0     => OP_LD_ADR1, --ADR1 = &0
       1     => X"F0",      --&0
       2     => OP_LD_ACC,  --ACC = 0
       3     => OP_LD_ADR2, --ADR2 = &A
       4     => X"FA",      --&A
       5     => OP_LD_TEMP, --TMP = A
       6     => OP_LD_JUMPREG, --JMPREG = 6
       7     => X"06",
       8     => OP_CMP,     --0 > A
       9     => OP_JPF_G,   --Jump if >
       10    => OP_LD_ADR1, --ADR1 = &C
       11    => X"FC",      --&C
       12    => OP_LD_ADR2, --ADR2 = &B
       13    => X"FB",      --&B
       14    => OP_LD_ACC,  --ACC = C
       15    => OP_ST_ACC2, --B = ACC = C
      -- End of program memory
       16    => OP_LD_JUMPREG, --Start of infinite loop
       17    => X"01",
       18    => OP_JPB,        --End of infinite loop
      -- Start of data memory
      16#F0# => X"00",      --0
      16#FA# => X"F7",      --A
      16#FB# => X"07",      --B
      16#FC# => X"05",      --C
      others => OP_NOP
   );
end package;
