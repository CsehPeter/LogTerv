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

type t_op is (OP_PASS, OP_ADD, OP_SUB, OP_SHL, OP_SHR, OP_COMP, OP_XOR, OP_AND, OP_NAND, OP_OR, OP_NOR);

--constant OP_PASS    : integer := 0;
--constant OP_ADD     : integer := 1;
--constant OP_SUB     : integer := 2;

--constant OP_SHL     : integer := 3;
--constant OP_SHR     : integer := 4;

--constant OP_COMP    : integer := 5;

--constant OP_XOR     : integer := 6;
--constant OP_AND     : integer := 7;
--constant OP_NAND    : integer := 8;
--constant OP_OR      : integer := 9;
--constant OP_NOR     : integer := 10;

--OPRATION--CODES--

--TYPE--DECLARATIONS--

type t_flag_bus is record
    carry : std_logic;
    ovf : std_logic;
    zero : std_logic;
    negative : std_logic;
end record;

--END--TYPE--DECLARATIONS--
end package alu_package;