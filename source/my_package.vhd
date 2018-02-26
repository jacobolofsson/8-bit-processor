library ieee;
use ieee.std_logic_1164.all;

package my_package is
   constant REG_WIDTH : integer := 8;
   
   subtype my_bus_type is std_logic_vector(REG_WIDTH-1 downto 0);
   type my_pc_op_type is (forward, backward);
   type my_ALU_op_type is (CMP, ADD, SUB, INC, DEC, RAL, RAR, SHL, SHR);
   type my_addr_bus_sel_type is (PC, ADR1, ADR2); -- Quartus doesnt support type
   type my_data_bus_sel_type is (ALU, RAM); -- Default value?
end package;