library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_control_unit is
   port (
      CLK             : in std_logic;
      RESET           : in std_logic; -- Reset memory also?
      ALU_GT          : in std_logic;
      ALU_Z           : in std_logic;
      LC_Z            : in std_logic;
      INSTRUCTION     : in my_bus_type;
      FETCH_CURRENT   : in std_logic;
      
      DATA_BUS_SEL    : out my_data_bus_sel_type;
      ADDR_BUS_SEL    : out my_addr_bus_sel_type;
      
      ALU_OPCODE      : out my_ALU_op_type;
      ALU_OP_ENA      : out std_logic;
      ALU_LD_ACC      : out std_logic;
      ALU_LD_TEMP     : out std_logic;
      
      LC_LD           : out std_logic;
      LC_DEC          : out std_logic;
      
      PC_INC          : out std_logic;
      PC_JMP_LD       : out std_logic;
      PC_JMP_ENA      : out std_logic;
      PC_JMP_BACKWARD : out std_logic;
      
      ADR1_LD         : out std_logic;
      ADR1_INC        : out std_logic;
      
      ADR2_LD         : out std_logic;
      ADR2_INC        : out std_logic;
      
      MEM_WRT_ENA     : out std_logic;
      
      FETCH_NEXT      : out std_logic
   );
end entity;

architecture rtl of my_control_unit is
begin
end architecture;