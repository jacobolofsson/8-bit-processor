library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_loop_counter is
   port (
      CLK             : in std_logic;
      LD_LOOP_VALUE   : in std_logic;
      DEC_LOOP_VALUE  : in std_logic;
      NEW_LOOP_VALUE  : in my_bus_type;
      LOOP_VALUE_ZERO : out std_logic
   );
end entity;

architecture rtl of my_loop_counter is
begin
end architecture;