-- Calculate hamming weight
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity hamming is
    port(
        bits_in   : in std_logic_vector(7 downto 0);
        count_out : out std_logic_vector(2 downto 0)
    );
end hamming;

architecture arch of hamming is
begin
    process(bits_in)
        variable sum : unsigned(2 downto 0);
    begin
        sum := "000";
        for index in 7 downto 0 loop
            if bits_in(index) = '1' then
                sum := sum + 1;
            end if;
        end loop;
        count_out <= std_logic_vector(sum);
    end process;
end arch;
