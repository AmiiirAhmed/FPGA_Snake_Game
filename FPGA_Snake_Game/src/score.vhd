----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2023 10:02:02 AM
-- Design Name: 
-- Module Name: score - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity score is
    Port     ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             incr :  in std_logic;
             play: in std_logic;
             score_uni : out STD_LOGIC_VECTOR (3 downto 0);
             score_dec : out STD_LOGIC_VECTOR (3 downto 0);
             score_cent : out STD_LOGIC_VECTOR (3 downto 0));
    end score ;


architecture Behavioral of score is

signal count_val_unit : unsigned(3 downto 0) := "0000";
signal count_val_dec :  unsigned(3 downto 0) := "0000";
signal count_val_cent : unsigned(3 downto 0) := "0000";


begin
    process(clk,reset)
    begin
	   if (clk'event and clk='1') then
	        if (reset='1' or play='0') then
                count_val_unit <= "0000";
                count_val_dec <= "0000";
                count_val_cent <= "0000";
            elsif (play = '1') then
                if (incr = '1') then 
                       if (count_val_unit<9) then
                            count_val_unit <= count_val_unit + 1;
                       else
                            count_val_unit <= "0000";
                            if (count_val_dec < 9) then
                                
                                count_val_dec <= count_val_dec + 1;
                            else
                                  count_val_dec <= "0000";
                                  if (count_val_cent < 9) then
                                    count_val_cent <= count_val_cent + 1;
                                  else
                                    count_val_cent <= "0000";
                                  end if; 
                            end if;
                       end if;
                    end if;
                end if;
        score_uni <= std_logic_vector(count_val_unit);
       score_dec <= std_logic_vector(count_val_dec);
       score_cent <= std_logic_vector(count_val_cent);
             end if;


	end process;
end Behavioral;



