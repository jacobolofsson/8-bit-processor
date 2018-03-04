library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_control_unit_TST is
end entity;

architecture test of my_control_unit_TST is

    component my_control_unit
        port (CLK             : in std_logic;
              RESET           : in std_logic;
              ALU_GT          : in std_logic;
              ALU_Z           : in std_logic;
              LC_Z            : in std_logic;
              INSTRUCTION     : in my_bus_type;
              FETCH_CURRENT   : in std_logic;
              DATA_BUS_SEL    : out my_data_bus_sel_type;
              ADDR_BUS_SEL    : out my_addr_bus_sel_type;
              ALU_OPCODE      : out my_alu_op_type;
              ALU_OP_ENA      : out std_logic;
              ALU_LD_ACC      : out std_logic;
              ALU_LD_TEMP     : out std_logic;
              ALU_INC_ACC     : out std_logic;
              LC_LD           : out std_logic;
              LC_DEC          : out std_logic;
              PC_INC          : out std_logic;
              PC_JMP_LD       : out std_logic;
              PC_JMP_ENA      : out std_logic;
              PC_JMP_BACKWARD : out std_logic;
              ADR1_LD         : out std_logic;
              ADR1_INC        : out std_logic;
              ADR2_LD         : out std_logic;
              ADR2_INC        : out std_logic;
              MEM_WRT_ENA     : out std_logic;
              FETCH_NEXT      : out std_logic);
    end component;

    signal CLK             : std_logic := '0';
    signal RESET           : std_logic := '0';
    signal ALU_GT          : std_logic := '0';
    signal ALU_Z           : std_logic := '0';
    signal LC_Z            : std_logic := '0';
    signal INSTRUCTION     : my_bus_type := OP_NOP;
    signal FETCH_CURRENT   : std_logic := '0';

    signal DATA_BUS_SEL    : my_data_bus_sel_type;
    signal ADDR_BUS_SEL    : my_addr_bus_sel_type;
    signal ALU_OPCODE      : my_alu_op_type;
    signal ALU_OP_ENA      : std_logic;
    signal ALU_LD_ACC      : std_logic;
    signal ALU_LD_TEMP     : std_logic;
    signal ALU_INC_ACC     : std_logic;
    signal LC_LD           : std_logic;
    signal LC_DEC          : std_logic;
    signal PC_INC          : std_logic;
    signal PC_JMP_LD       : std_logic;
    signal PC_JMP_ENA      : std_logic;
    signal PC_JMP_BACKWARD : std_logic;
    signal ADR1_LD         : std_logic;
    signal ADR1_INC        : std_logic;
    signal ADR2_LD         : std_logic;
    signal ADR2_INC        : std_logic;
    signal MEM_WRT_ENA     : std_logic;
    signal FETCH_NEXT      : std_logic;

    constant CLK_PERIOD : time := 50 ns;
begin
    CLK <= not CLK after CLK_PERIOD/2;

    dut : my_control_unit
    port map (CLK             => CLK,
              RESET           => RESET,
              ALU_GT          => ALU_GT,
              ALU_Z           => ALU_Z,
              LC_Z            => LC_Z,
              INSTRUCTION     => INSTRUCTION,
              FETCH_CURRENT   => FETCH_CURRENT,
              DATA_BUS_SEL    => DATA_BUS_SEL,
              ADDR_BUS_SEL    => ADDR_BUS_SEL,
              ALU_OPCODE      => ALU_OPCODE,
              ALU_OP_ENA      => ALU_OP_ENA,
              ALU_LD_ACC      => ALU_LD_ACC,
              ALU_LD_TEMP     => ALU_LD_TEMP,
              ALU_INC_ACC     => ALU_INC_ACC,
              LC_LD           => LC_LD,
              LC_DEC          => LC_DEC,
              PC_INC          => PC_INC,
              PC_JMP_LD       => PC_JMP_LD,
              PC_JMP_ENA      => PC_JMP_ENA,
              PC_JMP_BACKWARD => PC_JMP_BACKWARD,
              ADR1_LD         => ADR1_LD,
              ADR1_INC        => ADR1_INC,
              ADR2_LD         => ADR2_LD,
              ADR2_INC        => ADR2_INC,
              MEM_WRT_ENA     => MEM_WRT_ENA,
              FETCH_NEXT      => FETCH_NEXT);

    stimuli : process
    begin
        RESET <= '1';
        wait for 100 ns;
        RESET <= '0';
        wait for 100 ns;

        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_ADR1;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_ADR2;
        wait for CLK_PERIOD;
        INSTRUCITON <= OP_LD_ACC;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_TEMP;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_LC;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_JUMPREG;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_ST_ACC1;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_ACC2;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF;  
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB;   
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_G;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_G;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_Z;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_Z;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_LC;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_LC;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_INC_ADR1;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_INC_ADR2;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_CMP;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_ADD;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_SUB;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_INC;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_DEC;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_RAL;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_RAR;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_SHL;
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_SHR;

        wait;
    end process;
    
    instruction_verificattion : process (CLK)
    begin
        if rising_edge(CLK) then
            if FETCH_CURRENT = '1' then
                assert DATA_BUS_SEL    = SEL_D_MEM and
                       ADDR_BUS_SEL    = SEL_A_PC and 
                       ALU_OPCODE      = ALU_NOP and
                       ALU_OP_ENA      = '0' and
                       ALU_LD_ACC      = '0' and
                       ALU_LD_TEMP     = '0' and     
                       ALU_INC_ACC     = '0' and   
                       LC_LD           = '0' and   
                       LC_DEC          = '0' and   
                       PC_INC          = '1' and   
                       PC_JMP_LD       = '0' and   
                       PC_JMP_ENA      = '0' and   
                       PC_JMP_BACKWARD = '0' and
                       ADR1_LD         = '0' and
                       ADR1_INC        = '0' and
                       ADR2_LD         = '0' and
                       ADR2_INC        = '0' and
                       MEM_WRT_ENA     = '0' and
                       FETCH_NEXT      = '0' 
                report "FETCH state error"
                severity error;
            else
                assert FETCH_NEXT = '1'
                report "FETCH_NEXT /= 1 during execute"
                severity error;
            
                case INSTRUCTION is
                    when OP_LD_ADR1 
            end if;
        end if;
    end process;

end architecture;

