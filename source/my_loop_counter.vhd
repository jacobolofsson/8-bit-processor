library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.my_package.all;

entity my_loop_counter is
   port (
      CLK             : in std_logic;
      LD_LOOP_VALUE   : in std_logic;
      DEC_LOOP_VALUE  : in std_logic;
      NEW_LOOP_VALUE  : in my_bus_type;
      LOOP_VALUE_ZERO : out std_logic
   );
end entity;

architecture rtl of my_loop_counter is
   signal loop_counter : unsigned(REG_WIDTH-1 downto 0) := (others => '1');
begin
   process (CLK)
   begin
      if rising_edge(CLK) then
         if LD_LOOP_VALUE = '1' then
            loop_counter <= unsigned(NEW_LOOP_VALUE);
         end if;
         if DEC_LOOP_VALUE = '1' then
            loop_counter <= loop_counter -1;
         end if;
     end if;
   end process;
   
   LOOP_VALUE_ZERO <= '1' when loop_counter = 0 else
                      '0';
end architecture;