library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_program_counter_TST is
end entity;

architecture test of my_program_counter_TST is
    component my_program_counter is
       port (
          CLK           : in std_logic;
          RESET         : in std_logic;
          INC_PC        : in std_logic;
          LD_JMP_VALUE  : in std_logic;
          JMP_ENA       : in std_logic;
          JMP_BACKWARD  : in std_logic;
          NEW_JMP_VALUE : in my_bus_type;
          OUT_PC        : out my_bus_type
       );
    end component;

    signal CLK           : std_logic := '0';
    signal RESET         : std_logic := '0';
    signal INC_PC        : std_logic := '0';
    signal LD_JMP_VALUE  : std_logic := '0';
    signal JMP_ENA       : std_logic := '0';
    signal JMP_BACKWARD  : std_logic := '0';
    signal NEW_JMP_VALUE : my_bus_type := "11110000";
    signal OUT_PC        : my_bus_type;

    constant CLK_PERIOD : time := 50 ns;
begin
    CLK <= not CLK after CLK_PERIOD/2;

    dut : my_program_counter
    port map (
       CLK           => CLK, 
       RESET         => RESET,
       INC_PC        => INC_PC,
       LD_JMP_VALUE  => LD_JMP_VALUE,
       JMP_ENA       => JMP_ENA,
       JMP_BACKWARD  => JMP_BACKWARD,
       NEW_JMP_VALUE => NEW_JMP_VALUE,
       OUT_PC        => OUT_PC
    );

    stimuli : process
    begin
        wait for CLK_PERIOD*2;
        RESET <= '1';
        assert OUT_PC = "00000000"
        report "Start value for PC not 0000_0000"
        severity error;
        INC_PC <= '1';
        
        wait for CLK_PERIOD;
        assert OUT_PC = "00000001"
        report "PC /= 0000_0001 after 1 increment"
        severity error;
        
        wait for CLK_PERIOD;
        assert OUT_PC = "00000010"
        report "PC /= 0000_0010 after 2 increments"
        severity error;

        INC_PC <= '1';
        LD_JMP_VALUE <= '1';

        wait for CLK_PERIOD;
        assert OUT_PC = "00000011"
        report "PC changed when loading new jump value"
        severity error;        

        INC_PC <= '0';
        LD_JMP_VALUE <= '0';
        NEW_JMP_VALUE <= "10101011";
        JMP_ENA <= '1';
        
        wait for CLK_PERIOD;
        assert OUT_PC = "11110011"
        report "Jump forward failed"
        severity error;

        JMP_BACKWARD <= '1';
    
        wait for CLK_PERIOD;
        assert OUT_PC <= "00000011"
        report "Jump backward failed"
        severity error;
        
        wait;
    end process;
end architecture;
