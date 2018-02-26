library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_ram is
   port (
      CLK       : in std_logic;
      WRITE_ENA : in std_logic;
      ADDRES    : in my_bus_type;
      DATA_IN   : in my_bus_type;
      DATA_OUT  : out my_bus_type
   );
end entity;

architecture rtl of my_ram is
begin
end architecture;