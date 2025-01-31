library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Compute_Sum is
end TB_Compute_Sum;

architecture test of TB_Compute_Sum is
    signal input_vector : std_logic_vector(63 downto 0);
    signal sum_out      : integer;

begin
    DUT: entity work.Compute_Sum port map (input_vector => input_vector, sum_out => sum_out);

    process
    begin
        input_vector <= X"135792468ACEF012"; 
        wait for 10 ns;
        
        assert sum_out = 95
            report "Compute_Sum FAILED!" severity error;

        wait;
    end process;
end test;
