library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity conway is
    Port(
        clk : in std_logic;
        rst : in std_logic;
        addr: in std_logic_vector(2 downto 0);
        dat: out std_logic_vector(7 downto 0);
        mode: in std_logic_vector(2 downto 0)
    );
end conway;

architecture arch of conway is
    type matrix88 is array (0 to 7) of std_logic_vector(7 downto 0);
    --
    constant init0 : matrix88 := ("00000000", 
                                  "00001000",
                                  "00000100",
                                  "00011100",
                                  "00000000",
                                  "00000000",
                                  "00000000",
                                  "00000000");

    constant init1 : matrix88 := ("00000000", 
                                  "00111100",
                                  "01000100",
                                  "00000100",
                                  "01001000",
                                  "00000000",
                                  "00000000",
                                  "00000000");

    constant init2 : matrix88 := ("00000000", 
                                  "00001000",
                                  "00000100",
                                  "00011100",
                                  "00000000",
                                  "00000000",
                                  "00000000",
                                  "00000000");

    constant init3 : matrix88 := ("00000000", 
                                  "00001000",
                                  "00000100",
                                  "00011100",
                                  "00000000",
                                  "00000000",
                                  "00000000",
                                  "00000000");

    constant init4 : matrix88 := ("00000000", 
                                  "00001000",
                                  "00000100",
                                  "00011100",
                                  "00000000",
                                  "00000000",
                                  "00000000",
                                  "00000000");

    constant init5 : matrix88 := ("00000000", 
                                  "00001000",
                                  "01000100",
                                  "00011100",
                                  "01100000",
                                  "00100000",
                                  "00000000",
                                  "00000000");

    constant init6 : matrix88 := ("00000000", 
                                  "00001000",
                                  "00111100",
                                  "00111100",
                                  "00111000",
                                  "00000000",
                                  "00111000",
                                  "00000000");

    constant init7 : matrix88 := ("00111100", 
                                  "00001000",
                                  "00100100",
                                  "00111100",
                                  "00100000",
                                  "00100000",
                                  "00100000",
                                  "00000000");

    type network88 is array (0 to 7) of matrix88;
    ------------------------------------------------------
    -- Declare cell component
    ------------------------------------------------------
    component cell
        Port(
            clk_in       : in std_logic;
            neighbors_in : in std_logic_vector(7 downto 0);
            load         : in std_logic;
            data_in      : in std_logic;
            state        : out std_logic
        );
    end component;

    signal databuffer : matrix88;
    signal initval: matrix88;
    signal netbuffer  : network88;
begin
    dat <= databuffer(to_integer(unsigned(addr)));
    -- dat <= initval(to_integer(unsigned(addr)));

    with mode select
        initval <= init0 when "000",
                   init1 when "001",
                   init2 when "010",
                   init3 when "011",
                   init4 when "100",
                   init5 when "101",
                   init6 when "110",
                   init7 when others;
        
    conwayrow : for i in 7 downto 0 generate
    begin
        conwaycol : for j in 7 downto 0 generate
        begin
            netbuffer(i)(j) 
                            <= (databuffer(to_integer(to_unsigned(i,3)-1))(to_integer(to_unsigned(j,3)  )) & 
                                databuffer(to_integer(to_unsigned(i,3)+1))(to_integer(to_unsigned(j,3)  )) & 
                                databuffer(to_integer(to_unsigned(i,3)  ))(to_integer(to_unsigned(j,3)-1)) & 
                                databuffer(to_integer(to_unsigned(i,3)  ))(to_integer(to_unsigned(j,3)+1)) & 
                                databuffer(to_integer(to_unsigned(i,3)-1))(to_integer(to_unsigned(j,3)+1)) & 
                                databuffer(to_integer(to_unsigned(i,3)-1))(to_integer(to_unsigned(j,3)-1)) & 
                                databuffer(to_integer(to_unsigned(i,3)+1))(to_integer(to_unsigned(j,3)+1)) & 
                                databuffer(to_integer(to_unsigned(i,3)+1))(to_integer(to_unsigned(j,3)-1)) );

            singlecell : cell
                port map (
                    clk_in       => clk, 
                    neighbors_in => netbuffer(i)(j),
                    load         =>  rst,
                    data_in      => initval(i)(j), 
                    state        => databuffer(i)(j)
                );

        end generate;
    end generate;

end arch;
