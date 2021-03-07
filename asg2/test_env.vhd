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

    signal s_counter : std_logic_vector(15 downto 0) := X"0000";

begin
    --    led <= sw;
    an  <= btn(3 downto 0);
    cat <= (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            if btn(4) = '1' then
                s_counter <= s_counter + 1;
            end if;
        end if;
    end process;

    led <= s_counter;

end Behavioral;
