-- Conway's game of life

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity gameoflife is
    Port(
        clk : in std_logic;
        rst : in std_logic;
        sel : out std_logic_vector(7 downto 0);
        led : out std_logic_vector(3 downto 0);
        dat : out std_logic_vector(7 downto 0)
    );
end gameoflife;

architecture behavioral of gameoflife is
    component conway
        Port(
            clk : in std_logic;
            rst : in std_logic;
            addr: in std_logic_vector(2 downto 0);
            dat: out std_logic_vector(7 downto 0);
            mode : in std_logic_vector(2 downto 0)
        );
    end component;
    signal counter : unsigned(2 downto 0);
    signal sel_cnt : std_logic_vector(2 downto 0);
    signal clock_div  : unsigned(14 downto 0);
    signal anotherclock_div  : unsigned(21 downto 0);
    signal clk_slow : std_logic;
    signal clk_slower: std_logic;
    signal modes : std_logic_vector(2 downto 0);
    signal rst_delay: std_logic;
begin

    led <= (clk_slow & sel_cnt);
    -- Instantiate the conway buffer
    therealconway : conway 
        port map (
            clk => clk_slower,
            rst => rst,
            addr => sel_cnt,
            dat => dat,
            mode => modes
        );
    
    -- Divide the clock
    process(clk, clock_div, clk_slow)
    begin
        if rising_edge(clk) then
            if clock_div = "111111111111111" then
                clk_slow <= not clk_slow;
                clock_div <= "000000000000000";
            else
                clock_div <= clock_div + 1;
            end if;
        end if;
    end process;

    process(clk, anotherclock_div, clk_slower)
    begin
        if rising_edge(clk) then
            if anotherclock_div = "1111111111111111111111" then
                clk_slower <= not clk_slower;
                anotherclock_div <= "0000000000000000000000";
            else
                anotherclock_div <= anotherclock_div + 1;
            end if;
        end if;
    end process;

    process(clk, rst, rst_delay)
    begin
        if rising_edge(clk) then
            rst_delay <= rst;
            if (rst = '1' and rst_delay = '0') then
                modes <= std_logic_vector(unsigned(modes) + 1);
            end if;
        end if;
    end process;


    process(counter)
    begin
        case counter is
            when "000" =>
                sel <= "01111111";
            when "001" =>
                sel <= "10111111";
            when "010" =>
                sel <= "11011111";
            when "011" =>
                sel <= "11101111";
            when "100" =>
                sel <= "11110111";
            when "101" =>
                sel <= "11111011";
            when "110" =>
                sel <= "11111101";
            when "111" =>
                sel <= "11111110";
            when others => null;
        end case;

    end process;

    sel_cnt <= std_logic_vector(counter);
    process(clk_slow)
    begin
        if rising_edge(clk_slow) then
            counter <= counter + 1;
        end if;
    end process;

end behavioral;
