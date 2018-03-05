library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.my_package.all;

entity my_ram is
   port (
      CLK       : in std_logic;
      ADDRESS   : in my_bus_type;
      DATA_IN   : in my_bus_type;
      WRITE_ENA : in std_logic;
      DATA_OUT  : out my_bus_type
   );
end entity;

architecture rtl of my_ram is
   constant MEMORY_DEPTH : integer := 8;
   type mem_array_type is array( (2**MEMORY_DEPTH - 1) downto 0 ) of my_bus_type;
   signal memory_array : mem_array_type := ( others => (others => '0') );
begin
   DATA_OUT <= memory_array( conv_integer(ADDRESS) );
   process (clk)
   begin
      if rising_edge(CLK) and (WRITE_ENA = '1') then
         memory_array( conv_integer(ADDRESS) ) <= DATA_IN;
      end if;
   end process;
end architecture;