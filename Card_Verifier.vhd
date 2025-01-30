
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CardVerifier is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        data_in    : in  STD_LOGIC_VECTOR(3 downto 0);
        valid      : out STD_LOGIC
    );
end CardVerifier;

architecture Structural of CardVerifier is
    
    -- Component declarations
    component ShiftRegister is
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            data_in  : in  STD_LOGIC_VECTOR(3 downto 0);
            data_out : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;
    
    component Validator is
        Port (
            card_data : in  STD_LOGIC_VECTOR(15 downto 0);
            valid     : out STD_LOGIC
        );
    end component;
    
    -- Signals to connect components
    signal card_data : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    
    -- Instantiating Shift Register
    ShiftReg_inst : ShiftRegister
        port map (
            clk      => clk,
            reset    => reset,
            data_in  => data_in,
            data_out => card_data
        );
    
    -- Instantiating Validator
    Validator_inst : Validator
        port map (
            card_data => card_data,
            valid     => valid
        );
    
end Structural;
