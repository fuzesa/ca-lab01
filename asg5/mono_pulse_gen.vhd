library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mono_pulse_gen is
    Port(clk    : in  STD_LOGIC;
         btn    : in  STD_LOGIC_VECTOR(4 downto 0);
         enable : out STD_LOGIC);
end mono_pulse_gen;

architecture Behavioral of mono_pulse_gen is

    signal s_counter : std_logic_vector(22 downto 0) := B"000_0000_0000_0000_0000_0000";
    signal s_q1      : std_logic                     := '0';
    signal s_q2      : std_logic                     := '0';
    signal s_q3      : std_logic                     := '0';

begin

    counter : process(clk)
    begin
        if rising_edge(clk) then
            s_counter <= s_counter + 1;
        end if;
    end process;                        -- counter

    first_reg : process(clk)
    begin
        if rising_edge(clk) then
            if btn > "00000" and s_counter = X"7F_FFFF" then
                s_q1 <= '1';
            else
                s_q1 <= '0';
            end if;
        end if;
    end process;                        -- first_reg

    second_reg : process(clk)
    begin
        if rising_edge(clk) then
            if s_q1 = '1' then
                s_q2 <= '1';
            else
                s_q2 <= '0';
            end if;
        end if;
    end process;                        -- second_reg

    third_reg : process(clk)
    begin
        if rising_edge(clk) then
            if s_q2 = '1' then
                s_q3 <= '1';
            else
                s_q3 <= '0';
            end if;
        end if;
    end process;                        -- third_reg

    enable <= s_q2 and not s_q3;        -- AND gate at the end

end Behavioral;
