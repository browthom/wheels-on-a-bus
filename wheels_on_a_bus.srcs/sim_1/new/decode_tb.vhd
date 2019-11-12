library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decode_tb is
end decode_tb;

architecture Behavioral of decode_tb is

component segment_select_decode is
port (input : in std_logic_vector (2 downto 0);
      sel_a_c, sel_b_d : out std_logic_vector (2 downto 0);
      disable_a_c, disable_b_d : out std_logic);
end component;

component seven_segment_selector is
port (input : in std_logic_vector (2 downto 0);
	  disable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end component;

signal input : std_logic_vector (2 downto 0) := "000";
signal sel_a_c, sel_b_d : std_logic_vector (2 downto 0);
signal disable_a_c, disable_b_d : std_logic;
signal seg_out_a_c, seg_out_b_d : std_logic_vector (7 downto 0);

begin

U1: segment_select_decode port map (input => input,
                                    sel_a_c => sel_a_c,
                                    sel_b_d => sel_b_d,
                                    disable_a_c => disable_a_c,
                                    disable_b_d => disable_b_d);
                                    
U2: seven_segment_selector port map (input => sel_a_c,
                                     disable => disable_a_c,
                                     seg_out => seg_out_a_c);

U3: seven_segment_selector port map (input => sel_b_d,
                                     disable => disable_b_d,
                                     seg_out => seg_out_b_d);
                                  
test: process
    begin
        wait for 10 ns;
        input <= "001";
        wait for 10 ns;
        input <= "010";
        wait for 10 ns;
        input <= "011";
        wait for 10 ns;
        input <= "100";
        wait for 10 ns;
        input <= "101";
        wait for 10 ns;
        input <= "110";
        wait for 10 ns;
        input <= "111"; 
        wait;
    end process;

end Behavioral;
