entity CardVerifier is
    Port (
        clk       : in std_logic;  -- کلاک
        reset     : in std_logic;  -- ریست
        data_in   : in std_logic_vector(3 downto 0); -- چانک ورودی
        valid_out : out std_logic  -- نتیجه اعتبارسنجی
    );
end CardVerifier;

architecture Behavioral of CardVerifier is
    type State_Type is (Idle, Read_Chunk, Process_Chunk, Validate, Output);
    signal current_state, next_state : State_Type;

    -- سایر سیگنال‌ها مثل شمارنده، متغیرهای کمکی
begin
    -- فرآیند کلاک برای جابه‌جایی بین حالات
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= Idle;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- منطق انتقال بین حالات
    process(current_state, data_in)
    begin
        case current_state is
            when Idle =>
                if data_in_ready = '1' then
                    next_state <= Read_Chunk;
                else
                    next_state <= Idle;
                end if;

            when Read_Chunk =>
                -- منطق خواندن چانک
                next_state <= Process_Chunk;

            when Process_Chunk =>
                -- منطق پردازش چانک
                if all_chunks_processed = '1' then
                    next_state <= Validate;
                else
                    next_state <= Read_Chunk;
                end if;

            when Validate =>
                -- بررسی نهایی
                next_state <= Output;

            when Output =>
                -- ارسال نتیجه
                next_state <= Idle;

            when others =>
                next_state <= Idle;
        end case;
    end process;
end Behavioral;
