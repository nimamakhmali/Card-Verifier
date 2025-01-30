
-- Shift Register Module
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ShiftRegister is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR(3 downto 0);
        data_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end ShiftRegister;

architecture Structural of ShiftRegister is
    signal shift_reg : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
    process (clk, reset)
    begin
        if reset = '1' then
            shift_reg <= (others => '0');
        elsif rising_edge(clk) then
            shift_reg <= shift_reg(11 downto 0) & data_in;
        end if;
    end process;
    data_out <= shift_reg;
end Structural;
