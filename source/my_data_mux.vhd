-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_data_mux.vhd
--
-- Abstract: Simple mux for selecting the data on
--           data bus.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_data_mux is
   port (
      SEL  : in my_data_bus_sel_type;
      ALU  : in my_bus_type;
      MEM  : in my_bus_type;
      DATA_BUS : out my_bus_type
   );
end entity;

architecture rtl of my_data_mux is
begin
    with SEL select
        DATA_BUS <= ALU when SEL_D_ALU,
                    MEM when SEL_D_MEM,
                    (others => '0') when others;
end architecture;
