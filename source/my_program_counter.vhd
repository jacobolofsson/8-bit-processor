library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_program_counter is
   port (
      CLK           : in std_logic;
      INC_PC        : in std_logic;
      LD_PC         : in std_logic;
      LD_JMP_VALUE  : in std_logic;
      JMP_ENA       : in std_logic;
      JMP_BACKWARD  : in std_logic;
      NEW_JMP_VALUE : in my_bus_type;
      OUT_PC        : out my_bus_type
   );
end entity;

architecture rtl of my_program_counter is
begin
end architecture;