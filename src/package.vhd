----------------------------------------------------------------------------------
-- Company:     BME
-- Engineer:    Nagy Tímea(O5D5VN), Cseh Péter (DM5HMB)
-- 
-- Create Date: 17.02.2017 21:50:53
-- Design Name: alu
-- Module Name: package
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

package alu_package is

--WIDTHS--

constant DATA_WIDTH  : integer := 8;
constant OP_WIDTH    : integer := 8;

--END--WIDTHS--

--OPRATION--CODES--

--type T_OP is (opPass, opAdd, opSubAB, opSubBA, opShl, opShr, opComp, opXor, opAnd, opNand, opOr, opNor);
    --Egyszer?bb használni, mindig látom, hogy melyik m?veletet választottam ki

constant OP_PASS    : integer := 0;
constant OP_ADD     : integer := 1;
constant OP_SUB     : integer := 2;

constant OP_SHL     : integer := 3;
constant OP_SHR     : integer := 4;

constant OP_COMP    : integer := 5;

constant OP_XOR     : integer := 6;
constant OP_AND     : integer := 7;
constant OP_NAND    : integer := 8;
constant OP_OR      : integer := 9;
constant OP_NOR     : integer := 10;

--OPRATION--CODES--

--TYPE--DECLARATIONS--

--type t_data_bus is record
--    en : std_logic;
--    data : std_logic_vector((DATA_WIDTH - 1) downto 0);
--end record;
--
--type t_operation_bus is record
--    en : std_logic;
--    op : std_logic_vector((OP_WIDTH - 1) downto 0);
--end record;
--
--type t_flag_bus is record
--    en : std_logic;
--    carry : std_logic;
--    ovf : std_logic;
--    zero : std_logic;
--    negative : std_logic;
--end record;

type t_flag_bus is record
    carry : std_logic;
    ovf : std_logic;
    zero : std_logic;
    negative : std_logic;
end record;

--END--TYPE--DECLARATIONS--
end package alu_package;