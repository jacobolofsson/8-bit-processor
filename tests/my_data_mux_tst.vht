library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_data_mux_TST is
end entity;

architecture test of my_data_mux_TST is

    component my_data_mux
        port (SEL      : in my_data_bus_sel_type;
              ALU      : in my_bus_type;
              MEM      : in my_bus_type;
              DATA_BUS : out my_bus_type);
    end component;

    signal SEL      : my_data_bus_sel_type := SEL_D_NOP;
    signal ALU      : my_bus_type := "11110000";
    signal MEM      : my_bus_type := "00001111";
    signal DATA_BUS : my_bus_type;

begin

    dut : my_data_mux
    port map (SEL      => SEL,
              ALU      => ALU,
              MEM      => MEM,
              DATA_BUS => DATA_BUS);

    stimuli : process
    begin
        SEL <= SEL_D_ALU;
        assert DATA_BUS = "11110000"
        report "Sel ALU data error"
        severity error;

        SEL <= SEL_D_MEM;
        assert DATA_BUS = "00001111"
        report "Sel MEM data error"
        severity error;

        wait;
    end process;

end architecture;
