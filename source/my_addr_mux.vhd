-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_addr_mux.vhd
--
-- Abstract: Simple mux for selecting the data on
--           address bus.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_addr_mux is
   port (
      SEL   : in my_addr_bus_sel_type;
      PC    : in my_bus_type;
      ADR1  : in my_bus_type;
      ADR2  : in my_bus_type;
      ADDR_BUS : out my_bus_type
   );
end entity;

architecture rtl of my_addr_mux is
begin
    with SEL select
        ADDR_BUS <= PC   when SEL_A_PC,
                    ADR1 when SEL_A_ADR1,
                    ADR2 when SEL_A_ADR2,
                    (others => '0') when others;
end architecture;
