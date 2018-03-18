-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_RAM.vhd
--
-- Abstract: A bi-directional RAM for use with the
--           CPU.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.my_package.all;

entity my_ram is
   port (
      CLK       : in std_logic;
      RESET     : in std_logic;
      ADDRESS   : in my_bus_type;
      DATA_IN   : in my_bus_type;
      WRITE_ENA : in std_logic;
      DATA_OUT  : out my_bus_type
   );
end entity;

architecture rtl of my_ram is
   --Change DEFAULT_MEMORY to change the program that is loaded at start/rst
   constant DEFAULT_MEMORY : my_mem_type := TEST_PROGRAM_1; 
   signal memory_array : my_mem_type := DEFAULT_MEMORY;
begin
   DATA_OUT <= memory_array( conv_integer(ADDRESS) );
   process (CLK, WRITE_ENA, RESET)
   begin
      if RESET = RST_VAL then
         memory_array <= DEFAULT_MEMORY;
      elsif rising_edge(CLK) and (WRITE_ENA = '1') then
         memory_array( conv_integer(ADDRESS) ) <= DATA_IN;
      end if;
   end process;
end architecture;
