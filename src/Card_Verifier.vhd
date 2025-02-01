library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Card_Verifier is
    Port (
        clk        : in  std_logic;                     
        rst        : in  std_logic;           
        enable     : in  std_logic;                   
        chunk_in   : in  std_logic_vector(3 downto 0);
        valid_out  : out std_logic
    );
end Card_Verifier;

architecture Behavioral of Card_Verifier is
    signal shift_reg : std_logic_vector(63 downto 0) := (others => '0'); 
    signal chunk_counter : integer range 0 to 15 := 0;                    
    signal data_ready : std_logic := '0';                      
    signal valid_tmp  : std_logic := '0';
begin

    process (clk, rst)
    begin
        if rst = '1' then
            shift_reg <= (others => '0');  
            chunk_counter <= 0;
            data_ready <= '0';
            valid_out <= '0';
        elsif rising_edge(clk) then
            if enable = '1' then
                shift_reg <= shift_reg(59 downto 0) & chunk_in;

                if chunk_counter < 15 then
                    chunk_counter <= chunk_counter + 1;
                    data_ready <= '0';
                else
                    chunk_counter <= 0;
                    data_ready <= '1';
                end if;
            end if;
        end if;
    end process;

    LuhnValidatorInstance: entity work.Luhn_Validator port map(
        clk         => clk,             
        reset       => rst,       
        card_number => shift_reg,                    
        valid_out   => valid_tmp                     
    );

    process (clk, rst) 
    begin
        if rst = '1' then
            valid_out <= '0';
        elsif rising_edge(clk) then
            if data_ready = '1' then
                valid_out <= valid_tmp;
            end if;
        end if;
    end process;

end Behavioral;
