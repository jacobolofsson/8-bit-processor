-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_program_counter.vhd
--
-- Abstract: The program counter is keeps track of
--           the memory address of the next
--           instruction. It is incremented after
--           a new instruction is fetched or a
--           jump is issued.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.my_package.all;

entity my_program_counter is
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
end entity;

architecture rtl of my_program_counter is
   signal jump_value : unsigned(REG_WIDTH-1 downto 0) := (others => '0');
   signal counter    : unsigned(REG_WIDTH-1 downto 0) := (others => '0');
begin
   process (CLK, RESET)
   begin
      if RESET = RST_VAL then
         jump_value <= (others => '0');
         counter <= (others => '0');
      elsif rising_edge(CLK) then
         if INC_PC = '1' then
            counter <= counter + 1;
         elsif JMP_ENA = '1' then
            if JMP_BACKWARD = '1' then
               counter <= counter - jump_value;
            else
               counter <= counter + jump_value;
            end if;
         end if;
         if LD_JMP_VALUE = '1' then
            jump_value <= unsigned(NEW_JMP_VALUE);
         end if;
      end if;
   end process;
   
   OUT_PC <= std_logic_vector(counter);
   
end architecture;
