library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
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
   signal current_address : unsigned(REG_WIDTH-1 downto 0) := (others => '0');
begin
   process (CLK)
   begin
      if rising_edge(CLK) then
         if INC_ADDRESS = '1' then
            current_address <= current_address + 1;
         elsif LD_ADDRESS = '1' then
            current_address <= unsigned(NEW_ADDRESS);
         end if;
      end if;
   end process;

   OUT_ADDRESS <= std_logic_vector(current_address);

end architecture;