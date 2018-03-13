library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_ALU_TST is
end entity;

architecture test of my_ALU_TST is

    component my_ALU
        port (CLK       : in std_logic;
              RESET     : in std_logic;
              OPERATION : in my_alu_op_type;
              OP_ENA    : in std_logic;
              LD_ACC    : in std_logic;
              LD_TMP    : in std_logic;
              NEW_ACC   : in my_bus_type;
              NEW_TMP   : in my_bus_type;
              RESULT    : out my_bus_type;
              RES_GT    : out std_logic;
              RES_Z     : out std_logic);
    end component;

    signal CLK       : std_logic := '0';
    signal RESET     : std_logic := '1';
    signal OPERATION : my_alu_op_type := ALU_NOP;
    signal OP_ENA    : std_logic := '0';
    signal LD_ACC    : std_logic := '0';
    signal LD_TMP    : std_logic := '0';
    signal NEW_ACC   : my_bus_type := "00000000";
    signal NEW_TMP   : my_bus_type := "00000000";
    signal RESULT    : my_bus_type;
    signal RES_GT    : std_logic;
    signal RES_Z     : std_logic;

    constant CLK_PERIOD : time := 50 ns;
begin
    CLK <= not CLK after CLK_PERIOD/2;

    dut : my_ALU
    port map (CLK       => CLK,
              RESET     => RESET,
              OPERATION => OPERATION,
              OP_ENA    => OP_ENA,
              LD_ACC    => LD_ACC,
              LD_TMP    => LD_TMP,
              NEW_ACC   => NEW_ACC,
              NEW_TMP   => NEW_TMP,
              RESULT    => RESULT,
              RES_GT    => RES_GT,
              RES_Z     => RES_Z);

    stimuli : process
    begin
        wait for CLK_PERIOD*2;
        RESET <= '1';
        assert RESULT = "00000000" and RES_GT = '0' and RES_Z = '1'
        report "Error value after NOP"
        severity error;

        NEW_ACC <= "11110000";
        LD_ACC <= '1';
        
        wait for CLK_PERIOD;
        assert RESULT = "11110000" and RES_GT = '0' and RES_Z = '0'
        report "Error value after NOP"
        severity error;

        NEW_TMP <= "00001111";
        LD_TMP <= '1';

        wait for CLK_PERIOD;
        assert RESULT = "11110000" and RES_GT = '0' and RES_Z = '0'
        report "Error value after NOP"
        severity error;
        
        LD_TMP <= '0';
        LD_ACC <= '0';
        OP_ENA <= '1';
        OPERATION <= ALU_ADD;

        wait for CLK_PERIOD;
        assert RESULT = "11111111" and RES_GT = '0' and RES_Z = '0'
        report "Error value after ADD"
        severity error;
        
        OPERATION <= ALU_SUB;
        
        wait for CLK_PERIOD;
        assert RESULT = "11110000" and RES_GT = '0' and RES_Z = '0'
        report "Error value after SUB"
        severity error;
        
        LD_ACC <= '1';
        OPERATION <= ALU_INC;
        
        wait for CLK_PERIOD;
        assert RESULT = "11110001" and RES_GT = '0' and RES_Z = '0'
        report "Error value after INC"
        severity error;
        
        OPERATION <= ALU_DEC;
        
        wait for CLK_PERIOD;
        assert RESULT = "11110000" and RES_GT = '0' and RES_Z = '0'
        report "Error value after DEC"
        severity error;
        
        OPERATION <= ALU_RAL;
        
        wait for CLK_PERIOD;
        assert RESULT = "11100001" and RES_GT = '0' and RES_Z = '0'
        report "Error value after RAL"
        severity error;
        
        OPERATION <= ALU_RAR;
        
        wait for CLK_PERIOD;
        assert RESULT = "11110000" and RES_GT = '0' and RES_Z = '0'
        report "Error value after RAR"
        severity error;

        OPERATION <= ALU_SHL;
        
        wait for CLK_PERIOD;
        assert RESULT = "11100000" and RES_GT = '0' and RES_Z = '0'
        report "Error value after SHL"
        severity error;
        
        OPERATION <= ALU_SHR;
        
        wait for CLK_PERIOD;
        assert RESULT = "01110000" and RES_GT = '1' and RES_Z = '0'
        report "Error value after SHR"
        severity error;

        OPERATION <= ALU_SHL;

        wait for CLK_PERIOD *8;
        assert RESULT = "00000000" and RES_GT = '0' and RES_Z = '1'
        report "Result /= 0 after shifted all the way around"
        severity error;

        wait;
    end process;

end architecture;
