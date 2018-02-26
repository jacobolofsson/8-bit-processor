library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_addr_mux is
   port (
      CLK   : in std_logic;
      PC    : in my_bus_type;
      ADR1  : in my_bus_type;
      ADR2  : in my_bus_type;
      SEL   : in my_addr_bus_sel_type;
      ADDR_BUS : out my_bus_type
   );
end entity;

architecture rtl of my_addr_mux is
begin
end architecture;