----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 09:47:33
-- Design Name: 
-- Module Name: chronometre - Behavioral
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



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chronometre is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ch_uni : out STD_LOGIC_VECTOR (3 downto 0);
           ch_dec : out STD_LOGIC_VECTOR (3 downto 0);
           ch_cent : out STD_LOGIC_VECTOR (3 downto 0);
           ce_chrono : in std_logic;
           play: in std_logic);
end chronometre;

architecture Behavioral of chronometre is

signal slow_clk : integer := 0;
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
                if (ce_chrono = '1') then 
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
        ch_uni <= std_logic_vector(count_val_unit);
       ch_dec <= std_logic_vector(count_val_dec);
       ch_cent <= std_logic_vector(count_val_cent);
             end if;


	end process;
end Behavioral;

