library IEEE;
use IEEE.numeric_bit.all;

entity crazyDice is

  port (
    d1, d2, d3              : in  bit_vector(2 downto 0);  -- dados
    nullifier               : in  bit_vector(1 downto 0);
    SumAll                  : out bit_vector(4 downto 0);
    SumEnul                 : out bit_vector(4 downto 0);
    Max                     : out bit_vector(2 downto 0);
    ThreeEq, TwoEq, AllDiff : out bit;
    AnySix                  : out bit);
end entity crazyDice;

architecture crazyDice_arch of crazyDice is

begin  -- architecture crazyDice_arch
  SumAll <= bit_vector (unsigned(d1) + unsigned(d2) + unsigned(d3));  --Soma de
                                                                      --todos
  with nullifier select
    SumEnul <=                          -- Soma com nullifier
    bit_vector (unsigned(d2) + unsigned(d3))                when "01",
    bit_vector (unsigned(d1) + unsigned(d3))                when "10",
    bit_vector (unsigned(d1) + unsigned(d2))                when "11",
    bit_vector (unsigned(d1) + unsigned(d2) + unsigned(d3)) when others;

end architecture crazyDice_arch;
