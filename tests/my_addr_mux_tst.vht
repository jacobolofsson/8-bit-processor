library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_addr_mux_TST is
end entity;

architecture test of my_addr_mux_TST is

    component my_addr_mux
        port (SEL      : in my_addr_bus_sel_type;
              PC       : in my_bus_type;
              ADR1     : in my_bus_type;
              ADR2     : in my_bus_type;
              ADDR_BUS : out my_bus_type);
    end component;

    signal SEL      : my_addr_bus_sel_type := SEL_A_NOP;
    signal PC       : my_bus_type := "10101010";
    signal ADR1     : my_bus_type := "11110000";
    signal ADR2     : my_bus_type := "00001111";
    signal ADDR_BUS : my_bus_type;

begin

    dut : my_addr_mux
    port map (SEL      => SEL,
              PC       => PC,
              ADR1     => ADR1,
              ADR2     => ADR2,
              ADDR_BUS => ADDR_BUS);

    stimuli : process
    begin
        SEL <= SEL_A_PC;
        assert ADDR_BUS = "10101010"
        report "Sel pc error"
        severity error;

        SEL <= SEL_A_ADR1;
        assert ADDR_BUS = "11110000"
        report "Sel adr1 error"
        severity error;

        SEL <= SEL_A_ADR2;
        assert ADDR_BUS = "00001111"
        report "Sel adr2 error"
        severity error;

        wait;
    end process;

end architecture;
