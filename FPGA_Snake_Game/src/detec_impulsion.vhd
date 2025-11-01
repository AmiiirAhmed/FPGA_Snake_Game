----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2023 14:25:06
-- Design Name: 
-- Module Name: detec_impulsion - Behavioral
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

entity detec_impulsion is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end detec_impulsion;

architecture Behavioral of detec_impulsion is

signal ex_input :  std_logic  :='0';

begin
process(clk)
begin
    if (clk'event and clk='1') then
        if (input ='1' and ex_input='0') then 
            output<= '1';
        else
            output<= '0';
        end if;
        ex_input <=input;
    end if;
end process;
end Behavioral;
