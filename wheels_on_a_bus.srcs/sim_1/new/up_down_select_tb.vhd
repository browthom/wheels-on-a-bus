library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity up_down_select_tb is
end up_down_select_tb;

architecture Behavioral of up_down_select_tb is

component up_down_select_19_25 is
port (clk, up, down, reset : in std_logic;
	  output : out natural range 0 to 1000000000);
end component;

signal clk, up, down, reset: std_logic := '0';
signal output : natural range 0 to 1000000000;

begin

U1: up_down_select_19_25 port map (clk => clk,
						           up => up,
						           down => down,
						           reset => reset,
						           output => output);
                             
    clock: process
        begin
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
        end process;
        
    test: process
        begin
            wait for 50 ns;
			down <= '1';
			wait for 10 ns;
			down <= '0';
			wait for 50 ns;
			down <= '1';
			wait for 10 ns;
			down <= '0';
            wait for 50 ns;
            down <= '1';
            wait for 10 ns;
            down <= '0';
            wait for 50 ns;
            down <= '1';
            wait for 10 ns;
            down <= '0';
			wait;
        end process;

end Behavioral;
