----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 09:52:43
-- Design Name: 
-- Module Name: gestion_mvt - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_mvt is
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
           incr: out std_logic;
           init_snake: in std_logic;
           init_vga: in std_logic);
end gestion_mvt;

architecture Behavioral of gestion_mvt is

TYPE snake IS ARRAY (0 TO 99) OF integer;
signal snake_memory: snake :=(100,119,100,118,100,117,100,116,100,115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

signal x0,y0 : integer := 100;
signal s_xt:integer;
signal s_yt: integer;
signal s_xq:integer;
signal s_yq: integer;
signal s_xb:integer:=150;
signal s_yb: integer:=100;
signal s_collision_mur, s_collision_snake: std_logic := '0'; 
signal counter: integer:= 0;
signal check_block: std_logic :='0';
signal cnt: std_logic:='1';
signal max: integer :=9;
signal s_incr: std_logic :='0';
begin
    snake_memory_update: process(clk, reset, s_xb, s_yb, s_xt, s_yt)
     begin
     if (clk'event and clk ='1') then
        if (reset ='1' or init_snake='1' or init_vga='1') then
            snake_memory <= (100,119,100,118,100,117,100,116,100,115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        
            elsif (ce_mvt ='1' and play='1') then
            
                if (right= '1' and snake_memory(1) <230) then
                    update_snake1: for k in 99 downto 2 loop
                        if ( snake_memory(k)/=0) then
                            snake_memory(k) <= snake_memory(k-2);
                        end if;
                    end loop update_snake1;
                    
                    snake_memory(1)<=snake_memory(1)+1;
                    
                                    
                elsif (left= '1' and snake_memory(1) >70) then
                    update_snake2: for k in 99 downto 2 loop
                        if ( snake_memory(k)/=0) then
                            snake_memory(k) <= snake_memory(k-2);
                        end if;
                    end loop update_snake2;
                    snake_memory(1)<=snake_memory(1)-1;
                     
                        
                elsif (up= '1' and snake_memory(0) >70) then
                    update_snake3: for k in 99 downto 2 loop
                        if ( snake_memory(k)/=0) then
                            snake_memory(k) <= snake_memory(k-2);
                        end if;
                    end loop update_snake3;
                    snake_memory(0)<=snake_memory(0)-1;   
                     
                        
                elsif (down= '1' and snake_memory(0) <230) then
                   update_snake4: for k in 99 downto 2 loop
                        if ( snake_memory(k)/=0) then
                            snake_memory(k) <= snake_memory(k-2);
                        end if;
                    end loop update_snake4;
                    snake_memory(0)<=snake_memory(0)+1;  
               
                    
                end if;

            end if;
             if(s_yt=s_yb and s_xt=s_xb) then
                snake_memory(max+1)<=s_yq;
                snake_memory(max+2)<=s_xq;
             end if;
        end if;
    end process snake_memory_update;
    
    
    block_position_check: process(s_xb, s_yb,xb, yb,snake_memory,clk)
    begin
    
     if (clk'event and clk='1') then
         if (reset ='1' or init_snake='1' or init_vga='1') then
        s_xb <=150;
        s_yb <= 100;
        max<=9;
        elsif(s_yt=s_yb and s_xt=s_xb) then
            
             max<= max+2;
            s_xb <= TO_INTEGER(unsigned(xb));
            s_yb <= TO_INTEGER(unsigned(yb));

            block_check: for k in 49 downto 1 loop
                if (snake_memory(2*k)/=0) then
                     if ((std_logic_vector(to_unsigned(snake_memory(2*k),8))= yb ) and (std_logic_vector(to_unsigned(snake_memory(2*k+1),9))=xb)) then
                         check_block<='1';
                     end if;
                end if;
            end loop block_check;

            if (check_block ='1') then
                s_xb <= TO_INTEGER(unsigned(xb));
                s_yb <= TO_INTEGER(unsigned(yb));
            else
                s_incr <='1';
            end if;
            
         else
            s_incr<='0';
            check_block <='0';   
        end if;

    end if;
 
    end process block_position_check;
    
      
    head_tail_color:  process(clk) 
    begin
        if (clk'event and clk='1') then
            if (counter=0 )then
                x<= std_logic_vector(to_unsigned(s_xt,9));
                y<= std_logic_vector(to_unsigned(s_yt,8));
                data <= "000011110000";
                counter <=1;
            elsif(counter =1) then
                x<= std_logic_vector(to_unsigned(s_xq,9));
                y<= std_logic_vector(to_unsigned(s_yq,8));
                data <= "111111111111";
                counter <=2;
              elsif (counter =2) then
                x<= std_logic_vector(to_unsigned(s_xb,9));
                y<= std_logic_vector(to_unsigned(s_yb,8));
                data <= "000000001111";
                counter <=0;   
            end if;
        end if;
    end process head_tail_color;
    
    collision_mur : process(clk,s_xt, s_yt, reset, init_snake) 
    begin 
        if (clk'event and clk='1') then
            if  (reset ='1' or init_snake='1') then
                s_collision_mur <= '0';
            elsif( s_xt = 70 or s_xt=230 or s_yt = 70 or s_yt=230) then
                s_collision_mur <= '1';
            end if;
        end if;
    end process collision_mur;
    
    collision_snake :process(clk,s_xt, s_yt, reset, init_snake) 
    begin 
        if (clk'event and clk='1') then
            collision_check: for k in 49 downto 1 loop
                if  (reset ='1' or init_snake='1') then
                    s_collision_snake <= '0';
                 elsif(snake_memory(k*2)/=0) then
                     if ((snake_memory(k*2+1)=s_xt) and  (snake_memory(k*2)= s_yt)) then
                        s_collision_snake <=  '1';
                    end if;
                  end if;
             end loop collision_check;
        end if;
    end process collision_snake;
    
    head_tail_update: process(snake_memory, init_vga) 
    begin
          if (init_vga ='1') then
                 s_xt <=119;
                 s_yt <=100;
                 s_xq <=115;
                 s_yq <=100;
          else
                 s_xt <=snake_memory(1);
                 s_yt <=snake_memory(0);
                 s_xq <=snake_memory(max);
                 s_yq <=snake_memory(max-1);
        end if;
    end process head_tail_update ;
   
    incr <= s_incr;
    write <='1';
    collision <= s_collision_mur or s_collision_snake;
end Behavioral;
