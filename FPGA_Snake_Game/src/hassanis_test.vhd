----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2023 03:22:12 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is

port(          clk : in std_logic;         -- 100MHz system clock      
               reset : in std_logic;       -- active high system reset
               VGA_hs : out std_logic;      -- VGA screen output
               VGA_vs : out std_logic;
               VGA_color : out std_logic_vector (11 downto 0));
end test;

architecture Behavioral of test is
signal s_clk : std_logic;
signal s_reset : std_logic;
signal s_VGA_hs : std_logic;
signal s_VGA_vs : std_logic;
signal s_VGA_color : std_logic_vector (11 downto 0);
signal s_data_in : std_logic_vector(11 downto 0);
signal s_data_write : std_logic;
signal s_pixx : std_logic_vector(8 downto 0);
signal s_pixy : std_logic_vector(7 downto 0);
signal i_pixx : integer :=55;
signal i_pixy : integer :=55;
signal i_cl : integer :=0;

component VGA_bitmap_320x240 is
    generic(CLK_FREQ : integer := 100000000;         -- clk frequency, must be multiple of 25M
            RAM_BPP  : integer range 1 to 12:= 12;    -- number of bits per pixel for display
            HARD_BPP : integer range 1 to 16:=12;    -- number of bits per pixel actually available in hardware
            INDEXED  : integer range 0 to  1:= 0;    -- colors are indexed (1) or directly coded from RAM value (0)
            READBACK : integer range 0 to  1:= 1);   -- readback enabled ? might save some resources
    port(clk          : in  std_logic;
         reset        : in  std_logic;
         VGA_hs       : out std_logic;   -- horisontal vga syncr.
         VGA_vs       : out std_logic;   -- vertical vga syncr.
         VGA_color    : out std_logic_vector(HARD_BPP - 1 downto 0);

         pixel_x      : in  std_logic_vector(8 downto 0);
         pixel_y      : in  std_logic_vector(7 downto 0);
         data_in      : in  std_logic_vector( RAM_BPP - 1 downto 0);
         data_write   : in  std_logic;
         data_read    : in  std_logic:='0';
         data_rout    : out std_logic;
         data_out     : out std_logic_vector( RAM_BPP - 1 downto 0);
         
         end_of_frame : out std_logic;

         palette_w    : in  std_logic:='0';
         palette_idx  : in  std_logic_vector( RAM_BPP - 1 downto 0):=(others => '0');
         palette_val  : in  std_logic_vector(HARD_BPP - 1 downto 0):=(others => '0'));
end component;

begin
process(clk,reset)
begin
if(reset = '1') then 
    i_cl <= 0;
    elsif(clk'event and clk='1') then
        if(i_cl < 25600) then
            i_cl <= i_cl+1;
             s_data_write <= '1';
        end if;
    end if;
end process;

display_module : entity work.vga_bitmap_320x240
      generic map(RAM_BPP  => 12,            -- number of bits per pixels
                  INDEXED  => 0,            -- do not used indexed colors
                  READBACK => 0)            -- read from bitmap memory disabled
                  
      port map(clk          => s_clk,         -- 100MHz system clock      
               reset        => s_reset,       -- active high system reset
               
               VGA_hs       => s_VGA_hs,      -- VGA screen output
               VGA_vs       => s_VGA_vs,
               VGA_color    => s_VGA_color,
               
               pixel_x      => s_pixx,     -- pixel horizontal coordinate
               pixel_y      => s_pixy,     -- pixel vertical coordinate
               data_in      => s_data_in,     -- new color for the addressed pixel
               data_write   => s_data_write); -- write order
process(clk,reset)
begin
if(reset = '1') then 
    i_pixx <= 50;
    i_pixy <= 50;
    elsif(clk'event and clk='1') then
    if(i_pixx<210  ) then
        i_pixx <= i_pixx + 1;
    else 
        i_pixx <= 50;
        if (i_pixy < 210) then
            i_pixy <= i_pixy +1;
        else
            i_pixy <=50;
            end if;
     end if;
    end if;
end process;


process(i_pixy,i_pixx)
begin
    if (i_pixy=50 or i_pixy=210 or i_pixx=50 or i_pixx=210) then
        s_data_in <= "000000001111";
    else
        s_data_in <= "111111111111";
    end if;
end process;


s_pixx <= std_logic_vector(to_unsigned(i_pixx,9));
s_pixy <= std_logic_vector(to_unsigned(i_pixy,8));
s_clk <= clk;
s_reset <= reset;
VGA_hs <= s_VGA_hs;
VGA_vs <= s_VGA_vs;
VGA_color <= s_VGA_color;
end Behavioral;
