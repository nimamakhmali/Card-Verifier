library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Compute_Sum_tb is
end Compute_Sum_tb;

architecture test of Compute_Sum_tb is
    signal input_vector : std_logic_vector(59 downto 0);
    signal sum_out      : integer;

begin
    DUT: entity work.Compute_Sum port map (input_vector => input_vector, sum_out => sum_out);

    process
    begin
        input_vector <= X"135792468ACEF01"; 
        wait for 10 ns;
        
        assert sum_out = 93
            report "Compute_Sum FAILED!" severity error;

        wait;
    end process;
end test;
