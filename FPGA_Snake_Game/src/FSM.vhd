----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2023 10:31:30 AM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
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
end FSM;

architecture Behavioral of FSM is
type etat_snake is (init,int_snake,dead,dead_init,U,D,L,R);
SIGNAL current_state : etat_snake;
SIGNAL next_state : etat_snake;
begin

PROCESS (CLK)
BEGIN
    IF (CLK'EVENT AND CLK = '1') THEN
        IF RST = '1' THEN
            current_state <= dead_init;
        ELSE
            current_state <= next_state;
        END IF;
     END IF;
END PROCESS;


PROCESS (current_state, B_CENTER, B_LEFT, B_RIGHT,b_up,b_down,collision)
BEGIN
    CASE current_state IS
        WHEN init =>
            IF B_CENTER = '1' THEN next_state <= int_snake;
            ELSE next_state <= init;
            END IF;
          WHEN int_snake =>
              next_state <= R;
        WHEN r =>
            IF B_down = '1' THEN next_state <= d;
            elsif b_up='1' then next_state <= u;
            elsif collision = '1' then next_state <= dead;
            else next_state <= r;
            END IF;
        WHEN d =>
            IF B_right = '1' THEN next_state <= r;
            elsif b_left='1' then next_state <= l;
            elsif collision = '1' then next_state <= dead;
            else next_state <= d;
            END IF; 
          WHEN l =>
            IF B_down = '1' THEN next_state <= d;
            elsif b_up='1' then next_state <= u;
            elsif collision = '1' then next_state <= dead;
            else next_state <= l;
            END IF;
          WHEN u =>
            IF B_left = '1' THEN next_state <= l;
            elsif b_right='1' then next_state <= r;
            elsif collision = '1' then next_state <= dead;
            else next_state <= u;
            END IF;
         WHEN dead =>
            IF B_center = '1' THEN next_state <= dead_init;
            else next_state <= dead;
            END IF;
         WHEN dead_init =>
              next_state <= init;  
         WHEN OTHERS=> next_state <= INIT;
       END CASE;
END PROCESS;

PROCESS (current_state,B_CENTER, B_LEFT, B_RIGHT,b_up,b_down,collision)
    BEGIN
        CASE current_state IS
            WHEN INIT => left<= '0'; right <= '0';init_snake <= '0';init_vga <= '0';
                up <= '0'; down <= '0'; stop <= '1';play <= '0'; mort <= '0' ;
            WHEN int_snake => left<= '0'; right <= '0';init_snake <= '1';init_vga <= '0';
                up <= '0'; down <= '0'; stop <= '1';play <= '0'; mort <= '0' ;
            WHEN r =>  left<= '0'; right <= '1';init_snake <= '0';init_vga <= '0';
                up <= '0'; down <= '0'; stop <= '0';play <= '1';  mort <= '0' ;
           WHEN l => left<= '1'; right <= '0';init_snake <= '0';init_vga <= '0';
                up <= '0'; down <= '0'; stop <= '0';play <= '1';  mort <= '0' ;
                
                
            WHEN u => left<= '0'; right <= '0';init_snake <= '0';init_vga <= '0';
                up <= '1'; down <= '0'; stop <= '0';play <= '1'; mort <= '0' ;
                
                
            WHEN d => left<= '0'; right <= '0';init_snake <= '0';init_vga <= '0';
                up <= '0'; down <= '1'; stop <= '0';play <= '1'; mort <= '0' ;
                
                
            WHEN dead => left<= '0'; right <= '0';init_snake <= '0';init_vga <= '0';
                up <= '0'; down <= '0'; stop <= '1';play <= '0'; mort <= '1' ;
           WHEN dead_init => left<= '0'; right <= '0';init_snake <= '0';init_vga <= '1';
                up <= '0'; down <= '0'; stop <= '1';play <= '0'; mort <= '0' ;
            
                   
        END CASE;
    END PROCESS;

end Behavioral;
