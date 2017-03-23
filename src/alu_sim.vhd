----------------------------------------------------------------------------------
-- Company:     BME
-- Engineer:    Nagy Tímea(O5D5VN), Cseh Péter (DM5HMB)
-- 
-- Create Date: 20.02.2017 23:18:47
-- Design Name: alu
-- Module Name: alu_sim - Behavioral
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

use work.alu_package.all;

entity alu_sim is

end alu_sim;

architecture behavioral of alu_sim is

    signal tb_clk     : std_logic := '0';
    signal tb_rst     : std_logic := '0';
    
    signal tb_a       : std_logic_vector((DATA_WIDTH - 1) downto 0) := (others => '0');
    signal tb_b       : std_logic_vector((DATA_WIDTH - 1) downto 0) := (others => '0');
    signal tb_op      : t_op := OP_PASS; --std_logic_vector((OP_WIDTH - 1) downto 0) := (others => '0');
    
    signal tb_i_flag  : t_flag_bus := (others => '0');
    
    signal tb_y       : std_logic_vector((DATA_WIDTH - 1) downto 0) := (others => '0');
    signal tb_o_flag  : t_flag_bus := (others => '0');  
    
    signal tb_cnt     : integer range 0 to 2 := 0;

begin

    

    inst_alu : entity work.alu_top(behavioral)
    port map
    (
        clk     =>  tb_clk,   
        rst     =>  tb_rst,   
               
        a       =>  tb_a,     
        b       =>  tb_b,     
        op      =>  tb_op,    
               
        i_flag  =>  tb_i_flag,
               
        y       =>  tb_y,     
        o_flag  =>  tb_o_flag
    );
    
    proc_clk : process
    begin
            tb_clk <= '1'; wait for 5 ns;
            tb_clk <= '0'; wait for 5 ns;
    end process proc_clk;
        
    --Cycle through the operations
    proc_op : process
    begin
        if(tb_cnt > 2) then
                tb_cnt <= 0;
            else
                tb_op <= OP_PASS;   wait for 50 ns;
                tb_op <= OP_ADD;    wait for 50 ns;
                tb_op <= OP_SUB;    wait for 50 ns;
                tb_op <= OP_SHL;    wait for 50 ns;
                tb_op <= OP_SHR;    wait for 50 ns;
                tb_op <= OP_COMP;   wait for 50 ns;
                tb_op <= OP_XOR;    wait for 50 ns;
                tb_op <= OP_AND;    wait for 50 ns;
                tb_op <= OP_NAND;   wait for 50 ns;
                tb_op <= OP_OR;     wait for 50 ns;
                tb_op <= OP_NOR;    wait for 50 ns;
                
                tb_cnt <= tb_cnt + 1;
        end if;
            
    end process proc_op;
        
    proc_stim : process
    begin
        
        tb_rst <= '1' after 00 ns, '0' after 10 ns;
        
        tb_a <= x"AA" after 00 ns, x"66" after 550 ns, x"23" after 1100 ns;
        tb_b <= x"45" after 00 ns, x"66" after 550 ns, x"41" after 1100 ns;
        
        
        
        report "End of simulation.";
    wait;
    end process proc_stim;

end behavioral;
