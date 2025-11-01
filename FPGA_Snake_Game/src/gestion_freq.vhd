
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_freq is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           play : in std_logic;
           ce_chrono : out STD_LOGIC;
           ce_mvt : out STD_LOGIC;
           score_uni : in STD_LOGIC_VECTOR (3 downto 0);
           score_dec : in STD_LOGIC_VECTOR (3 downto 0);
           score_cent : in STD_LOGIC_VECTOR (3 downto 0);
           ce_7seg: out std_logic);
end gestion_freq;

architecture Behavioral of gestion_freq is
signal s_ce_mvt , s_ce_chrono, s_ce_7seg: integer:=0;
signal score : integer:= TO_INTEGER(unsigned(score_uni))+(TO_INTEGER(unsigned(score_dec))*10)+(TO_INTEGER(unsigned(score_cent))*100);

begin
process(clk,reset)
 begin
     
        if (clk'event and clk='1') then
                if(reset = '1') then
                    s_ce_mvt <= 0;
               else
               if(score<=5)then
                    if(s_ce_mvt =5000000) then   --100ms  5000000
                        s_ce_mvt <= 0;
                        ce_mvt <= '1';
                     else
                            s_ce_mvt <= s_ce_mvt+1;
                            ce_mvt <= '0';
                     end if;
                elsif(5<score and score<=15)then           
                      if(s_ce_mvt =4000000) then   --100ms  5000000
                        s_ce_mvt <= 0;
                        ce_mvt <= '1';
                     else
                            s_ce_mvt <= s_ce_mvt+1;
                            ce_mvt <= '0'; 
                     end if;
                elsif(10<score and score<=30)then         
                      if(s_ce_mvt =3000000) then   --100ms  5000000
                        s_ce_mvt <= 0;
                        ce_mvt <= '1';
                     else
                            s_ce_mvt <= s_ce_mvt+1;
                            ce_mvt <= '0'; 
                     end if;
                 elsif(30<score)then           
                      if(s_ce_mvt =2500000) then   --100ms  5000000
                        s_ce_mvt <= 0;
                        ce_mvt <= '1';
                     else
                            s_ce_mvt <= s_ce_mvt+1;
                            ce_mvt <= '0'; 
                     end if;  
                  end if;
              end if;                   
       end if;
end process;


process(clk,reset)
 begin
     
        if (clk'event and clk='1') then
                if(reset = '1' or play ='0') then
                    s_ce_chrono <= 0;
               elsif( play ='1') then
                    if(s_ce_chrono =100000000) then   -- 1s  100000000
                        s_ce_chrono <= 0;
                        ce_chrono <= '1';
                     else
                            s_ce_chrono <= s_ce_chrono+1;
                            ce_chrono <= '0';
                       end if;
           end if;
       end if;
end process;


process(clk,reset)
 begin
       if (clk'event and clk='1') then
                if(reset = '1') then
                    s_ce_7seg <= 0;
               else
                    if(s_ce_7seg =33333) then   
                        s_ce_7seg <= 0;
                        ce_7seg <= '1';
                     else
                            s_ce_7seg <= s_ce_7seg+1;
                            ce_7seg<= '0';
                       end if;
           end if;
       end if;
end process;

end Behavioral;
