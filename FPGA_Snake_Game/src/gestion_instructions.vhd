----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2023 10:01:09
-- Design Name: 
-- Module Name: gestion_instructions - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_instructions is
    Port ( clk : in STD_LOGIC;
            reset: in std_logic;
            play: in std_logic;
            collision: in std_logic;
            instruction_complete: out std_logic;
            write : out std_logic;
           data : out std_logic_vector ( 11 downto 0);
           row : out STD_LOGIC_VECTOR (8 downto 0);
           collumn : out STD_LOGIC_VECTOR (7 downto 0);
           mort: in std_logic
           );
           
end gestion_instructions;

architecture Behavioral of gestion_instructions is
TYPE ded IS ARRAY (0 TO 603) OF integer;
signal dead_inst: ded:= (51, 132, 51, 136, 51, 139, 51, 140, 51, 143, 51, 146, 51, 151, 51, 152, 51, 155, 51, 156, 51, 157, 51, 160, 51, 161, 51, 162, 51, 163, 51, 167, 51, 168, 51, 169, 51, 172, 51, 173, 51, 174, 51, 175, 51, 178, 51, 179, 51, 182, 51, 183, 51, 184, 52, 132, 52, 136, 52, 138, 52, 141, 52, 143, 52, 146, 52, 150, 52, 153, 52, 155, 52, 158, 52, 160, 52, 167, 52, 170, 52, 172, 52, 177, 52, 180, 52, 182, 52, 185, 53, 133, 53, 134, 53, 135, 53, 138, 53, 141, 53, 143, 53, 146, 53, 150, 53, 151, 53, 152, 53, 153, 53, 155, 53, 156, 53, 157, 53, 160, 53, 161, 53, 162, 53, 167, 53, 170, 53, 172, 53, 173, 53, 174, 53, 177, 53, 178, 53, 179, 53, 180, 53, 182, 53, 185, 54, 134, 54, 138, 54, 141, 54, 143, 54, 146, 54, 150, 54, 153, 54, 155, 54, 157, 54, 160, 54, 167, 54, 170, 54, 172, 54, 177, 54, 180, 54, 182, 54, 185, 55, 134, 55, 139, 55, 140, 55, 144, 55, 145, 55, 150, 55, 153, 55, 155, 55, 158, 55, 160, 55, 161, 55, 162, 55, 163, 55, 167, 55, 168, 55, 169, 55, 172, 55, 173, 55, 174, 55, 175, 55, 177, 55, 180, 55, 182, 55, 183, 55, 184, 58, 123, 58, 124, 58, 125, 58, 128, 58, 129, 58, 130, 58, 133, 58, 134, 58, 135, 58, 136, 58, 139, 58, 140, 58, 141, 58, 144, 58, 145, 58, 146, 58, 150, 58, 151, 58, 152, 58, 156, 58, 157, 58, 160, 58, 163, 58, 165, 58, 166, 58, 167, 58, 168, 58, 169, 58, 172, 58, 173, 58, 176, 58, 179, 58, 184, 58, 185, 58, 188, 58, 189, 58, 190, 58, 191, 58, 193, 58, 196, 58, 198, 58, 199, 58, 200, 58, 201, 58, 202, 58, 204, 58, 205, 58, 206, 58, 207, 58, 209, 58, 210, 58, 211, 59, 123, 59, 126, 59, 128, 59, 131, 59, 133, 59, 138, 59, 143, 59, 150, 59, 153, 59, 155, 59, 158, 59, 160, 59, 163, 59, 167, 59, 171, 59, 174, 59, 176, 59, 177, 59, 179, 59, 183, 59, 186, 59, 188, 59, 193, 59, 194, 59, 196, 59, 200, 59, 204, 59, 209, 59, 212, 60, 123, 60, 124, 60, 125, 60, 128, 60, 129, 60, 130, 60, 133, 60, 134, 60, 135, 60, 139, 60, 140, 60, 144, 60, 145, 60, 150, 60, 151, 60, 152, 60, 155, 60, 158, 60, 160, 60, 163, 60, 167, 60, 171, 60, 174, 60, 176, 60, 178, 60, 179, 60, 183, 60, 188, 60, 189, 60, 190, 60, 193, 60, 195, 60, 196, 60, 200, 60, 204, 60, 205, 60, 206, 60, 209, 60, 210, 60, 211, 61, 123, 61, 128, 61, 130, 61, 133, 61, 141, 61, 146, 61, 150, 61, 153, 61, 155, 61, 158, 61, 160, 61, 163, 61, 167, 61, 171, 61, 174, 61, 176, 61, 179, 61, 183, 61, 186, 61, 188, 61, 193, 61, 196, 61, 200, 61, 204, 61, 209, 61, 211, 62, 123, 62, 128, 62, 131, 62, 133, 62, 134, 62, 135, 62, 136, 62, 138, 62, 139, 62, 140, 62, 143, 62, 144, 62, 145, 62, 150, 62, 151, 62, 152, 62, 156, 62, 157, 62, 161, 62, 162, 62, 167, 62, 172, 62, 173, 62, 176, 62, 179, 62, 184, 62, 185, 62, 188, 62, 189, 62, 190, 62, 191, 62, 193, 62, 196, 62, 200, 62, 204, 62, 205, 62, 206, 62, 207, 62, 209, 62, 212);

signal i_cl : integer :=0;
--signal x_in_play : integer := 2 ;
--signal y_in_play : integer := 2;
signal x : integer := 132 ;
signal y : integer := 51;
signal s_write : std_logic;
signal s_data : std_logic_vector(11 downto 0);
signal s_instruction_complete: std_logic := '1';
begin

 process(clk,reset,play)
begin

   if(clk'event and clk='1') then
        if (reset ='1' or play ='1' or  mort ='0') then
        i_cl<=0;
        elsif(i_cl < 301) then
            i_cl <= i_cl+1;
             s_write <= '1';
             s_instruction_complete <='0';
         else
             s_instruction_complete <='1';
        end if;
    end if;
end process;


process(clk, reset, i_cl)
begin
   if (clk'event and clk='1') then
     if (reset ='1' or play='1'or  mort ='0' ) then
        x<=0;
        y<=0;
     else 
        y<= dead_inst(i_cl*2);
        x<= dead_inst(i_cl*2+1);
    end if;
  end if;
end process;


s_data <= "000000001111"; 
data <= s_data;
write <= s_write;
row <= std_logic_vector(to_unsigned(x,9));
collumn <= std_logic_vector(to_unsigned(y,8));   
instruction_complete <= s_instruction_complete;
end Behavioral;
