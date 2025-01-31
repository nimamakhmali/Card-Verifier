library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reverse_bytes_tb is
end reverse_bytes_tb;

architecture test of reverse_bytes_tb is
    signal input_vector  : std_logic_vector(63 downto 0);
    signal output_vector : std_logic_vector(63 downto 0);

begin
    DUT: entity work.reverse_bytes port map (input_vector => input_vector, output_vector => output_vector);

    process
    begin
        input_vector <= X"123456789ABCDEF0";  
        wait for 10 ns;
        
        assert output_vector = X"0FEDCBA987654321"
            report "Reverse_Bytes FAILED!" severity error;

        wait;
    end process;
end test;
