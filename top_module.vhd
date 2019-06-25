library ieee;
use ieee.std_logic_1164.all;

entity top_module is

port(
     start_stop: in std_logic;
     clk: in std_logic;
     player_1_button: in std_logic;
     player_2_button: in std_logic;
     led_0, led_1, led_2, led_3, led_4, led_5, led_6, led_7, led_8, led_9, led_10, led_11, led_12, led_13, led_14, led_15: out std_logic;
     a, b, c, d, e, f, g: out std_logic;
     ssd_1, ssd_2, ssd_3, ssd_4: out std_logic
     );
     
end top_module;

architecture behavioral of top_module is

component ssd
port(
     ss_display_1, ss_display_2, ss_display_3, ss_display_4: in integer;
     clk: in std_logic;
     ss_1 : out std_logic;
     ss_2 : out std_logic;
     ss_3 : out std_logic;
     ss_4 : out std_logic;
     ss_a, ss_b, ss_c, ss_d, ss_e, ss_f, ss_g : out std_logic
     );
    
end component;

signal clock_counter: integer := 0;
signal clock_number: integer := 08999999;
type direction_type is (left, right);
signal direction: direction_type := right;
signal led_number: integer range 0 to 15 := 14;
signal led_lighter: std_logic_vector (0 to 15) := "0000000000000000";
signal first_ssd, second_ssd, third_ssd, fourth_ssd: integer;
signal player_1_score, player_2_score: integer range 0 to 9 := 0;

begin

instantiation_ssd: ssd
                   port map(
                            ss_display_1 => first_ssd,
                            ss_display_2 => second_ssd,
                            ss_display_3 => third_ssd,
                            ss_display_4 => fourth_ssd,
                            clk => clk,
                            ss_1 => ssd_1,
                            ss_2 => ssd_2,
                            ss_3 => ssd_3,
                            ss_4 => ssd_4,
                            ss_a => a,
                            ss_b => b,
                            ss_c => c,
                            ss_d => d,
                            ss_e => e,
                            ss_f => f,
                            ss_g => g
                            );
                            
process(clk)
begin

if start_stop = '1' then

if rising_edge(clk) then

    case direction is
    
    when right =>
    
        if (led_number > 0) and (led_number /= 1) then
--     and player_2_button = '0'
            if clock_counter < clock_number then
        
            clock_counter <= clock_counter + 1;
        
            else
        
            clock_counter <= 0;
            led_number <= led_number - 1;
        
            end if;
            
        elsif (led_number = 1) and (player_2_button = '1') then
            
        direction <= left;
        clock_counter <= 0;
        
        elsif (led_number = 1) and (player_2_button = '0') then
        
            if clock_counter < clock_number then
            
            clock_counter <= clock_counter + 1;
            
            else
        
            direction <= right;
            clock_counter <= 0;
            led_number <= led_number - 1;
        
            end if;
   
        elsif (led_number /= 1) and (player_2_button = '1') then
        
        led_number <= 14;

        elsif led_number = 0 then
        
        clock_counter <= 0;
        direction <= left;
        
        end if;
        
    when left =>
    
        if (led_number < 15) and (led_number /= 14) then
--         and (player_1_button = '0')
            if clock_counter < clock_number then
            
            clock_counter <= clock_counter + 1;
            
            else
            
            clock_counter <= 0;
            led_number <= led_number + 1;
            
            end if;
            
        elsif (led_number = 14) and (player_1_button = '1') then
                        
        direction <= right;
        clock_counter <= 0;
        
        elsif (led_number = 14) and (player_1_button = '0') then
        
            if clock_counter < clock_number then
            
            clock_counter <= clock_counter + 1;
            
            else
        
            direction <= left;
            clock_counter <= 0;
            led_number <= led_number + 1;
        
            end if;
    
        elsif (led_number /= 14) and (player_1_button = '1') then
                   
        led_number <= 1;
       
        elsif led_number = 15 then
        
        clock_counter <= 0;
        direction <= right;
        
        end if;
        
    end case;
    
    case led_number is
    
    when 0 => led_lighter <= "1000000000000000";
    when 1 => led_lighter <= "0100000000000000";
    when 2 => led_lighter <= "0010000000000000";
    when 3 => led_lighter <= "0001000000000000";
    when 4 => led_lighter <= "0000100000000000";
    when 5 => led_lighter <= "0000010000000000";
    when 6 => led_lighter <= "0000001000000000";
    when 7 => led_lighter <= "0000000100000000";
    when 8 => led_lighter <= "0000000010000000";
    when 9 => led_lighter <= "0000000001000000";
    when 10 => led_lighter <= "0000000000100000";
    when 11 => led_lighter <= "0000000000010000";
    when 12 => led_lighter <= "0000000000001000";
    when 13 => led_lighter <= "0000000000000100";
    when 14 => led_lighter <= "0000000000000010";
    when 15 => led_lighter <= "0000000000000001";
    
    end case;
    
    if led_number = 0 then
    
    player_1_score <= player_1_score + 1;

    else
    
    player_1_score <= player_1_score;
    
    end if;
    
    if led_number = 15 then
    
    player_2_score <= player_2_score + 1;
     
    else
        
    player_2_score <= player_2_score;
        
    end if;
    
    case player_1_score is
    
    when 0 =>
    
        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        when 9 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 0;
        
        end case;
        
    when 1 =>
    
        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 1;
        
        end case;  
            
    when 2 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 2;
        
        end case;
    
    when 3 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 3;
        
        end case;
    
    when 4 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 4;
        
        end case;
    
    when 5 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 5;
        
        end case;
    
    when 6 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 6;
        
        end case;
    
    when 7 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 7;
        
        end case;
    
    when 8 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 8;
        
        end case;
    
    when 9 =>

        case player_2_score is
        
        when 0 => first_ssd <= 0; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 1 => first_ssd <= 1; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 2 => first_ssd <= 2; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 3 => first_ssd <= 3; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 4 => first_ssd <= 4; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 5 => first_ssd <= 5; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 6 => first_ssd <= 6; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 7 => first_ssd <= 7; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 8 => first_ssd <= 8; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        when 9 => first_ssd <= 9; second_ssd <= 13; third_ssd <= 13; fourth_ssd <= 9;
        
        end case;
        
    end case;
    
led_0 <= led_lighter(0);
led_1 <= led_lighter(1);
led_2 <= led_lighter(2);
led_3 <= led_lighter(3);
led_4 <= led_lighter(4);
led_5 <= led_lighter(5);
led_6 <= led_lighter(6);
led_7 <= led_lighter(7);
led_8 <= led_lighter(8);
led_9 <= led_lighter(9);
led_10 <= led_lighter(10);
led_11 <= led_lighter(11);
led_12 <= led_lighter(12);
led_13 <= led_lighter(13);
led_14 <= led_lighter(14);
led_15 <= led_lighter(15);

end if;

else

led_number <= 15;
direction <= right;
player_1_score <= 0;
player_2_score <= 0;
clock_counter <= 0;

end if;

end process;
end behavioral;

    
    
    
        

