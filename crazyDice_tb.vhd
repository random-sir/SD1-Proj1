-------------------------------------------------------------------------------
-- Title      : Testbench for design "crazyDice"
-- Project    :
-------------------------------------------------------------------------------
-- File       : crazyDice_tb.vhd
-- Author     :   <random-sir@randomArch>
-- Company    :
-- Created    : 2024-04-12
-- Last update: 2024-04-12
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2024
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2024-04-12  1.0      random-sir  Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity crazyDice_tb is

end entity crazyDice_tb;

-------------------------------------------------------------------------------

architecture tb of crazyDice_tb is

  component crazyDice is
    port (
      d1, d2, d3              : in  bit_vector(2 downto 0);
      nullifier               : in  bit_vector(1 downto 0);
      SumAll                  : out bit_vector(4 downto 0);
      SumEnul                 : out bit_vector(4 downto 0);
      Max                     : out bit_vector(2 downto 0);
      ThreeEq, TwoEq, AllDiff : out bit;
      AnySix                  : out bit);
  end component crazyDice;


  signal d1        : bit_vector (2 downto 0);
  signal d2        : bit_vector (2 downto 0);
  signal d3        : bit_vector (2 downto 0);
  signal nullifier : bit_vector (1 downto 0);
  signal SumAll    : bit_vector (4 downto 0);
  signal SumEnul   : bit_vector (4 downto 0);
  signal Max       : bit_vector (2 downto 0);
  signal ThreeEq   : bit;
  signal TwoEq     : bit;
  signal AllDiff   : bit;
  signal AnySix    : bit;

begin  -- architecture tb

  DUT : crazyDice port map (
    d1        => d1,
    d2        => d2,
    d3        => d3,
    nullifier => nullifier,
    SumAll    => SumAll,
    SumEnul   => SumEnul,
    Max       => Max,
    ThreeEq   => ThreeEq,
    TwoEq     => TwoEq,
    AllDiff   => AllDiff,
    AnySix    => AnySix);



  teste : process is

    type test_crazyDice is record
      d1        : bit_vector (2 downto 0);
      d2        : bit_vector (2 downto 0);
      d3        : bit_vector (2 downto 0);
      nullifier : bit_vector (1 downto 0);
      SumAll    : bit_vector (4 downto 0);
      SumEnul   : bit_vector (4 downto 0);
      Max       : bit_vector (2 downto 0);
      ThreeEq   : bit;
      TwoEq     : bit;
      AllDiff   : bit;
      AnySix    : bit;
      str       : string (1 to 3);

    end record test_crazyDice;

    type test_sum is record
      d1        : bit_vector (2 downto 0);
      d2        : bit_vector (2 downto 0);
      d3        : bit_vector (2 downto 0);
      nullifier : bit_vector (1 downto 0);
      SumAll    : bit_vector (4 downto 0);
      SumEnul   : bit_vector (4 downto 0);
      str       : string (1 to 3);

    end record test_sum;

    type sumTest_array is array (natural range <>) of test_sum;  -- array do teste da soma

  begin  -- process teste

  end process teste;



end architecture tb;
