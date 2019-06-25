library ieee;
use ieee.std_logic_1164.all;

entity ssd is

port(
    ss_display_1, ss_display_2, ss_display_3, ss_display_4: in integer;
    clk: in std_logic;
    ss_1 : out std_logic;
    ss_2 : out std_logic;
    ss_3 : out std_logic;
    ss_4 : out std_logic;
    ss_a, ss_b, ss_c, ss_d, ss_e, ss_f, ss_g : out std_logic
    );
    
end ssd;

architecture behavioral of ssd is

signal control: integer := 0;
signal period: integer;
signal display_1, display_2, display_3, display_4: std_logic_vector  (0 to 6) := "1111111";

begin
process(clk)
begin

case ss_display_1 is
when 0 =>
display_1 <= "0000001";
when 1 =>
display_1 <= "1001111";
when 2 =>
display_1 <= "0010010";
when 3 =>
display_1 <= "0000110";
when 4 =>
display_1 <= "1001100";
when 5 =>
display_1 <= "0100100";
when 6 =>
display_1 <= "0100000";
when 7 =>
display_1 <= "0001111";
when 8 =>
display_1 <= "0000000";
when 9 =>
display_1 <= "0000100";
when 10 =>
--P letter
display_1 <= "0011000";
when 11 =>
--E letter 
display_1 <= "0110000";
when 12 =>
--d letter
display_1 <= "1000010";
when others =>
--turn desired segment off
display_1 <= "1111111";
end case;

case ss_display_2 is
when 0 =>
display_2 <= "0000001";
when 1 =>
display_2 <= "1001111";
when 2 =>
display_2 <= "0010010";
when 3 =>
display_2 <= "0000110";
when 4 =>
display_2 <= "1001100";
when 5 =>
display_2 <= "0100100";
when 6 =>
display_2 <= "0100000";
when 7 =>
display_2 <= "0001111";
when 8 =>
display_2 <= "0000000";
when 9 =>
display_2 <= "0000100";
when 10 =>
--P letter
display_2 <= "0011000";
when 11 =>
--E letter 
display_2 <= "0110000";
when 12 =>
--d letter
display_2 <= "1000010";
when others =>
--turn desired segment off
display_2 <= "1111111";
end case;

case ss_display_3 is
when 0 =>
display_3 <= "0000001";
when 1 =>
display_3 <= "1001111";
when 2 =>
display_3 <= "0010010";
when 3 =>
display_3 <= "0000110";
when 4 =>
display_3 <= "1001100";
when 5 =>
display_3 <= "0100100";
when 6 =>
display_3 <= "0100000";
when 7 =>
display_3 <= "0001111";
when 8 =>
display_3 <= "0000000";
when 9 =>
display_3 <= "0000100";
when 10 =>
--P letter
display_3 <= "0011000";
when 11 =>
--E letter 
display_3 <= "0110000";
when 12 =>
--d letter
display_3 <= "1000010";
when others =>
--turn desired segment off
display_3 <= "1111111";
end case;

case ss_display_4 is
when 0 =>
display_4 <= "0000001";
when 1 =>
display_4 <= "1001111";
when 2 =>
display_4 <= "0010010";
when 3 =>
display_4 <= "0000110";
when 4 =>
display_4 <= "1001100";
when 5 =>
display_4 <= "0100100";
when 6 =>
display_4 <= "0100000";
when 7 =>
display_4 <= "0001111";
when 8 =>
display_4 <= "0000000";
when 9 =>
display_4 <= "0000100";
when 10 =>
--P letter
display_4 <= "0011000";
when 11 =>
--E letter 
display_4 <= "0110000";
when 12 =>
--d letter
display_4 <= "1000010";
when others =>
display_4 <= "1111111";
end case;

period <= control mod 80000;

if rising_edge (clk) then

    if period <20000 then

    control <= control + 1;
    ss_1 <= '0';
    ss_2 <= '1';
    ss_3 <= '1';
    ss_4 <= '1';
    ss_a <= display_1(0);
    ss_b <= display_1(1);
    ss_c <= display_1(2);
    ss_d <= display_1(3);
    ss_e <= display_1(4);
    ss_f <= display_1(5);
    ss_g <= display_1(6);

    end if;

    if (period > 19999) and (period < 40000) then
    
    control <= control +1;
    ss_1 <= '1';
    ss_2 <= '0';
    ss_3 <= '1';
    ss_4 <= '1';
    ss_a <= display_2(0);
    ss_b <= display_2(1);
    ss_c <= display_2(2);
    ss_d <= display_2(3);
    ss_e <= display_2(4);
    ss_f <= display_2(5);
    ss_g <= display_2(6);
    
    end if;

    if (period > 29999) and (period <60000) then
    
    control <= control +1;
    ss_1 <= '1';
    ss_2 <= '1';
    ss_3 <= '0';
    ss_4 <= '1';
    ss_a <= display_3(0);
    ss_b <= display_3(1);
    ss_c <= display_3(2);
    ss_d <= display_3(3);
    ss_e <= display_3(4);
    ss_f <= display_3(5);
    ss_g <= display_3(6);
    
    end if;

    if period > 59999 then
    
    control <= control +1;
    ss_1 <= '1';
    ss_2 <= '1';
    ss_3 <= '1';
    ss_4 <= '0';
    ss_a <= display_4(0);
    ss_b <= display_4(1);
    ss_c <= display_4(2);
    ss_d <= display_4(3);
    ss_e <= display_4(4);
    ss_f <= display_4(5);
    ss_g <= display_4(6);
    
    end if;

end if;

end process;
end behavioral;


   
