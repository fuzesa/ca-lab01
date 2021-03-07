library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env is
    Port(
        clk : in  std_logic;
        btn : in  std_logic_vector(4 downto 0);
        sw  : in  std_logic_vector(15 downto 0);
        led : out std_logic_vector(15 downto 0);
        an  : out std_logic_vector(3 downto 0);
        cat : out std_logic_vector(6 downto 0)
    );
end test_env;

architecture Behavioral of test_env is

    -- declare MPG
    component mono_pulse_gen
        Port(clk    : in  STD_LOGIC;
             btn    : in  STD_LOGIC;
             enable : out STD_LOGIC);
    end component;

    signal s_counter        : std_logic_vector(15 downto 0) := X"0000";
    signal s_counter_enable : std_logic                     := '0';

begin

    -- instantiate MPG
    mpg : mono_pulse_gen
        port map(
            clk    => clk,
            btn    => btn(1),          -- >> I changed it to btn(1), because it's the farthest
            enable => s_counter_enable --    from the LEDs and it would be a little more clear in
        );                             --    in the video

    --    led <= sw;
    --    an  <= btn(4 downto 1);
    cat <= (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            --            if btn(4) = '1' then
            if s_counter_enable = '1' then
                s_counter <= s_counter + 1;
            end if;
        end if;
    end process;

    led <= s_counter;

end Behavioral;
