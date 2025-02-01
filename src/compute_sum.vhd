library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Compute_Sum is
    Port (
        input_vector : in  std_logic_vector(59 downto 0);
        sum_out      : out integer
    );
end Compute_Sum;

architecture Behavioral of Compute_Sum is
    signal sum_value : integer := 0;
begin
    process(input_vector)
    begin
        sum_value <= 0;
        for i in 0 to 14 loop
            sum_value <= sum_value + to_integer(unsigned(input_vector((i*4)+3 downto i*4)));
        end loop;
        sum_out <= sum_value;
    end process;
end Behavioral;