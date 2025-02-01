library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Double_Odd_Positions is
    Port (
        input_vector  : in  std_logic_vector(59 downto 0);
        output_vector : out std_logic_vector(59 downto 0)
    );
end Double_Odd_Positions;

architecture Structural of Double_Odd_Positions is
    component BCD_Multiplier_2 is
        Port (
            bcd_in  : in  std_logic_vector(3 downto 0);
            bcd_out : out std_logic_vector(3 downto 0)
        );
    end component;

    signal temp_vector : std_logic_vector(59 downto 0);

begin

    gen_loop: for i in 0 to 14 generate
        signal bcd_out_signal : std_logic_vector(3 downto 0);
    begin
        Multiplier: BCD_Multiplier_2
        port map (
            bcd_in  => input_vector((i*4)+3 downto i*4),
            bcd_out => bcd_out_signal
        );

        temp_vector((i*4)+3 downto i*4) <= bcd_out_signal when (i mod 2 = 0) else input_vector((i*4)+3 downto i*4);
    end generate;

    output_vector <= temp_vector;

end Structural;
