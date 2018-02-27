library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_data_mux is
   port (
      --CLK   : in std_logic; Remove?
      SEL  : in my_data_bus_sel_type;
      ALU  : in my_bus_type;
      MEM  : in my_bus_type;
      DATA_BUS : out my_bus_type
   );
end entity;

architecture rtl of my_data_mux is
begin
end architecture;