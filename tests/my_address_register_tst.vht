library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_address_register_TST is
end entity;

architecture test of my_address_register_TST is
   component my_address_register 
      port (
         CLK         : in std_logic;
         INC_ADDRESS : in std_logic;
         LD_ADDRESS  : in std_logic;
         NEW_ADDRESS : in my_bus_type;
         OUT_ADDRESS : out my_bus_type
      );
   end component;

   signal CLK         : std_logic := '0';
   signal INC_ADDRESS : std_logic := '0';
   signal LD_ADDRESS  : std_logic := '0';
   signal NEW_ADDRESS : my_bus_type := "11110000";
   signal OUT_ADDRESS : my_bus_type;

   constant CLK_PERIOD : time := 50 ns;
begin
   CLK <= not CLK after CLK_PERIOD/2;

   dut : my_address_register
   port map (
      CLK         => CLK,
      INC_ADDRESS => INC_ADDRESS,
      LD_ADDRESS  => LD_ADDRESS,
      NEW_ADDRESS => NEW_ADDRESS,
      OUT_ADDRESS => OUT_ADDRESS
   );
   
   stimuli : process
   begin
      wait for CLK_PERIOD*2;
      assert OUT_ADDRESS = "00000000"
      report "Starting address /= 0000_0000"
      severity error;

      INC_ADDRESS <= '1';

      wait for CLK_PERIOD;
      assert OUT_ADDRESS = "00000001"
      report "Address not incremented 1 step when INC_ADDRESS = 1"
      severity error;

      INC_ADDRESS <= '0';
      LD_ADDRESS <= '1';

      wait for CLK_PERIOD;
      assert OUT_ADDRESS = "11110000"
      report "Load address not working"
      severity error;

      LD_ADDRESS <= '0';
      NEW_ADDRESS <= "10101010";
      
      wait for CLK_PERIOD;
      assert OUT_ADDRESS = "11110000"
      report "Address updating when LD and INC = 0"
      severity error;

      wait;
   end process;
end architecture;
