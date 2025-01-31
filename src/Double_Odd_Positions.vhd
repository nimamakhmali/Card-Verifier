library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Double_Odd_Positions is
    Port (
        input_vector  : in  std_logic_vector(59 downto 0);
        output_vector : out std_logic_vector(59 downto 0)
    );
end Double_Odd_Positions;

architecture Behavioral of Double_Odd_Positions is
    signal temp_vector : std_logic_vector(63 downto 0);
    signal temp_value  : integer;
begin
    
    process(input_vector)
    begin
        for i in 0 to 14 loop
            if (i mod 2 = 0) then
                entity work.BCD_Multiplier_2 port map(bcd_in => input_vector((i*4)+3 downto i*4), bcd_out => temp_vector((i*4)+3 downto i*4))
            else
                temp_vector((i*4)+3 downto i*4) <= input_vector((i*4)+3 downto i*4);
            end if;
        end loop;
        output_vector <= temp_vector;
    end process;
end Behavioral;
