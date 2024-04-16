-------------------------------------------------------------------------------
-- Title      : Testbench for design "crazyDice"
-- Project    :
-------------------------------------------------------------------------------
-- File       : crazyDice_tb.vhd
-- Author     :   <random-sir@randomArch>
-- Company    :
-- Created    : 2024-04-12
-- Last update: 2024-04-16
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



  process

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


    type tests_array is array (natural range <>) of test_crazyDice;  -- array do teste da soma

    constant tests : tests_array := (("100", "101", "110", "00", "01111", "01111", "110", '0', '0', '1', '1', "456"),
                                     ("100", "101", "110", "01", "01111", "01011", "110", '0', '0', '1', '1', "_56"),
                                     ("100", "101", "110", "10", "01111", "01010", "110", '0', '0', '1', '1', "4_6"),
                                     ("100", "101", "110", "11", "01111", "01001", "101", '0', '0', '1', '0', "45_"),
                                     ("110", "110", "110", "00", "10010", "10010", "110", '1', '0', '0', '1', "666"),
                                     ("110", "110", "110", "01", "10010", "01100", "110", '0', '1', '0', '1', "_66"),
                                     ("000", "000", "000", "00", "00000", "00000", "000", '1', '0', '0', '0', "000"));

  begin  -- process teste

    for k in tests'range loop
      d1        <= tests(k).d1;
      d2        <= tests(k).d2;
      d3        <= tests(k).d3;
      nullifier <= tests(k).nullifier;

      wait for 1 ns;

      assert (tests(k).SumAll = SumAll) report "Fail SumAll:" & tests(k).str severity error;
      assert (tests(k).SumEnul = SumEnul) report "Fail SumEnul:" & tests(k).str severity error;
      assert (tests(k).Max = Max) report "Fail Max :" & tests(k).str severity error;
      assert (tests(k).ThreeEq = ThreeEq) report "Fail ThreeEq :" & tests(k).str severity error;
      assert (tests(k).TwoEq = TwoEq) report "Fail TwoEq:" & tests(k).str severity error;
      assert (tests(k).AllDiff = AllDiff) report "Fail AllDiff:" & tests(k).str severity error;
      assert (tests(k).AnySix = AnySix) report "Fail AnySix:" & tests(k).str severity error;

    end loop;  -- k

    d1        <= "000";
    d2        <= "000";
    d3        <= "000";
    nullifier <= "00";

    assert false report "Test done." severity note;
    wait;

  end process;



end architecture tb;
