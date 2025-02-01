library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Card_Verifier_tb is
end Card_Verifier_tb;

architecture test of Card_Verifier_tb is
    signal clk        : std_logic := '0';          
    signal rst        : std_logic := '1';         
    signal enable     : std_logic := '0';         
    signal chunk_in   : std_logic_vector(3 downto 0) := (others => '0');
    signal valid_out  : std_logic;

    constant clk_period : time := 10 ns;

begin
        uut: entity work.Card_Verifier
        port map (
            clk        => clk,
            rst        => rst,
            enable     => enable,
            chunk_in   => chunk_in,
            valid_out  => valid_out
        );

    clk_process: process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    stimulus: process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 10 ns;

        enable <= '1';
        chunk_in <= "0100"; wait for clk_period;
        chunk_in <= "0101"; wait for clk_period;
        chunk_in <= "0101"; wait for clk_period;
        chunk_in <= "0110"; wait for clk_period;
        chunk_in <= "0111"; wait for clk_period;
        chunk_in <= "0011"; wait for clk_period;
        chunk_in <= "0111"; wait for clk_period;
        chunk_in <= "0101"; wait for clk_period;
        chunk_in <= "1000"; wait for clk_period;
        chunk_in <= "0110"; wait for clk_period;
        chunk_in <= "1000"; wait for clk_period;
        chunk_in <= "1001"; wait for clk_period;
        chunk_in <= "1001"; wait for clk_period;
        chunk_in <= "1000"; wait for clk_period;
        chunk_in <= "0101"; wait for clk_period;
        chunk_in <= "0101"; wait for clk_period;
        
        enable <= '0';
        wait for 50 ns;
        
        assert valid_out = '1'
            report "Test Failed: Card number validation incorrect"
            severity error;
        
        wait for 100 ns;
        
        report "Testbench Completed Successfully";
        wait;
    end process;
end test;
