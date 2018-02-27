library ieee;
use ieee.std_logic_1164.all;

package my_package is
   constant REG_WIDTH : integer := 8;
   
   subtype my_bus_type is std_logic_vector(REG_WIDTH-1 downto 0);
   
   subtype my_ALU_op_type is std_logic_vector(3 downto 0);
   constant ALU_NOP : my_ALU_op_type := "0000";
   constant ALU_CMP : my_ALU_op_type := "0001";
   constant ALU_ADD : my_ALU_op_type := "0010";
   constant ALU_SUB : my_ALU_op_type := "0011";
   constant ALU_INC : my_ALU_op_type := "0100";
   constant ALU_DEC : my_ALU_op_type := "0101";
   constant ALU_RAL : my_ALU_op_type := "0110";
   constant ALU_RAR : my_ALU_op_type := "0111";
   constant ALU_SHL : my_ALU_op_type := "1000";
   constant ALU_SHR : my_ALU_op_type := "1001";
   
   subtype my_addr_bus_sel_type is std_logic_vector(1 downto 0);
   constant SEL_A_NOP : my_addr_bus_sel_type := "00";
   constant SEL_A_PC : my_addr_bus_sel_type := "01";
   constant SEL_A_ADR1 : my_addr_bus_sel_type := "10";
   constant SEL_A_ADR2 : my_addr_bus_sel_type := "11";
   
   subtype my_data_bus_sel_type is std_logic_vector(1 downto 0);
   constant SEL_D_NOP : my_data_bus_sel_type := "00";
   constant SEL_D_ALU : my_data_bus_sel_type := "01";
   constant SEL_D_RAM : my_data_bus_sel_type := "10";
   
   -- Opcodes:
   constant OP_LD_ADR1 : my_bus_type := b"0000_0001";
   constant OP_LD_ADR2 : my_bus_type := b"0000_0010";
   constant OP_LD_ACC : my_bus_type := b"0000_0011";
   constant OP_LD_TEMP : my_bus_type := b"0000_0100";
end package;