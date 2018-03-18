library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_RAM_TST is
end entity;

architecture test of my_RAM_TST is

    component my_ram
        port (
          CLK       : in std_logic;
          RESET     : in std_logic;
          WRITE_ENA : in std_logic;
          ADDRESS   : in my_bus_type;
          DATA_IN   : in my_bus_type;
          DATA_OUT  : out my_bus_type
        );
    end component;

    signal CLK       : std_logic := '0';
    signal RESET     : std_logic;
    signal WRITE_ENA : std_logic := '0';
    signal ADDRESS   : my_bus_type := "00001111";
    signal DATA_IN   : my_bus_type := "10101010";
    signal DATA_OUT  : my_bus_type;

    constant CLK_PERIOD : time := 50 ns; 
begin
    CLK <= not CLK after CLK_PERIOD/2;

    dut : my_ram
    port map (
          CLK       => CLK,
          RESET     => RESET,
          WRITE_ENA => WRITE_ENA,
          ADDRESS   => ADDRESS,
          DATA_IN   => DATA_IN,
          DATA_OUT  => DATA_OUT
    );

   stimuli : process
    begin
        RESET <= '0';
        wait for CLK_PERIOD*2;
        RESET <= '1';
        assert DATA_OUT = "00000000"
        report "Data not 0000_0000 at init"
        severity warning;

        WRITE_ENA <= '1';
        
        wait for CLK_PERIOD;
        assert DATA_OUT = "10101010"
        report "Data_out /= data_in after write"
        severity error;

        WRITE_ENA <= '0';
        ADDRESS <= "11110000";

        wait for CLK_PERIOD;
        assert DATA_OUT = "00000000"
        report "Data not 0000_0000 after address change"
        severity error;

        wait;
    end process;

end architecture;
