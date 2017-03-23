----------------------------------------------------------------------------------
-- Company:     BME
-- Engineer:    Nagy Tímea(O5D5VN), Cseh Péter (DM5HMB)
-- 
-- Create Date: 17.02.2017 21:50:53
-- Design Name: alu
-- Module Name: alu_top - behavioral
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

use work.alu_package.all;

entity alu_top is
    port
    (
        clk     : in std_logic;
        rst     : in std_logic;
        
        a       : in std_logic_vector((DATA_WIDTH - 1) downto 0);
        b       : in std_logic_vector((DATA_WIDTH - 1) downto 0);
        op      : in t_op; --in std_logic_vector((OP_WIDTH - 1) downto 0);
        
        i_flag  : in t_flag_bus;
        
        y       : out std_logic_vector((DATA_WIDTH - 1) downto 0);
        o_flag  : out t_flag_bus
    );
end alu_top;

architecture behavioral of alu_top is

    --signal op_code : integer range 0 to (2 ** OP_WIDTH) := 0;
    
    signal res_add : std_logic_vector(DATA_WIDTH downto 0) := (others => '0');
    signal res_sub : std_logic_vector(DATA_WIDTH downto 0) := (others => '0');
    
begin

--op_code <= to_integer(unsigned(op));

proc_arith : process(a, b, i_flag.carry, rst)
begin

    if(rst = '1') then
    
        res_add <= (others => '0');
        res_sub <= (others => '0');
        
    else
        
        --ADD--
        if(i_flag.carry = '0') then
            res_add <= std_logic_vector( to_unsigned( (to_integer(unsigned(a)) + to_integer(unsigned(b)) + 0 ), (DATA_WIDTH + 1) ) );
        else
            res_add <= std_logic_vector( to_unsigned( (to_integer(unsigned(a)) + to_integer(unsigned(b)) + 1 ) , (DATA_WIDTH + 1) ));
        end if;
        
        --SUBTRACT--
        if(i_flag.carry = '0') then --Hogy veszem figyelembe a beérkezo carry-t?
            res_sub <= std_logic_vector( to_unsigned( (to_integer(unsigned(a)) - to_integer(unsigned(b)) + 0 ) , DATA_WIDTH + 1  ) );
        else
            res_sub <= std_logic_vector( to_unsigned( (to_integer(unsigned(a)) - to_integer(unsigned(b)) + 1 ) , DATA_WIDTH + 1 ) );
        end if;
                        
    end if;

end process proc_arith;

proc_alu : process(clk)
begin

if(rising_edge(clk)) then
    if(rst = '1') then

        y <= (others => '0');
        o_flag <= (others => '0');
        
    else
        
        case op is
        
            when OP_PASS =>
                y <= a;
                o_flag <= (others => '0');
    
            when OP_ADD =>
                y <= res_add((DATA_WIDTH - 1) downto 0);
                o_flag.carry <= res_add(DATA_WIDTH);
                --overflow??? unsigned esetén nincs
                --zero flag?
                
            when OP_SUB =>
                y <= res_sub((DATA_WIDTH - 1) downto 0);
                o_flag.carry <= res_sub(DATA_WIDTH);
                if ( unsigned(a) < unsigned(b) ) then
                    o_flag <= (negative => '1', others => '0'); --Ez szar, többszörös meghajtás
                end if;
                --overflow??? unsigned esetén nincs
                --zero flag?
                
            when OP_SHL =>
                y <= a( ((DATA_WIDTH -1) -1) downto 0 ) & '0';
                o_flag <= (carry => a(DATA_WIDTH - 1) , others => '0');
                
            when OP_SHR =>
            --LSB hova kerül?
                y <= '0' & a( (DATA_WIDTH - 1) downto 1 );
                o_flag <= (carry => a(0) , others => '0');
                --o_flag <= (others => '0');
                
            when OP_COMP =>
            --Hogy jelzem ki???     egyenlo : zero;     a > b : "positive"    a < b : negative
                if ( unsigned(a) = unsigned(b) ) then
                    o_flag <= (zero => '1', others => '0');
                end if;
                if ( unsigned(a) > unsigned(b) ) then
                    o_flag <= (others => '0');
                end if;
                if ( unsigned(a) < unsigned(b) ) then
                    o_flag <= (negative => '1', others => '0');
                end if;
                y <= (others => '0');
                    
            when OP_XOR =>
                y <= (a xor b);
                o_flag <= (others => '0');
                --zero flag?
                
            when OP_AND =>
                y <= (a and b);
                o_flag <= (others => '0');
                --zero flag?
                
            when OP_NAND =>
                y <= not(a and b);
                o_flag <= (others => '0');
                --zero flag?
                
            when OP_OR =>
                y <= (a or b);
                o_flag <= (others => '0');
                --zero flag?
                
            when OP_NOR =>
                y <= not(a or b);
                o_flag <= (others => '0');
                --zero flag?
                
            when others =>
                y <= (others => '0');
                o_flag <= (others => '0');
            
            end case;
    end if;
end if;
end process proc_alu;

end behavioral;