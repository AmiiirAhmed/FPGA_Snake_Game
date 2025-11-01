----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2023 15:25:21
-- Design Name: 
-- Module Name: trans - Behavioral
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

entity trans is
    Port (ch_uni :  STD_LOGIC_VECTOR (3 downto 0);
           ch_dec : in STD_LOGIC_VECTOR (3 downto 0);
           ch_cent : in STD_LOGIC_VECTOR (3 downto 0);
            score_uni : in STD_LOGIC_VECTOR (3 downto 0);
            score_dec : in STD_LOGIC_VECTOR (3 downto 0);
            score_cent : in STD_LOGIC_VECTOR (3 downto 0);
            score_uni_7 : out STD_LOGIC_VECTOR (6 downto 0);
             score_dec_7 : out STD_LOGIC_VECTOR (6 downto 0);
             score_cent_7 : out STD_LOGIC_VECTOR (6 downto 0);        
           ch_uni_7 : out STD_LOGIC_VECTOR (6 downto 0);
           ch_dec_7 : out STD_LOGIC_VECTOR (6 downto 0);
           ch_cent_7 : out STD_LOGIC_VECTOR (6 downto 0));
end trans;

architecture Behavioral of trans is


component trans_chiff
port(ch_bin : in STD_LOGIC_VECTOR (3 downto 0);
           ch_7_seg : out STD_LOGIC_VECTOR (6 downto 0));
 end  component;
 
 signal s_ch_uni : STD_LOGIC_VECTOR(3 downto 0);
signal s_ch_dec : STD_LOGIC_VECTOR(3 downto 0);
signal s_ch_cent : STD_LOGIC_VECTOR(3 downto 0);
 signal s_score_uni : STD_LOGIC_VECTOR(3 downto 0);
signal s_score_dec : STD_LOGIC_VECTOR(3 downto 0);
signal s_score_cent : STD_LOGIC_VECTOR(3 downto 0);

signal s_ch_uni_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_ch_dec_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_ch_cent_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_score_uni_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_score_dec_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_score_cent_7 : STD_LOGIC_VECTOR(6 downto 0);

begin

s_ch_uni <= ch_uni;
s_ch_dec <= ch_dec;
s_ch_cent <= ch_cent;

s_score_uni <= score_uni;
s_score_dec <= score_dec;
s_score_cent <= score_cent;

 score_uni_7 <= s_score_uni_7;
 score_dec_7 <= s_score_dec_7;
score_cent_7 <= s_score_cent_7;


 ch_uni_7 <= s_ch_uni_7;
 ch_dec_7 <= s_ch_dec_7;
 ch_cent_7 <= s_ch_cent_7;

inst_trans_chrono_unit: trans_chiff
port map(ch_bin=> s_ch_uni,
                ch_7_seg => s_ch_uni_7);
                
inst_trans_chrono_dec: trans_chiff
port map(ch_bin=> s_ch_dec,
                ch_7_seg => s_ch_dec_7);
                
inst_trans_chrono_cent: trans_chiff
port map(ch_bin=> s_ch_cent,
                ch_7_seg => s_ch_cent_7);
                
inst_trans_score_unit: trans_chiff
port map(ch_bin=> s_score_uni,
                ch_7_seg => s_score_uni_7);
                
inst_trans_score_dec: trans_chiff
port map(ch_bin=> s_score_dec,
                ch_7_seg => s_score_dec_7);
                
inst_trans_score_cent: trans_chiff
port map(ch_bin=> s_score_cent,
                ch_7_seg => s_score_cent_7);
                
           
end Behavioral;
