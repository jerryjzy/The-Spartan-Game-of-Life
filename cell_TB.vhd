library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity cell_TB is
end cell_TB;

architecture arch of cell_TB is
    component cell
        Port(
            clk_in       : in std_logic;
            neighbors_in : in std_logic_vector(7 downto 0);
            load         : in std_logic;
            data_in      : in std_logic;
            state        : out std_logic
        );
    end component;
        signal clk: std_logic;
        signal neighbors: std_logic_vector(7 downto 0);
        signal stateout        : std_logic;
        signal load_dat : std_logic;
        signal dat: std_logic;
begin
    test: cell port map(clk_in => clk, neighbors_in => neighbors, state => stateout, load => load_dat, data_in => dat);

    process
    begin
        dat <= '0';
        wait for 10 ns;
        load_dat <= '1';
        wait for 10 ns;
        load_dat <= '0';

        for index in 255 downto 0 loop
            neighbors <= std_logic_vector(to_unsigned(index, 8));
            wait for 5 ns;
        end loop;
        dat <= '1';
        wait for 1 ns;
        load_dat <= '1';
        wait for 10 ns;
        load_dat <= '0';
        wait for 1 ns;
        dat <= '0';
        wait for 10 ns;
        load_dat <= '0';

        wait;
    end process;

    process
    begin
        for index in 99999999 downto 0 loop
            clk<= '0';
            wait for 1 ns;
            clk<= '1';
            wait for 1 ns;
        end loop;
        wait;
    end process;

end arch;
