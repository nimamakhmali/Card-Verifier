library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- استفاده از numeric_std

entity CardVerifier_tb is
-- تست‌بنچ نیازی به پورت ندارد
end CardVerifier_tb;

architecture Behavioral of CardVerifier_tb is
    -- Component تعریف ماژول اصلی
    component CardVerifier is
        Port (
            clk        : in std_logic;
            reset      : in std_logic;
            data_ready : in std_logic;
            chunk_in   : in std_logic_vector(3 downto 0);
            valid_out  : out std_logic
        );
    end component;

    -- سیگنال‌ها برای اتصال به ماژول
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '0';
    signal data_ready : std_logic := '0';
    signal chunk_in   : std_logic_vector(3 downto 0) := "0000";
    signal valid_out  : std_logic;

    -- کلاک 50MHz
    constant clk_period : time := 20 ns;
begin

    -- اتصال ماژول اصلی به سیگنال‌ها
    uut: CardVerifier
        port map (
            clk        => clk,
            reset      => reset,
            data_ready => data_ready,
            chunk_in   => chunk_in,
            valid_out  => valid_out
        );

    -- فرآیند تولید کلاک
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- فرآیند شبیه‌سازی
    stim_proc: process
    begin
        -- ریست اولیه
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 40 ns;

        -- تست 1: کارت معتبر
        data_ready <= '1';
        chunk_in <= "0011"; -- چانک 1: 3
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        data_ready <= '1';
        chunk_in <= "0100"; -- چانک 2: 4
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        data_ready <= '1';
        chunk_in <= "0101"; -- چانک 3: 5
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        data_ready <= '1';
        chunk_in <= "1000"; -- چانک 4: 8
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        -- بررسی خروجی
        wait for 40 ns;

        -- تست 2: کارت نامعتبر
        reset <= '1';  -- ریست سیستم
        wait for 40 ns;
        reset <= '0';
        wait for 40 ns;

        data_ready <= '1';
        chunk_in <= "0001"; -- چانک 1: 1
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        data_ready <= '1';
        chunk_in <= "0010"; -- چانک 2: 2
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        data_ready <= '1';
        chunk_in <= "0011"; -- چانک 3: 3
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        data_ready <= '1';
        chunk_in <= "0010"; -- چانک 4: 2
        wait for clk_period;
        data_ready <= '0';
        wait for clk_period;

        -- بررسی خروجی
        wait for 40 ns;

        -- پایان شبیه‌سازی
        wait;
    end process;

end Behavioral;
