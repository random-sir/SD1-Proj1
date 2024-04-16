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
  signal numIguais              : bit_vector(1 downto 0);

  component maximoDoisDados is
    port (
      A, B   : in  bit_vector(2 downto 0);
      maximo : out bit_vector(2 downto 0));
  end component maximoDoisDados;

  component IguaisCount is
    port (
      A, B, C : in  bit_vector(2 downto 0);
      D       : out bit_vector(1 downto 0));
  end component IguaisCount;

begin  -- architecture crazyDice_arch
 -- SumAll <= bit_vector ((unsigned(d1) + unsigned(d2)) + unsigned(d3));  --Soma de
                                                                      --todos

 SumAll <= bit_vector ((unsigned("00" & d1) + unsigned("00" & d2)) + unsigned("00" & d3));  --Soma de

  --Valores dos dados considerando o nullifier
  d1_alt <= "000" when nullifier = "01" else d1;
  d2_alt <= "000" when nullifier = "10" else d2;
  d3_alt <= "000" when nullifier = "11" else d3;

  --Soma com nullifier
 SumEnul <= bit_vector ((unsigned("00" & d1_alt) + unsigned("00" & d2_alt)) + unsigned("00" & d3_alt));  --Soma de

  max1_2   : maximoDoisDados port map (d1_alt, d2_alt, partialMaX);  --Maximo Parcial
  maxFinal : maximoDoisDados port map (partialMax, d3_alt, Max);  --Maximo Final

  Equals : iguaisCount port map (d1_alt, d2_alt, d3_alt, numIguais);  --Encontrando numero de iguais

  ThreeEq <= '1' when numIguais = "11" else '0';
  TwoEq   <= '1' when numIguais = "10" else '0';
  AllDiff <= '1' when numIguais = "00" else '0';

  AnySix <= '1' when ((d1_alt = "110") or (d2_alt = "110") or (d3_alt = "110")) else '0';

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

  sel <=
    B(2) when xor_vector(2) = '1' else
    B(1) when xor_vector(1) = '1' else
    B(0) when xor_vector(0) = '1' else
    '0';

  maximo <= A when sel = '0' else B;

end architecture maximoArch;

entity IguaisCount is

  port (
    A, B, C : in  bit_vector(2 downto 0);
    D       : out bit_vector(1 downto 0));

end entity IguaisCount;

architecture iguais_arch of IguaisCount is

begin  -- architecture iguais_arch

  D <= "11" when A = B and B = C else
       "10" when A = B or B = C or A = C else
       "00";

end architecture iguais_arch;
