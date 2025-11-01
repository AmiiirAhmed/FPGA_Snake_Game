----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2023 15:11:57
-- Design Name: 
-- Module Name: mod8 - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod8 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce_7seg : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           sortie : out STD_LOGIC_VECTOR (2 downto 0));
end mod8;

architecture Behavioral of mod8 is
 signal count :  unsigned(2 downto 0) :="000";
 signal s_AN: unsigned(7 downto 0) := "11111110";

begin
 process(clk, rst)
 begin

    if (clk'event and clk='1') then
         if(rst = '1') then
            count <= (others => '0');
            s_AN <="11111110";
        else
            if (ce_7seg = '1') then
               if (count="111") then
                    count<= "000";
               else
                    count <= count +1;
               end if;
               if ( s_AN= "11111110") then
                    s_AN <= "11111101";
                elsif(s_AN = "11111101") then
                    s_AN <= "11111011";
                elsif(s_AN = "11111011") then
                    s_AN <= "11110111";
                elsif(s_AN = "11110111") then
                    s_AN <= "11101111";
                elsif(s_AN = "11101111") then
                   s_AN <= "11011111";
                elsif(s_AN = "11011111") then   
                    s_AN <= "10111111";
                    elsif(s_AN = "10111111") then   
                    s_AN <= "01111111";
                elsif( s_AN <= "01111111") then
                    s_AN <= "11111110";
                end if;
            end if;
       end if;
  end if;
      AN <= std_logic_vector(s_AN);
      sortie <= std_logic_vector(count);
    end process;
end Behavioral;
