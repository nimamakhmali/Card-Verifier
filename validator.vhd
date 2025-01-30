
-- Validator Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Validator is
    Port (
        card_data : in  STD_LOGIC_VECTOR(15 downto 0);
        valid     : out STD_LOGIC
    );
end Validator;

architecture Structural of Validator is
begin
    process (card_data)
    begin
        if card_data = "0001001000110100" then -- Example valid card number
            valid <= '1';
        else
            valid <= '0';
        end if;
    end process;
end Structural;
