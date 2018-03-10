-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_address_register.vhd
--
-- Abstract: The address register keeps an 
--           address stored.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.my_package.all;

entity my_address_register is
   port (
      CLK         : in std_logic;
      RESET       : in std_logic;
      INC_ADDRESS : in std_logic;
      LD_ADDRESS  : in std_logic;
      NEW_ADDRESS : in my_bus_type;
      OUT_ADDRESS : out my_bus_type
   );
end entity;

architecture rtl of my_address_register is
   signal current_address : unsigned(REG_WIDTH-1 downto 0) := (others => '0');
begin
   process (CLK, RESET)
   begin
      if RESET = RST_VAL then
         current_address <= (others => '0');
      elsif rising_edge(CLK) then
         if INC_ADDRESS = '1' then
            current_address <= current_address + 1;
         elsif LD_ADDRESS = '1' then
            current_address <= unsigned(NEW_ADDRESS);
         end if;
      end if;
   end process;

   OUT_ADDRESS <= std_logic_vector(current_address);

end architecture;
