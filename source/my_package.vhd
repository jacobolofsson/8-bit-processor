library ieee;
use ieee.std_logic_1164.all;

package my_package is
   constant REG_WIDTH : integer := 8;
   
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
   constant OP_LD_ACC2    : my_bus_type := b"0000_1000";
   
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
end package;
