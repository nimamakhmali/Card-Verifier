library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Luhn_Validator_tb is
end Luhn_Validator_tb;

architecture test of Luhn_Validator_tb is
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '1';
    signal card_number : std_logic_vector(63 downto 0);
    signal valid_out   : std_logic;

begin
    DUT: entity work.Luhn_Validator port map (
        clk         => clk,
        reset       => reset,
        card_number => card_number,
        valid_out   => valid_out
    );

    process
    begin
        while true loop
            clk <= not clk;
            wait for 5 ns;
        end loop;
    end process;

    process
    begin
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        card_number <= X"4556737586899855"; 
        wait for 20 ns;
        assert valid_out = '0'
            report "Luhn Validation FAILED for valid card!" severity error;

        card_number <= X"7992739871335657";
        wait for 20 ns;
        assert valid_out = '1'
            report "Luhn Validation FAILED for invalid card!" severity error;

        wait;
    end process;
end test;
