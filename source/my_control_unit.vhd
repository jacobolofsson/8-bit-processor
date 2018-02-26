library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_control_unit is
   port (
      CLK : in std_logic;
      FETCH : in std_logic; -- only internal?
      ALU_GT : in std_logic;
      ALU_Z : in std_logic;
      LC_Z : in std_logic;
      
      ALU_LD_ACC : out std_logic;
      ALU_LD_TEMP : out std_logic;
      ALU_INC_ACC : out std_logic;
      ALU_OPCODE : out std_logic;
      
      PC_INC : out std_logic;
      PC_LD : out std_logic; -- Necessary?
      PC_JMP_LD : out std_logic;
      PC_OPCODE : out std_logic;
      
      ADR1_LD : out std_logic;
      ADR1_INC : out std_logic;
      
      ADR2_LD : out std_logic;
      ADR2_INC : out std_logic;
      
      LC_LD : out std_logic;
      LC_DEC : out std_logic;
      
      DATA_BUS_SEL : out my_data_bus_sel_type;
      ADDR_BUS_SEL : out my_data_bus_sel_type
   );
end entity;

architecture rtl of my_control_unit is
begin
end architecture;