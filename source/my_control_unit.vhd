-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_control_unit.vhd
--
-- Abstract: The control unit takes the
--           instruction, decodes it into control
--           signals and sends them to all the
--           component of the CPU.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.my_package.all;

entity my_control_unit is
   port (
      CLK             : in std_logic;
      RESET           : in std_logic;
      ALU_GT          : in std_logic;
      ALU_Z           : in std_logic;
      LC_Z            : in std_logic;
      INSTRUCTION     : in my_bus_type;
      FETCH_CURRENT   : in std_logic;
      
      -- Data and address mux control signals
      DATA_BUS_SEL    : out my_data_bus_sel_type;
      ADDR_BUS_SEL    : out my_addr_bus_sel_type;
      
      -- ALU control signals
      ALU_OPCODE      : out my_ALU_op_type;
      ALU_OP_ENA      : out std_logic;
      ALU_LD_ACC      : out std_logic;
      ALU_LD_TEMP     : out std_logic;
      
      -- Loop counter control signals
      LC_LD           : out std_logic;
      LC_DEC          : out std_logic;
      
      -- Program counter control signals
      PC_INC          : out std_logic;
      PC_JMP_LD       : out std_logic;
      PC_JMP_ENA      : out std_logic;
      PC_JMP_BACKWARD : out std_logic;
      
      -- Address register 1 control signals
      ADR1_INC        : out std_logic;
      ADR1_LD         : out std_logic;
      
      -- Address register 2 control signals
      ADR2_INC        : out std_logic;
      ADR2_LD         : out std_logic;
      
      -- Memory control signal
      MEM_WRT_ENA     : out std_logic;
      
      -- Signal controls if next state is fetch or execute
      EXECUTE_NEXT      : out std_logic := '1'
   );
end entity;

architecture rtl of my_control_unit is
   signal current_instruction : my_bus_type := (others => '0');
begin
   update_state : process (CLK, RESET)
   begin
      if RESET = RST_VAL then
         EXECUTE_NEXT <= '0';
         current_instruction <= OP_NOP;
      elsif rising_edge(CLK) then
         if FETCH_CURRENT = '1' then
            current_instruction <= INSTRUCTION;
         end if;
         EXECUTE_NEXT <= not FETCH_CURRENT;
      end if;
   end process;
   
   update_outputs : process (current_instruction, FETCH_CURRENT)
   begin
      -- Set default values
      DATA_BUS_SEL    <= SEL_D_NOP;
      ADDR_BUS_SEL    <= SEL_A_NOP;
      ALU_OPCODE      <= ALU_NOP;
      ALU_OP_ENA      <= '0';
      ALU_LD_ACC      <= '0';
      ALU_LD_TEMP     <= '0';
      LC_LD           <= '0';
      LC_DEC          <= '0';
      PC_INC          <= '0';
      PC_JMP_LD       <= '0';
      PC_JMP_ENA      <= '0';
      PC_JMP_BACKWARD <= '0';
      ADR1_INC        <= '0';
      ADR1_LD         <= '0';
      ADR2_INC        <= '0';
      ADR2_LD         <= '0';
      MEM_WRT_ENA     <= '0';
      -- Update relevant outputs
      if FETCH_CURRENT = '1' then
         DATA_BUS_SEL <= SEL_D_MEM;
         ADDR_BUS_SEL <= SEL_A_PC;
         PC_INC <= '1';
      else
         case current_instruction is
            when OP_LD_ADR1 => DATA_BUS_SEL <= SEL_D_MEM;
                               ADDR_BUS_SEL <= SEL_A_PC;
                               PC_INC <= '1';
                               ADR1_LD <= '1';
                              
            when OP_LD_ADR2 => DATA_BUS_SEL <= SEL_D_MEM;
                               ADDR_BUS_SEL <= SEL_A_PC;
                               PC_INC <= '1';
                               ADR2_LD <= '1';
                               
            when OP_LD_ACC => DATA_BUS_SEL <= SEL_D_MEM;
                              ADDR_BUS_SEL <= SEL_A_ADR1;
                              ALU_LD_ACC <= '1';
                              
            when OP_LD_TEMP => DATA_BUS_SEL <= SEL_D_MEM;
                              ADDR_BUS_SEL <= SEL_A_ADR2;
                              ALU_LD_TEMP <= '1';
                              
            when OP_LD_LC => DATA_BUS_SEL <= SEL_D_MEM;
                              ADDR_BUS_SEL <= SEL_A_PC;
                              PC_INC <= '1';
                              LC_LD <= '1';
                              
            when OP_LD_JUMPREG => DATA_BUS_SEL <= SEL_D_MEM;
                              ADDR_BUS_SEL <= SEL_A_PC;
                              PC_INC <= '1';
                              PC_JMP_LD <= '1';
                              
            when OP_ST_ACC1 => DATA_BUS_SEL <= SEL_D_ALU;
                              ADDR_BUS_SEL <= SEL_A_ADR1;
                              MEM_WRT_ENA <= '1';
                              
            when OP_ST_ACC2 => DATA_BUS_SEL <= SEL_D_ALU;
                              ADDR_BUS_SEL <= SEL_A_ADR2;
                              MEM_WRT_ENA <= '1';
                              
            when OP_JPF => PC_JMP_ENA <= '1';
                              
            when OP_JPB => PC_JMP_ENA <= '1';
                           PC_JMP_BACKWARD <= '1';
                            
            when OP_JPF_G => if ALU_GT = '1' then
                                PC_JMP_ENA <= '1';
                            end if;
                            
            when OP_JPB_G => if ALU_GT = '1' then
                                PC_JMP_ENA <= '1';
                             end if;
                             PC_JMP_BACKWARD <= '1';
                            
            when OP_JPF_Z => if ALU_Z = '1' then
                                PC_JMP_ENA <= '1';
                             end if;
                            
            when OP_JPB_Z => if ALU_Z = '1' then
                                PC_JMP_ENA <= '1';
                             end if;
                             PC_JMP_BACKWARD <= '1';
                            
            when OP_JPF_LC => if LC_Z = '1' then
                                PC_JMP_ENA <= '1';
                            else
                                LC_DEC <= '1';
                            end if;
                            
            when OP_JPB_LC => if LC_Z = '1' then
                                PC_JMP_ENA <= '1';
                            else
                                LC_DEC <= '1';
                            end if;
                            PC_JMP_BACKWARD <= '1';
            
            when OP_INC_ADR1 => ADR1_INC <= '1';
            
            when OP_INC_ADR2 => ADR2_INC <= '1';
            
            when OP_CMP => ALU_OPCODE <= ALU_SUB;
                           ALU_OP_ENA <= '1';
            
            when OP_ADD => ALU_OPCODE <= ALU_ADD;
                           ALU_OP_ENA <= '1';
                           
            when OP_SUB => ALU_OPCODE <= ALU_SUB;
                           ALU_OP_ENA <= '1';
                           
            when OP_INC => ALU_OPCODE <= ALU_INC;
                           ALU_OP_ENA <= '1';
                           
            when OP_DEC => ALU_OPCODE <= ALU_DEC;
                           ALU_OP_ENA <= '1';
                           
            when OP_RAL => ALU_OPCODE <= ALU_RAL;
                           ALU_OP_ENA <= '1';
                           
            when OP_RAR => ALU_OPCODE <= ALU_RAR;
                           ALU_OP_ENA <= '1';
                           
            when OP_SHL => ALU_OPCODE <= ALU_SHL;
                           ALU_OP_ENA <= '1';
                           
            when OP_SHR => ALU_OPCODE <= ALU_SHR;
                           ALU_OP_ENA <= '1';
                           
            when others => null;               
         end case;
      end if;
   end process;
   
end architecture;
