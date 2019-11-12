library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity segment_select_decode is
port (input : in std_logic_vector (2 downto 0);
      sel_a_c, sel_b_d : out std_logic_vector (2 downto 0);
      disable_a_c, disable_b_d : out std_logic);
end segment_select_decode;

architecture DataFlow of segment_select_decode is

begin
    sel_a_c <= "000" when (input = 0) else -- segment 'a'
               "011" when (input = 5) else -- segment 'd'
               "100" when (input = 6) else -- segment 'e'
               "101" when (input = 7) else -- segment 'f'
               "111";
               
    sel_b_d <= "000" when (input = 1) else -- segment 'a'
               "001" when (input = 2) else -- segment 'b'
               "010" when (input = 3) else -- segment 'c'
               "011" when (input = 4) else -- segment 'd'
               "111";
               
    disable_a_c <= '0' when input = 1 or input = 2 or input = 3 or input = 4 else
                   '1';
    disable_b_d <= '0' when input = 0 or input = 5 or input = 6 or input = 7 else
                   '1';
            
end DataFlow;
