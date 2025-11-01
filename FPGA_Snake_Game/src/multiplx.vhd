----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2023 13:33:58
-- Design Name: 
-- Module Name: multiplx - Behavioral
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

entity multiplx is
    Port ( init_complete : in std_logic;
           instruction_complete : in std_logic;
           x_init : in STD_LOGIC_VECTOR (8 downto 0);
           y_init : in STD_LOGIC_VECTOR (7 downto 0);
           x_mvt : in STD_LOGIC_VECTOR (8 downto 0);
           y_mvt : in STD_LOGIC_VECTOR (7 downto 0);
           x_dead : in STD_LOGIC_VECTOR (8 downto 0);
           y_dead : in STD_LOGIC_VECTOR (7 downto 0);
           write_init : in std_logic;
           data_init: in std_logic_vector(11 downto 0);
           write_mvt : in std_logic;
           data_mvt: in std_logic_vector(11 downto 0);
           write_dead : in std_logic;
           data_dead :in std_logic_vector(11 downto 0);
           write : out std_logic; 
           data : out std_logic_vector ( 11 downto 0);
           x : out STD_LOGIC_VECTOR (8 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end multiplx;

architecture Behavioral of multiplx is

begin

process(init_complete,instruction_complete,x_mvt, y_mvt, x_init, y_init  )
begin
    if (init_complete ='0') then
        write <= write_init;
        data <= data_init;
        x<= x_init;
        y<= y_init;
    elsif(instruction_complete ='0') then
        write <= write_dead;
        data <= data_dead;
        x<= x_dead;
        y<= y_dead;
    else
        write <= write_mvt;
        data <= data_mvt;
        x<= x_mvt;
        y<= y_mvt;
     end if;   
end process;

end Behavioral;
