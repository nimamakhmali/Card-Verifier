library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_Multiplier_2_tb is
end BCD_Multiplier_2_tb;

architecture test of BCD_Multiplier_2_tb is

    signal bcd_in  : std_logic_vector(3 downto 0);
    signal bcd_out : std_logic_vector(3 downto 0);

begin
    uut: entity work.BCD_Multiplier_2 port map (
        bcd_in  => bcd_in,
        bcd_out => bcd_out
    );

    process
    begin
        report "Starting Testbench for BCD Multiplier x2";

        bcd_in <= "0000"; wait for 10 ns;  
        bcd_in <= "0001"; wait for 10 ns;  
        bcd_in <= "0010"; wait for 10 ns;  
        bcd_in <= "0100"; wait for 10 ns;  
        bcd_in <= "0101"; wait for 10 ns;
        bcd_in <= "0111"; wait for 10 ns;
        bcd_in <= "1001"; wait for 10 ns;

        report "Testbench Finished!";
        wait;
    end process;
end test;
