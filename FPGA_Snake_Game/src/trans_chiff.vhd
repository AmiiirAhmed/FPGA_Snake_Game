----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2023 10:18:40
-- Design Name: 
-- Module Name: trans_chiff - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trans_chiff is
    Port ( ch_bin : in STD_LOGIC_VECTOR (3 downto 0);
           ch_7_seg : out STD_LOGIC_VECTOR (6 downto 0));
end trans_chiff;

architecture Behavioral of trans_chiff is

begin

    process(ch_bin) 
         begin
            if (ch_bin ="0001") then
                    ch_7_seg <= "1111001";
            elsif (ch_bin ="0010") then
                    ch_7_seg <= "0100100";
            elsif (ch_bin ="0011") then
                    ch_7_seg <= "0110000";
            elsif (ch_bin ="0100") then
                    ch_7_seg <= "0011001";
            elsif (ch_bin ="0101") then
                    ch_7_seg <= "0010010";
            elsif (ch_bin ="0110") then
                    ch_7_seg <= "0000010";
            elsif (ch_bin ="0111") then  
                    ch_7_seg <= "1111000";
            elsif (ch_bin ="1000") then 
                    ch_7_seg <= "0000000";
            elsif (ch_bin ="1001") then
                    ch_7_seg <= "0010000";
            elsif (ch_bin ="0000") then
                    ch_7_seg <= "1000000";
            end if;
    end process;
end Behavioral;
