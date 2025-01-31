library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reverse_bytes is
    Port (
        input_vector  : in  std_logic_vector(59 downto 0);
        output_vector : out std_logic_vector(59 downto 0)
    );
end reverse_bytes;

architecture Behavioral of reverse_bytes is
begin
    process(input_vector)
    begin
        for i in 0 to 14 loop
            output_vector((i*4) + 3 downto i*4) <= input_vector((14-i)*4 + 3 downto (14-i)*4);
        end loop;
    end process;
end Behavioral;
