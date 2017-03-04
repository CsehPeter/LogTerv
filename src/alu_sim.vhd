----------------------------------------------------------------------------------
-- Company:     BME
-- Engineer:    Nagy Tímea(O5D5VN), Cseh Péter (DM5HMB)
-- 
-- Create Date: 20.02.2017 23:18:47
-- Design Name: alu
-- Module Name: alu_sim - Behavioral
-- Project Name: 
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
    signal tb_op      : std_logic_vector((OP_WIDTH - 1) downto 0) := (others => '0');
    
    signal tb_i_flag  : t_flag_bus := (others => '0');
    
    signal tb_y       : std_logic_vector((DATA_WIDTH - 1) downto 0) := (others => '0');
    signal tb_o_flag  : t_flag_bus := (others => '0');
    
    signal tb_cnt : integer range 0 to 10 := 0;    

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
        if(tb_cnt > 10) then
            tb_cnt <= 0;
        else
            tb_op <= std_logic_vector(to_unsigned(tb_cnt, OP_WIDTH));
            tb_cnt <= tb_cnt + 1;
        end if;
        wait for 50 ns;
    end process proc_op;
        
    proc_stim : process
    begin
        
        tb_rst <= '1' after 00 ns, '0' after 10 ns;
        
        tb_a <= x"AA" after 00 ns;  --Add without input or output carry
        tb_b <= x"55" after 00 ns;
        
        
        
        report "End of simulation.";
    wait;
    end process proc_stim;

end behavioral;
