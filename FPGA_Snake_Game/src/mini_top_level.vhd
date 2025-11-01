----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 11:37:59
-- Design Name: 
-- Module Name: mini_top_level - Behavioral
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

entity top_level is
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
end top_level;

architecture Behavioral of top_level is

component init_VGA is 
    Port ( clk : in STD_LOGIC;
            reset:  in STD_LOGIC;
           write : out std_logic;
           data : out std_logic_vector ( 11 downto 0);
           row : out STD_LOGIC_VECTOR (8 downto 0);
           collumn : out STD_LOGIC_VECTOR (7 downto 0);
            init_complete: out std_logic;
           init_vga : in std_logic);
end component;

component VGA_bitmap_320x240 is
    generic(CLK_FREQ : integer := 100000000;         -- clk frequency, must be multiple of 25M
            RAM_BPP  : integer range 1 to 12:= 1;    -- number of bits per pixel for display
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

component detec_impulsion
     Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end component;

component  gestion_freq is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           play : in std_logic;
           ce_chrono : out STD_LOGIC;
           ce_mvt : out STD_LOGIC;
           score_uni : in STD_LOGIC_VECTOR (3 downto 0);
           score_dec : in STD_LOGIC_VECTOR (3 downto 0);
           score_cent : in STD_LOGIC_VECTOR (3 downto 0);
           ce_7seg: out std_logic);
end component;

component  FSM is
        Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           b_up : in STD_LOGIC;
           b_center: in std_logic;
           b_down : in STD_LOGIC;
           b_left : in STD_LOGIC;
           b_right : in STD_LOGIC;
           collision : in std_logic; 
           left : out STD_LOGIC;
           right : out STD_LOGIC;
           up : out STD_LOGIC;
           down : out STD_LOGIC;
           stop : out STD_LOGIC;
           play : out STD_LOGIC;
           init_snake: out std_logic;
           init_vga: out std_logic;
           mort : out STD_LOGIC );
end component;

component  gestion_mvt is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           left : in STD_LOGIC;
           right : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           play : in STD_LOGIC;
           ce_mvt: in STD_LOGIC;
            xb: in std_logic_vector(8 downto 0);
           yb: in  std_logic_vector(7 downto 0);
           x: out std_logic_vector(8 downto 0);
           y: out  std_logic_vector(7 downto 0);
           write : out std_logic;
           data: out std_logic_vector(11 downto 0);
           collision : out std_logic;
           init_snake: in std_logic;
           init_vga: in std_logic;
           incr : out std_logic );
end component;

component generateur_aleatoire is
   port(clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           xb : out STD_LOGIC_VECTOR (8 downto 0);
           yb : out STD_LOGIC_VECTOR (7 downto 0));
end component ;

component  gestion_instructions is
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
           
end component;


component multiplx is
    Port (  init_complete : in std_logic;
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
end component;

component chronometre is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ch_uni : out STD_LOGIC_VECTOR (3 downto 0);
           ch_dec : out STD_LOGIC_VECTOR (3 downto 0);
           ch_cent : out STD_LOGIC_VECTOR (3 downto 0);
           ce_chrono : in std_logic;
           play: in std_logic);
end component;

component trans is
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
end component;

component mod8
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce_7seg : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           sortie : out STD_LOGIC_VECTOR (2 downto 0));
             end component;  
component mux8
    Port ( commande : in STD_LOGIC_VECTOR (2 downto 0);
    E0,E1,E2,E3,E4,E5,E6,E7 : in std_logic_vector(6 downto 0);
    S: out std_logic_vector(6 downto 0);
    DP : out std_logic);
    end component;
    
    
    component score is
    Port     ( clk : in STD_LOGIC;
             reset : in STD_LOGIC;
             incr :  in std_logic;
             play: in std_logic;
             score_uni : out STD_LOGIC_VECTOR (3 downto 0);
             score_dec : out STD_LOGIC_VECTOR (3 downto 0);
             score_cent : out STD_LOGIC_VECTOR (3 downto 0));
    end component ;

    
--  signal declaration

-- random genrator signals

signal s_xb : std_logic_vector(8 downto 0);
signal s_yb : std_logic_vector(7 downto 0);

--input signals
signal s_clk , s_reset : std_logic;
signal s_bouton_left, s_bouton_right, s_bouton_up, s_bouton_down: std_logic;

--impulsion detect signals
signal S_BOUTON_CENTER, s_B_UP,s_B_DOWN,s_B_LEFT,s_B_RIGHT,s_B_CENTER: std_logic;

-- gestion frequence signals
signal s_ce_mvt ,s_ce_chrono, s_ce_7seg : std_logic;

-- FSM signals
signal s_up, s_down, s_right, s_left, s_mort, s_stop, s_play : std_logic;
signal s_stop_mort : std_logic;
signal s_init_vga, s_init_snake : std_logic;

--init_vga singals
signal s_x_init : std_logic_vector(8 downto 0);
signal s_write_init  : std_logic;
signal s_y_init: std_logic_vector(7 downto 0);
signal s_init_complete : std_logic;
signal s_data_init: std_logic_vector(11 downto 0);

-- gestion_mvt signals
signal s_write_mvt  : std_logic;
signal  s_data_mvt: std_logic_vector(11 downto 0);
signal s_x_mvt: std_logic_vector(8 downto 0);
signal  s_y_mvt: std_logic_vector(7 downto 0);
signal s_collision: std_logic ;
signal s_incr: std_logic;

-- vga_module signals
signal s_VGA_hs : std_logic;
signal s_VGA_vs : std_logic;
signal s_VGA_color : std_logic_vector (11 downto 0);
signal s_data_in : std_logic_vector(11 downto 0);
signal s_data_write : std_logic;
signal s_pixx : std_logic_vector(8 downto 0);
signal s_pixy : std_logic_vector(7 downto 0);

-- chronometre signals
signal s_ch_uni_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_ch_dec_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_ch_cent_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_ch_uni, s_ch_dec, s_ch_cent : std_logic_vector (3 downto 0);

--score signals
signal s_score_uni_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_score_dec_7 : STD_LOGIC_VECTOR(6 downto 0);
signal s_score_cent_7 : STD_LOGIC_VECTOR(6 downto 0);

signal s_score_uni, s_score_dec, s_score_cent : std_logic_vector(3 downto 0);

-- 7seg signals
signal s_AN : STD_LOGIC_VECTOR( 7 DOWNTO 0);
signal s_commande: std_logic_vector(2 downto 0);
signal s_DP:  std_logic;
signal s_S : STD_LOGIC_VECTOR(6 downto 0);
signal s_E3, s_E4 ,s_E5,s_E6, s_E7 : STD_LOGIC_VECTOR(6 downto 0) :="1111111";

--gestion_instructions
signal s_write_dead  : std_logic;
signal  s_data_dead: std_logic_vector(11 downto 0);
signal s_x_dead: std_logic_vector(8 downto 0);
signal  s_y_dead: std_logic_vector(7 downto 0);
signal s_instruction_complete: std_logic;

begin

--input assignements
s_clk <= clk;
s_reset <= reset;
s_bouton_right <=bouton_right;
s_bouton_left <=bouton_left;
s_bouton_up <=bouton_up;
s_bouton_down <=bouton_down;
s_bouton_center <=bouton_center;

--output assignements
VGA_hs <= s_VGA_hs;
VGA_vs <= s_VGA_vs;
VGA_color <= s_VGA_color;

S <= s_S;
DP <= s_DP;
AN <= s_AN;

s_stop_mort <= s_stop xor s_mort;


initVGA: init_VGA
port map(clk => s_clk,
                reset => s_reset,
           write => s_write_init,
           data => s_data_init,
           row => s_x_init,
           collumn => s_y_init,
           init_complete => s_init_complete,
           init_vga => s_init_vga);
           
gestionInstructions: gestion_instructions
port map(clk => s_clk,
                reset => s_reset,
           write => s_write_dead,
           mort => s_mort,
           data => s_data_dead,
           play => s_play,
           row => s_x_dead,
           collumn => s_y_dead,
           instruction_complete => s_instruction_complete,
           collision=>s_collision);
           
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
               data_write   => s_data_write);    
               
inst_detec_impulsion_HD1 : detec_impulsion
port map( clk=> s_clk,
                input => s_BOUTON_CENTER,
                output => s_B_CENTER);

inst_detec_impulsion_HD2 : detec_impulsion
port map( clk=> s_clk,
                input => s_BOUTON_DOWN,
                output => s_B_DOWN);
                
 inst_detec_impulsion_HD3 : detec_impulsion
port map( clk=> s_clk,
                input => s_BOUTON_LEFT,
                output => s_B_Left);
                
inst_detec_impulsion_HD4 : detec_impulsion
port map( clk=> s_clk,
                input => s_BOUTON_RIGHT,
                output => s_B_RIGHT);

inst_detec_impulsion_HD5 : detec_impulsion
port map( clk=> s_clk,
                input => s_BOUTON_UP,
                output => s_B_UP);
                
inst_gestion_freq: gestion_freq
port map( clk=> s_clk,
                reset => s_reset,
               ce_mvt => s_ce_mvt,
               play => s_play,
               ce_chrono => s_ce_chrono,
               ce_7seg => s_ce_7seg,
               score_uni => s_score_uni,
                score_dec => s_score_dec,
                 score_cent => s_score_cent);

inst_FSM: FSM
port map( clk=> s_clk,
                rst => s_reset,
               B_center => s_B_center,
               B_UP => s_B_UP,
               B_DOWN => s_B_DOWN,
               B_RIGHT => s_B_RIGHT,
               B_LEFT => s_B_LEFT,
                left => s_left,
                right => s_right,
                up => s_up,
                down => s_down,
                play => s_play,
                collision => s_collision,
                mort => s_mort,
                stop => s_stop,
                init_vga => s_init_vga,
                init_snake => s_init_snake);
                
inst_gestion_mvt: gestion_mvt
port map( clk=> s_clk,
                reset => s_reset,
                ce_mvt => s_ce_mvt,
                left => s_left,
                right => s_right,
                up => s_up,
                down => s_down,
                xb => s_xb,
                yb => s_yb,
                play => s_play,
                x=> s_x_mvt,
                y=> s_y_mvt,
                data => s_data_mvt,
                write => s_write_mvt,
                init_snake => s_init_snake,
                init_vga => s_init_vga,
                collision => s_collision,
                incr => s_incr);          
                
inst_multiplx: multiplx
port map( init_complete => s_init_complete,
            instruction_complete => s_instruction_complete,
            x_init => s_x_init,
           y_init => s_y_init,
          x_mvt => s_x_mvt ,
           y_mvt  => s_y_mvt, 
           x_dead => s_x_dead,
           y_dead => s_y_dead,
           write_dead => s_write_dead,
           data_dead => s_data_dead,
           write_init  => s_write_init,
           data_init => s_data_init,
           write_mvt => s_write_mvt,
           data_mvt => s_data_mvt,
           write => s_data_write,
           data => s_data_in,
           
           x => s_pixx,
           y =>s_pixy);                            
               
 inst_chrono:  chronometre
 port map(clk => s_clk,
                reset => s_reset,
           play => s_play,
           ce_chrono=> s_ce_chrono,
           ch_uni => s_ch_uni,
           ch_dec => s_ch_dec,
           ch_cent => s_ch_cent);
               
inst_trans: trans
port map(ch_uni => s_ch_uni,
           ch_dec => s_ch_dec,
           ch_cent => s_ch_cent,
           score_uni => s_score_uni,
           score_dec => s_score_dec,
           score_cent => s_score_cent,
           ch_uni_7 => s_ch_uni_7,
           ch_dec_7 => s_ch_dec_7,
           ch_cent_7 => s_ch_cent_7,
           score_uni_7 => s_score_uni_7,
           score_dec_7 => s_score_dec_7,
           score_cent_7 => s_score_cent_7);               
               
inst_mod8: mod8
port map(     rst => s_reset,
              clk => s_clk,
              ce_7seg => s_ce_7seg,
              AN => s_AN,
              sortie => s_commande);
              
              
inst_mux8: mux8
port map( commande => s_commande,
                 E0 =>s_ch_uni_7 ,
                 E1 =>s_ch_dec_7 ,   
                 E2 => s_ch_cent_7,
                 E3 => s_E3,
                 E4 => s_E4,
                 E5 => s_score_uni_7,
                 E6 =>  s_score_dec_7,
                 E7 =>  s_score_cent_7,
                DP => s_DP,
                S => s_S);
                
  inst_generateur_aleatoire : generateur_aleatoire  
port map (  clk => s_clk,
            rst => s_reset,  
            xb => s_xb,
            yb => s_yb);
            
      inst_score: score
      port map(clk => s_clk,
                     reset => s_reset,
                     score_uni => s_score_uni,
                       score_dec => s_score_dec,
                       score_cent => s_score_cent,
                       play => s_play,
                       incr => s_incr);                     
                     
                     
                     
                     
                     
                     
            
 
            
                    

end Behavioral;
