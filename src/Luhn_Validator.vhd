library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Luhn_Validator is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        card_number : in  std_logic_vector(63 downto 0);
        valid_out   : out std_logic
    );
end Luhn_Validator;

architecture Structural of Luhn_Validator is
    signal reversed_number : std_logic_vector(59 downto 0);
    signal doubled_values  : std_logic_vector(59 downto 0);
    signal end_digit : std_logic_vector(3 downto 0);
    signal digits : std_logic_vector(59 downto 0);
    signal sum_result      : integer := 0;

begin

    end_digit <= card_number(3 downto 0);
    digits <= card_number(63 downto 4);
    Reverse_Inst: entity work.Reverse_Bytes
        port map (
            input_vector  => digits,
            output_vector => reversed_number
        );

    Double_Inst: entity work.Double_Odd_Positions
        port map (
            input_vector  => reversed_number,
            output_vector => doubled_values
        );

    Sum_Inst: entity work.Compute_Sum
        port map (
            input_vector => doubled_values,
            sum_out      => sum_result
        );

    process(clk, reset)
    begin
        if reset = '1' then
            valid_out <= '0';
        elsif rising_edge(clk) then
            if (sum_result mod 10 = to_integer(unsigned(end_digit))) then
                valid_out <= '1';
            else
                valid_out <= '0'; 
            end if;
        end if;
    end process;

end Structural;
