library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity gameoflife_TB is
end gameoflife_TB;

architecture arch of gameoflife_TB is
    component gameoflife
        Port(
            clk : in std_logic;
            rst : in std_logic;
            sel : out std_logic_vector(7 downto 0);
            dat : out std_logic_vector(7 downto 0)
        );
    end component;
    signal sigclk : std_logic;
    signal sigrst : std_logic;
    signal sigsel : std_logic_vector(7 downto 0);
    signal sigdat : std_logic_vector(7 downto 0);
begin
    test: gameoflife port map(
            clk => sigclk,
            rst => sigrst,
            sel => sigsel,
            dat => sigdat
        );

    process
    begin
        sigrst <= '1';
        wait for 1 us;
        sigrst <= '0';
        wait for 1 us;

        wait;
    end process;

    process
    begin
        for index in 99999 downto 0 loop
            sigclk <= '0';
            wait for 20 ns;
            sigclk <= '1';
            wait for 20 ns;
        end loop;
    end process;
end arch;
