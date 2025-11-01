----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2023 11:40:46
-- Design Name: 
-- Module Name: mux8 - Behavioral
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

entity mux8 is
    Port ( commande : in STD_LOGIC_VECTOR (2 downto 0);
    E0,E1,E2,E3,E4,E5,E6,E7 : in std_logic_vector(6 downto 0);
    S: out std_logic_vector(6 downto 0);
    DP : out std_logic);
end mux8;

architecture Behavioral of mux8 is
begin
process(commande)
begin
    if (commande ="000") then
        S <= E0;
     elsif (commande ="001") then
         S <= E1;
    elsif (commande ="010") then
         S <= E2;
      elsif (commande ="011") then
        S <= E3;
      elsif (commande ="100") then
         S <= E4;
      elsif (commande ="101") then
        S  <= E5;
      elsif (commande ="110") then
        S <= E6;
       elsif (commande ="111") then
         S <= E7;
         end if;
end process;
DP <='1';

end Behavioral;
