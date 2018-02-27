library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_address_register is
   port (
      CLK         : in std_logic;
      INC_ADDRESS : in std_logic;
      LD_ADDRESS  : in std_logic;
      NEW_ADDRESS : in my_bus_type;
      OUT_ADDRESS : out my_bus_type
   );
end entity;

architecture rtl of my_address_register is
begin
end architecture;