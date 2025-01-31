library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Double_Odd_Positions is
end TB_Double_Odd_Positions;

architecture test of TB_Double_Odd_Positions is
    signal input_vector  : std_logic_vector(63 downto 0);
    signal output_vector : std_logic_vector(63 downto 0);

begin
    DUT: entity work.Double_Odd_Positions port map (input_vector => input_vector, output_vector => output_vector);

    process
    begin
        input_vector <= X"135792468ACEF012";
        wait for 10 ns;
        
        assert output_vector = X"276354468ACEF012"
            report "Double_Odd_Positions FAILED!" severity error;

        wait;
    end process;
end test;
