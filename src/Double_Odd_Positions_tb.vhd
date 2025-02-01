library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Double_Odd_Positions_TB is
end Double_Odd_Positions_TB;

architecture testbench of Double_Odd_Positions_TB is
    signal input_vector  : std_logic_vector(59 downto 0);
    signal output_vector : std_logic_vector(59 downto 0);

    component Double_Odd_Positions
        Port (
            input_vector  : in  std_logic_vector(59 downto 0);
            output_vector : out std_logic_vector(59 downto 0)
        );
    end component;

begin
    UUT: Double_Odd_Positions port map (
        input_vector  => input_vector,
        output_vector => output_vector
    );

    process
    begin
        input_vector <= "000100100011010001010110011110001001101011110000110011001100";
        wait for 10 ns;
        
        input_vector <= (others => '0');
        wait for 10 ns;

        input_vector <= "101010101010101010101010101010101010101010101010101010101010";
        wait for 10 ns;
        
        input_vector <= "100110011001100110011001100110011001100110011001100110011001";
        wait for 10 ns;
        
        -- Stop simulation
        wait;
    end process;

end testbench;