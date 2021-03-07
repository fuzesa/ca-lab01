library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env_tb is
end test_env_tb;

architecture Behavioral of test_env_tb is

    -- Main component declaration
    component test_env
        port(
            clk : in  std_logic;
            btn : in  std_logic_vector(4 downto 0);
            sw  : in  std_logic_vector(15 downto 0);
            led : out std_logic_vector(15 downto 0);
            an  : out std_logic_vector(3 downto 0);
            cat : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Input signals
    signal clk : std_logic                     := '0';
    signal btn : std_logic_vector(4 downto 0)  := B"0_0000";
    signal sw  : std_logic_vector(15 downto 0) := X"0000";

    -- Output signals
    signal led : std_logic_vector(15 downto 0);
    signal an  : std_logic_vector(3 downto 0);
    signal cat : std_logic_vector(6 downto 0);

begin

    -- Instantiate component
    uut : test_env
        port map(
            clk => clk,
            btn => btn,
            sw  => sw,
            led => led,
            an  => an,
            cat => cat
        );

    stim_proc : process
    begin
        -- hold reset state for 100ns
        wait for 100 ns;

        -- set switches so that the value of the LEDs can be tested
        sw <= X"abcd";
        wait for 200 ns;

        -- set another value for the switches
        sw <= X"4321";
        wait for 100 ns;

        -- set one of the button values to '1' to simulate pressing one button
        btn <= B"0_0010";
        wait for 200 ns;

        -- set two of the button values to '1' to simulate pressing two buttons at the same time
        btn <= B"0_1001";
        wait for 100 ns;

        -- set the MSB to '1' that should be ignored
        btn <= B"1_0000";
        wait for 100 ns;

        -- set buttons to zero to simulate letting go
        btn <= B"0_0000";
        wait;

    end process;

end Behavioral;
