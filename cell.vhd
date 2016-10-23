-----------------------------------------
-- Conway's game of life
--  Life cell
-----------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;


entity cell is
    Port(
        clk_in       : in std_logic;
        neighbors_in : in std_logic_vector(7 downto 0);
        load         : in std_logic;
        data_in      : in std_logic;
        state        : out std_logic
    );
end cell;

architecture arch of cell is
    -- Declare hamming weight component
    component hamming
        Port(
            bits_in   : in std_logic_vector(7 downto 0);
            count_out : out std_logic_vector(2 downto 0)
        );
    end component;

    signal currstate : std_logic;
    signal nextstate : std_logic;
    signal numneighbors: std_logic_vector(2 downto 0);
begin
    
    god : hamming
        port map (
            bits_in => neighbors_in,
            count_out => numneighbors
        );

    state <= currstate;
    process(clk_in, nextstate)
    begin
        if rising_edge(clk_in) then
            if load = '0' then
                currstate <= nextstate;
            else
                currstate <= data_in;
            end if;
        end if;
    end process;

    --  Find out end process
    process(currstate, numneighbors)
    begin
        if currstate = '1' then
            if (numneighbors = "010") or (numneighbors = "011") then
                nextstate <= '1';
            else
                nextstate <= '0';
            end if;
        else
            if numneighbors = "011" then
                nextstate <= '1';
            else
                nextstate <= '0';
            end if;
        end if;
    end process;
end arch;
