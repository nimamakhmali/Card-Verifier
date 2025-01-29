library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- استفاده از numeric_std

-- Entity تعریف ورودی‌ها و خروجی‌ها
entity CardVerifier is
    Port (
        clk            : in std_logic;                     -- کلاک
        reset          : in std_logic;                     -- ریست
        data_ready     : in std_logic;                     -- سیگنال آماده بودن داده
        chunk_in       : in std_logic_vector(3 downto 0);  -- چانک ورودی (4 بیت)
        valid_out      : out std_logic                     -- سیگنال خروجی اعتبارسنجی
    );
end CardVerifier;

-- Architecture برای پیاده‌سازی منطق FSM
architecture Behavioral of CardVerifier is
    -- تعریف حالت‌ها
    type State_Type is (Idle, Read_Chunk, Process_Chunk, Validate, Output);
    signal current_state, next_state : State_Type;

    -- سیگنال‌های کمکی
    signal chunk_counter : integer range 0 to 4 := 0;  -- شمارنده چانک‌ها
    signal is_valid       : std_logic := '0';          -- اعتبار کارت
    signal chunk_sum      : integer := 0;             -- مجموع پردازش چانک‌ها
begin

    -- فرآیند انتقال حالت‌ها
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= Idle;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- فرآیند منطق FSM
    process(current_state, data_ready, chunk_counter)
    begin
        case current_state is
            -- حالت Idle: انتظار برای داده
            when Idle =>
                if data_ready = '1' then
                    next_state <= Read_Chunk;
                else
                    next_state <= Idle;
                end if;

            -- حالت Read_Chunk: خواندن چانک
            when Read_Chunk =>
                next_state <= Process_Chunk;

            -- حالت Process_Chunk: پردازش چانک
            when Process_Chunk =>
                if chunk_counter = 3 then  -- اگر همه چانک‌ها پردازش شدند
                    next_state <= Validate;
                else
                    next_state <= Read_Chunk;
                end if;

            -- حالت Validate: اعتبارسنجی نهایی
            when Validate =>
                next_state <= Output;

            -- حالت Output: تولید نتیجه خروجی
            when Output =>
                next_state <= Idle;

            when others =>
                next_state <= Idle;
        end case;
    end process;

    -- فرآیند مدیریت سیگنال‌های داخلی
    process(clk, reset)
    begin
        if reset = '1' then
            chunk_counter <= 0;
            chunk_sum <= 0;
            is_valid <= '0';
        elsif rising_edge(clk) then
            case current_state is
                -- شمارنده را صفر کن
                when Idle =>
                    chunk_counter <= 0;
                    chunk_sum <= 0;
                    is_valid <= '0';

                -- خواندن چانک و جمع کردن داده‌ها
                when Read_Chunk =>
                    chunk_sum <= chunk_sum + to_integer(unsigned(chunk_in)); -- تبدیل داده به عدد صحیح

                -- افزایش شمارنده در حالت پردازش
                when Process_Chunk =>
                    chunk_counter <= chunk_counter + 1;

                -- اعتبارسنجی نهایی
                when Validate =>
                    if (chunk_sum mod 10 = 0) then  -- مثال ساده برای اعتبارسنجی
                        is_valid <= '1';  -- کارت معتبر است
                    else
                        is_valid <= '0';  -- کارت نامعتبر است
                    end if;

                -- تولید نتیجه خروجی
                when Output =>
                    valid_out <= is_valid;

                when others =>
                    null;
            end case;
        end if;
    end process;

end Behavioral;
