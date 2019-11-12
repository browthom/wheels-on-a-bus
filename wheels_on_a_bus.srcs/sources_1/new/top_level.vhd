library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity top_level is
Port (clk, btnu, btnd : in std_logic;
      anode_out : out std_logic_vector(3 downto 0);
      seg_out : out std_logic_vector(7 downto 0));
end top_level;

architecture Behavioral of top_level is

component release_debouncer is
port (clk : in std_logic;
      button_press : in std_logic;
      output : out std_logic);
end component;

component up_down_select_19_25 is
port (clk, up, down, reset : in std_logic;
	  output : out natural range 0 to 1000000000);
end component;

component seven_segment_selector is
port (input : in std_logic_vector (2 downto 0);
	  enable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end component;

component three_bit_counter is
port (clk, reset : in std_logic;
	  output : out std_logic_vector (2 downto 0));
end component;

component var_clock_divider is
port (clk : in std_logic;
	  divider : in natural range 0 to 1000000000;
      clk_out : out std_logic);
end component;

component segment_select_decode is
port (input : in std_logic_vector (2 downto 0);
      sel_a_c, sel_b_d : out std_logic_vector (2 downto 0);
      disable_a_c, disable_b_d : out std_logic);
end component;

component multiplexer_seven_segment_display is
port ( clk : in std_logic;
	   input_1, input_2, input_3, input_4 : in std_logic_vector (7 downto 0);
       seg_out : out std_logic_vector (7 downto 0);
	   anode_out : out std_logic_vector (3 downto 0));
end component;

signal up_debounce, down_debounce : std_logic;
signal display_clk : std_logic;
signal disable_a_c, disable_b_d : std_logic;
signal seg_sel, seg_a_c_sel, seg_b_d_sel : std_logic_vector(2 downto 0);
signal seg_b_and_d, seg_a_and_c : std_logic_vector(7 downto 0);
signal display_clk_divider_bit : natural range 0 to 1000000000;

begin


up_deb: release_debouncer port map (clk => clk,
                                    button_press => btnu,
                                    output => up_debounce);
down_deb: release_debouncer port map (clk => clk,
                                    button_press => btnd,
                                    output => down_debounce);
up_down_selection: up_down_select_19_25 port map (clk => clk,
                                                  up => up_debounce,
                                                  down => down_debounce,
                                                  reset => '0',
                                                  output => display_clk_divider_bit);
                                    
-- Segment Select Circuit
display_clk_div: var_clock_divider port map (clk => clk,
                                             divider => display_clk_divider_bit,
                                             clk_out => display_clk);

display_cntr: three_bit_counter port map (clk => display_clk,
                                          reset => '0',
                                          output => seg_sel);
                                          
segment_sel: segment_select_decode port map (input => seg_sel,
                                             sel_a_c => seg_a_c_sel, 
                                             sel_b_d => seg_b_d_sel,
                                             disable_a_c => disable_a_c,
                                             disable_b_d => disable_b_d);
                                    
seg_a_and_c_sel : seven_segment_selector port map (input => seg_a_c_sel,
                                                   enable => disable_a_c,
                                                   seg_out => seg_a_and_c);
seg_b_and_d_sel : seven_segment_selector port map (input => seg_b_d_sel,
                                                   enable => disable_b_d,
                                                   seg_out => seg_b_and_d);

M1: multiplexer_seven_segment_display port map (clk => clk,
                                                input_1 => seg_b_and_d,
                                                input_2 => seg_a_and_c,
                                                input_3 => seg_b_and_d, 
                                                input_4 => seg_a_and_c,
                                                seg_out => seg_out,
                                                anode_out => anode_out);

end Behavioral;
