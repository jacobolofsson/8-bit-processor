-------------------------------------------------
-- Author:   Jacob Olofsson
-- Project:  My 8-bit processor
-- URL:      github.com/mumsjacob/8-bit-processor
-- Date:     2018-02-24
-- File:     my_ALU.vhd
--
-- Abstract: The ALU contains two register that
--           can be loaded. Different arithmetic
--           operations can be performed on the
--           registers.
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.my_package.all;

entity my_ALU is
   port (
      CLK       : in std_logic;
      RESET     : in std_logic;
      OPERATION : in my_ALU_op_type;
      OP_ENA    : in std_logic;
      LD_ACC    : in std_logic;
      LD_TMP    : in std_logic;
      NEW_ACC   : in my_bus_type;
      NEW_TMP   : in my_bus_type;
      RESULT    : out my_bus_type;
      RES_GT    : out std_logic;
      RES_Z     : out std_logic
   );
end entity;

architecture rtl of my_ALU is
   signal temporary   : signed(REG_WIDTH-1 downto 0) := (others => '0');
   signal accumulator : signed(REG_WIDTH-1 downto 0) := (others => '0');
   signal res         : signed(REG_WIDTH-1 downto 0);
begin
   with OPERATION select
      res <= accumulator + temporary when ALU_ADD,
             accumulator - temporary when ALU_SUB,
             accumulator + 1 when ALU_INC,
             accumulator - 1 when ALU_DEC,
             accumulator(REG_WIDTH-2 downto 0) & accumulator(REG_WIDTH-1) when ALU_RAL,
             accumulator(0) & accumulator(REG_WIDTH-1 downto 1) when ALU_RAR,
             accumulator(REG_WIDTH-2 downto 0) & '0' when ALU_SHL,
             '0' & accumulator(REG_WIDTH-1 downto 1) when ALU_SHR,
             accumulator when others;

   process (CLK, RESET)
   begin
      if RESET = RST_VAL then
         temporary   <= (others => '0');
         accumulator <= (others => '0');
      elsif rising_edge(CLK) then
         if OP_ENA = '1' then
            accumulator <= res;
         elsif LD_ACC = '1' then
            accumulator <= signed(NEW_ACC);
         end if;
         if LD_TMP = '1' then
            temporary <= signed(NEW_TMP);
         end if;
      end if;
   end process;
   
   RESULT <= std_logic_vector(accumulator);
   RES_GT <= '1' when accumulator > 0 else
             '0';
   RES_Z  <= '1' when accumulator = 0 else
             '0';
end architecture;
