----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2023 19:54:18
-- Design Name: 
-- Module Name: mini_toplevel_tb - Behavioral
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

entity mini_toplevel_tb is
--  Port ( );
end mini_toplevel_tb;

architecture Behavioral of mini_toplevel_tb is
component top_level is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
            VGA_hs       : out std_logic;   -- horisontal vga syncr.
            VGA_vs       : out std_logic;
            VGA_color     : out std_logic_vector( 11 downto 0);
            BOUTON_UP : in STD_LOGIC;
           BOUTON_DOWN : in STD_LOGIC;
            BOUTON_CENTER : in STD_LOGIC;
           BOUTON_LEFT : in STD_LOGIC;
           BOUTON_RIGHT : in STD_LOGIC;
           S: out std_logic_vector(6 downto 0);
          DP : out std_logic;
         AN :out std_logic_vector(7 downto 0));
  end component;

signal s_bouton_left, s_bouton_right, s_bouton_up, s_bouton_down,S_BOUTON_CENTER:  std_logic;

signal s_clk : std_logic := '0';
signal s_reset : std_logic :='0';
signal s_VGA_hs : std_logic;
signal s_VGA_vs : std_logic;
signal s_VGA_color : std_logic_vector (11 downto 0);
signal s_S: std_logic_vector (6 downto 0);
signal s_DP: std_logic;
signal s_AN : std_logic_vector (7 downto 0);

begin

s_clk <= not s_clk after 5ns;
s_bouton_center <= '0', '1' after 1000us ,'0' after 3000 us ,'1' after 3001 us, '0' after 3002 us, '1' after 4000 us;
--s_reset <= '1', '0' after 100ns;


mini_top: top_level
port map(clk => s_clk,
                reset => s_reset,
                bouton_center => s_bouton_center,
               bouton_UP => s_bouton_UP,
               bouton_DOWN => s_bouton_DOWN,
               bouton_RIGHT => s_bouton_RIGHT,
               bouton_LEFT => s_bouton_LEFT,
               VGA_hs       => s_VGA_hs,      -- VGA screen output
               VGA_vs       => s_VGA_vs,
               VGA_color    => s_VGA_color,
               S => s_S,
               AN => s_AN,
               DP => s_DP);
               
                

end Behavioral;
