library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity up_down_select_19_25 is
port (clk, up, down, reset : in std_logic;
	  output : out natural range 0 to 1000000000);
end up_down_select_19_25;

architecture Behavioral of up_down_select_19_25 is

signal temp_out : natural range 0 to 1000000000 := 50000000;

begin
    process(clk, reset, temp_out)
        begin
			if reset = '1' then
				temp_out <= 50000000;
            elsif rising_edge(clk) then
				if up = '1' then
					if temp_out > 5000000 then
						temp_out <= temp_out - 5000000;
					end if;
				elsif down = '1' then
					if temp_out < 50000000 then
						temp_out <= temp_out + 5000000;
					end if;
				end if;
            end if;
        end process;
        
output <= temp_out;
	
end Behavioral;