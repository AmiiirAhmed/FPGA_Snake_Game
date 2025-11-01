----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2023 23:17:04
-- Design Name: 
-- Module Name: generateur_aleatoire - Behavioral
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
use IEEE.MATH_REAL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity generateur_aleatoire is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           xb : out STD_LOGIC_VECTOR (8 downto 0);
           yb : out STD_LOGIC_VECTOR (7 downto 0));
end generateur_aleatoire;

architecture Behavioral of generateur_aleatoire is

signal cmp1 : integer :=200 ;
signal cmp2 : integer :=200 ;
begin
    process(clk,rst)
     begin
        if(clk'event and clk='1')then
            if(rst='1')then
               cmp1 <= 200;
               cmp2 <= 200;
            else
                if(cmp1=229)then
                     cmp1 <= 71 ;
                else
                     cmp1 <= cmp1+1; 
                    if(cmp2=229)then
                         cmp2 <= 71 ;
                    else
                         cmp2 <= cmp2+1;
                    end if;
                end if;       
             end if;
         end if;
      end process;
   
xb <= std_logic_vector(TO_UNSIGNED(cmp1,9));
yb <= std_logic_vector(TO_UNSIGNED(cmp2,8));


end Behavioral;
