library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_ALU is
   port (
      CLK       : in std_logic;
      OPERATION : in my_ALU_op_type;
      OP_ENA    : in std_logic;
      LD_ACC    : in std_logic;
      LD_TMP    : in std_logic;
      INC_ACC   : in std_logic;
      NEW_ACC   : in my_bus_type;
      NEW_TMP   : in my_bus_type;
      RESULT    : out my_bus_type;
      RES_GT    : out std_logic;
      RES_Z     : out std_logic
   );
end entity;

architecture rtl of my_ALU is
begin
end architecture;