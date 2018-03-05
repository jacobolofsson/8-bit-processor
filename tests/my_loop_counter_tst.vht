library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_loop_counter_TST is
end entity;

architecture test of my_loop_counter_TST is

    component my_loop_counter
        port (
           CLK             : in std_logic;
           LD_LOOP_VALUE   : in std_logic;
           DEC_LOOP_VALUE  : in std_logic;
           NEW_LOOP_VALUE  : in my_bus_type;
           LOOP_VALUE_ZERO : out std_logic
        );
    end component;

    signal CLK             : std_logic := '0';
    signal LD_LOOP_VALUE   : std_logic := '0';
    signal DEC_LOOP_VALUE  : std_logic := '0';
    signal NEW_LOOP_VALUE  : my_bus_type := "00000010";
    signal LOOP_VALUE_ZERO : std_logic;

    constant CLK_PERIOD : time := 50 ns;
begin
    CLK <= not CLK after CLK_PERIOD/2;

    dut : my_loop_counter
    port map (
       CLK             => CLK,
       LD_LOOP_VALUE   => LD_LOOP_VALUE,
       DEC_LOOP_VALUE  => DEC_LOOP_VALUE,
       NEW_LOOP_VALUE  => NEW_LOOP_VALUE,
       LOOP_VALUE_ZERO => LOOP_VALUE_ZERO
    );

    stimuli : process
    begin
       wait for CLK_PERIOD*2;
       assert LOOP_VALUE_ZERO = '0'
       report "LOOP_VALUE_ZERO /= 0"
       severity error;

       LD_LOOP_VALUE <= '1';

       wait for CLK_PERIOD;
       assert LOOP_VALUE_ZERO = '0'
       report "LOOP_VALUE_ZERO /= 0"
       severity error;

       DEC_LOOP_VALUE <= '1';

       wait for CLK_PERIOD;
       assert LOOP_VALUE_ZERO = '0'
       report "LOOP_VALUE_ZERO /= 0"
       severity error;

       wait for CLK_PERIOD;
       assert LOOP_VALUE_ZERO = '1'
       report "LOOP_VALUE_ZERO /= 1 after loop"
       severity error;

       wait; 
    end process;

end architecture;

