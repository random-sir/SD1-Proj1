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

  signal d1_alt, d2_alt, d3_alt : bit_vector(2 downto 0);
  signal partialMax             : bit_vector(2 downto 0);

  component maximoDoisDados is
    port (
      A, B   : in  bit_vector(2 downto 0);
      maximo : out bit_vector(2 downto 0));
  end component maximoDoisDados;

begin  -- architecture crazyDice_arch
  SumAll <= bit_vector (unsigned(d1) + unsigned(d2) + unsigned(d3));  --Soma de
                                                                      --todos
  d1_alt <= "000" when nullifier = "01" else d1;
  d2_alt <= "000" when nullifier = "10" else d2;
  d3_alt <= "000" when nullifier = "11" else d3;


  SumEnul <= bit_vector (unsigned(d1_alt) + unsigned(d2_alt) + unsigned(d3_alt));  -- Soma com nullifier

  max1_2   : maximoDoisDados port map (d1_alt, d2_alt, partialMaX);
  maxFinal : maximoDoisDados port map (partialMax, d3_alt, Max);

end architecture crazyDice_arch;



entity maximoDoisDados is

  port (
    A, B   : in  bit_vector(2 downto 0);   -- entradas
    maximo : out bit_vector(2 downto 0));  -- maior entre os dois

end entity maximoDoisDados;

architecture maximoArch of maximoDoisDados is
  signal xor_vector : bit_vector(2 downto 0);
  signal sel        : bit;
  signal AorB       : bit;
begin  -- architecture maximoArch

  xor_vector <= A xor B;

  with xor_vector select
    sel <=
    B(2) when "111"|"110"|"100"|"101",
    B(1) when "010"|"011",
    B(0) when "001",
    '0'  when others;

  maximo <= A when sel = '0' else B;

end architecture maximoArch;
