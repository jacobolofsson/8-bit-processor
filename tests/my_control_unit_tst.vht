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
        wait for CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;

        INSTRUCTION <= OP_LD_ADR1;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_ADR2;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_ACC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_TEMP;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_LC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_LD_JUMPREG;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_ST_ACC1;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_ST_ACC2;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF;  
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB;   
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_G;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_G;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_Z;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_Z;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_LC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_LC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_G;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';

        ALU_GT <= '1';
        ALU_Z <= '1';
        LC_Z  <= '1';

        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_G;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_Z;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_Z;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPF_LC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_JPB_LC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_INC_ADR1;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_INC_ADR2;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_CMP;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_ADD;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_SUB;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_INC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_DEC;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_RAL;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_RAR;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_SHL;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';
        wait for CLK_PERIOD;
        INSTRUCTION <= OP_SHR;
        FETCH_CURRENT <= '1';
        wait for CLK_PERIOD;
        FETCH_CURRENT <= '0';

        wait;
    end process;
    
    instruction_verificattion : process (CLK)
    begin
        if falling_edge(CLK) then
            if FETCH_CURRENT = '1' then
                assert DATA_BUS_SEL    = SEL_D_MEM and
                       ADDR_BUS_SEL    = SEL_A_PC and 
                       ALU_OPCODE      = ALU_NOP and
                       ALU_OP_ENA      = '0' and
                       ALU_LD_ACC      = '0' and
                       ALU_LD_TEMP     = '0' and     
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
                                                
when OP_LD_ADR1    => assert DATA_BUS_SEL = SEL_D_MEM report "DATA_BUS_SEL  wrong when instr = OP_LD_ADR1";
                      assert ADDR_BUS_SEL = SEL_A_PC report "ADDR_BUS_SEL  wrong when instr = OP_LD_ADR1";
                      assert PC_INC = '1' report "PC_INC = 0 when instr = OP_LD_ADR1";
                      assert ADR1_LD= '1' report "ADR1_LD= 0 when instr = OP_LD_ADR1";
when OP_LD_ADR2    => assert DATA_BUS_SEL = SEL_D_MEM report "DATA_BUS_SEL  wrong when instr = OP_LD_ADR2";
                      assert ADDR_BUS_SEL = SEL_A_PC report "ADDR_BUS_SEL  wrong when instr = OP_LD_ADR2";
                      assert PC_INC = '1' report "PC_INC = 0 when instr = OP_LD_ADR2";
                      assert ADR2_LD= '1' report "ADR2_LD= 0 when instr = OP_LD_ADR2";    
when OP_LD_ACC     => assert DATA_BUS_SEL = SEL_D_MEM report "DATA_BUS_SEL  wrong when instr = OP_LD_ACC";
                      assert ADDR_BUS_SEL = SEL_A_ADR1 report "ADDR_BUS_SEL  wrong when instr = OP_LD_ACC";
                      assert ALU_LD_ACC = '1' report "ALU_LD_ACC = 0 when instr = OP_LD_ACC";                                    
when OP_LD_TEMP    => assert DATA_BUS_SEL = SEL_D_MEM report "DATA_BUS_SEL  wrong when instr = OP_LD_TEMP";
                      assert ADDR_BUS_SEL = SEL_A_ADR2 report "ADDR_BUS_SEL  wrong when instr = OP_LD_TEMP";
                      assert ALU_LD_TEMP= '1' report "ALU_LD_TEMP= 0 when instr = OP_LD_TEMP";                               
when OP_LD_LC      => assert DATA_BUS_SEL = SEL_D_MEM report "DATA_BUS_SEL  wrong when instr = OP_LD_LC";
                      assert ADDR_BUS_SEL = SEL_A_PC report "ADDR_BUS_SEL  wrong when instr = OP_LD_LC";
                      assert LC_LD= '1' report "LC_LD= 0 when instr = OP_LD_LC";
                      assert PC_INC = '1' report "PC_INC = 0 when instr = OP_LD_LC";                      
when OP_LD_JUMPREG => assert DATA_BUS_SEL = SEL_D_MEM report "DATA_BUS_SEL  wrong when instr = OP_LD_JUMPREG";
                      assert ADDR_BUS_SEL = SEL_A_PC report "ADDR_BUS_SEL  wrong when instr = OP_LD_JUMPREG";
                      assert PC_INC = '1' report "PC_INC = 0 when instr = OP_LD_JUMPREG";
                      assert PC_JMP_LD= '1' report "PC_JMP_LD= 0 when instr = OP_LD_JUMPREG";                     
when OP_ST_ACC1    => assert DATA_BUS_SEL = SEL_D_ALU report "DATA_BUS_SEL  wrong when instr = OP_ST_ACC1";
                      assert ADDR_BUS_SEL = SEL_A_ADR1 report "ADDR_BUS_SEL  wrong when instr = OP_ST_ACC1";
                      assert MEM_WRT_ENA= '1' report "MEM_WRT_ENA= 0 when instr = OP_ST_ACC1";
when OP_ST_ACC2    => assert DATA_BUS_SEL = SEL_D_ALU report "DATA_BUS_SEL  wrong when instr = OP_ST_ACC2";
                      assert ADDR_BUS_SEL = SEL_A_ADR2 report "ADDR_BUS_SEL  wrong when instr = OP_ST_ACC2";
                      assert MEM_WRT_ENA= '1' report "MEM_WRT_ENA= 0 when instr = OP_ST_ACC2";

when OP_JPF        => assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPF";
when OP_JPB        => assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPB";
                      assert PC_JMP_BACKWARD= '1' report "PC_JMP_BACKWARD= 0 when instr = OP_JPB";

when OP_JPF_G =>  if ALU_GT = '1' then
                     assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPF_G"; 
                  else
                     assert PC_JMP_ENA = '0' report "PC_JMP_ENA = 1 when instr = OP_JPF_G"; 
                  end if;
when OP_JPB_G =>  if ALU_GT = '1' then
                     assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPB_G";
                  else
                     assert PC_JMP_ENA = '0' report "PC_JMP_ENA = 1 when instr = OP_JPB_G";
                  end if;
                  assert PC_JMP_BACKWARD= '1' report "PC_JMP_BACKWARD= 0 when instr = OP_JPB_G";
when OP_JPF_Z =>  if ALU_Z = '1' then
                      assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPF_Z"; 
                  else
                      assert PC_JMP_ENA = '0' report "PC_JMP_ENA = 1 when instr = OP_JPF_Z"; 
                  end if;
when OP_JPB_Z =>  if ALU_Z = '1' then
                      assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPB_Z";
                  else
                      assert PC_JMP_ENA = '0' report "PC_JMP_ENA = 1 when instr = OP_JPB_Z";
                  end if;
                  assert PC_JMP_BACKWARD= '1' report "PC_JMP_BACKWARD= 0 when instr = OP_JPB_Z";
when OP_JPF_LC => if LC_Z = '1' then
                      assert LC_DEC = '0' report "LC_DEC = 1 when instr = OP_JPF_LC";
                      assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPF_LC";   
                  else
                      assert LC_DEC = '1' report "LC_DEC = 0 when instr = OP_JPF_LC";
                      assert PC_JMP_ENA = '0' report "PC_JMP_ENA = 1 when instr = OP_JPF_LC";   
                  end if;
when OP_JPB_LC => if LC_Z = '1' then
                      assert LC_DEC = '0' report "LC_DEC = 1 when instr = OP_JPB_LC";
                      assert PC_JMP_ENA = '1' report "PC_JMP_ENA = 0 when instr = OP_JPB_LC";
                  else
                      assert LC_DEC = '1' report "LC_DEC = 0 when instr = OP_JPB_LC";
                      assert PC_JMP_ENA = '0' report "PC_JMP_ENA = 1 when instr = OP_JPB_LC";
                  end if;
                  assert PC_JMP_BACKWARD= '1' report "PC_JMP_BACKWARD= 0 when instr = OP_JPB_LC";

when OP_INC_ADR1 => assert ADR1_INC = '1' report "ADR1_INC = 0 when instr = OP_INC_ADR1";
when OP_INC_ADR2 => assert ADR2_INC = '1' report "ADR2_INC = 0 when instr = OP_INC_ADR2";

when OP_CMP      => assert ALU_OPCODE = ALU_SUB report "ALU_OPCODE = 0 when instr = OP_CMP";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_CMP";
when OP_ADD      => assert ALU_OPCODE = ALU_ADD report "ALU_OPCODE = 0 when instr = OP_ADD";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_ADD";
when OP_SUB      => assert ALU_OPCODE = ALU_SUB report "ALU_OPCODE = 0 when instr = OP_SUB";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_SUB";
when OP_INC      => assert ALU_OPCODE = ALU_INC report "ALU_OPCODE = 0 when instr = OP_INC";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_INC";
when OP_DEC      => assert ALU_OPCODE = ALU_DEC report "ALU_OPCODE = 0 when instr = OP_DEC";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_DEC";
when OP_RAL      => assert ALU_OPCODE = ALU_RAL report "ALU_OPCODE = 0 when instr = OP_RAL";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_RAL";
when OP_RAR      => assert ALU_OPCODE = ALU_RAR report "ALU_OPCODE = 0 when instr = OP_RAR";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_RAR";
when OP_SHL      => assert ALU_OPCODE = ALU_SHL report "ALU_OPCODE = 0 when instr = OP_SHL";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_SHL";
when OP_SHR      => assert ALU_OPCODE = ALU_SHR report "ALU_OPCODE = 0 when instr = OP_SHR";
                    assert ALU_OP_ENA = '1' report "ALU_OP_ENA = 0 when instr = OP_SHR";

when others      => assert false report "Not allowed instruction";
end case;
            end if;
        end if;
    end process;

end architecture;

