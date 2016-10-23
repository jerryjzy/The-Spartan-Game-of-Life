library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity hamming_TB is
end hamming_TB;

architecture arch of hamming_TB is
    component hamming
        Port(
            bits_in   : in std_logic_vector(7 downto 0);
            count_out : out std_logic_vector(2 downto 0)
        );
    end component;
    signal bits: std_logic_vector(7 downto 0);
    signal count: std_logic_vector(2 downto 0);
begin
    test: hamming port map(bits_in => bits, count_out => count);

    process
    begin
        for index in 255 downto 0 loop
            bits <= std_logic_vector(to_unsigned(index, 8));
            wait for 1 ns;
        end loop;
        wait;
    end process;
end arch;
