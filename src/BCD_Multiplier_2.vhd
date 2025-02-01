library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_Multiplier_2 is
    Port (
        bcd_in  : in  std_logic_vector(3 downto 0);
        bcd_out : out std_logic_vector(3 downto 0)
    );
end BCD_Multiplier_2;

architecture Behavioral of BCD_Multiplier_2 is
    signal temp : unsigned(4 downto 0);
begin
    process(bcd_in)
    begin

        temp <= ("0" & unsigned(bcd_in)) sll 1;

        if temp > "01001" then
            temp <= temp + "0011";
        end if;

        bcd_out <= std_logic_vector(temp(3 downto 0));
    end process;
end Behavioral;