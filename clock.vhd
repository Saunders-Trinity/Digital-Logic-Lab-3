library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.round;
use IEEE.std_logic_unsigned.all;

entity Clock is
port(
	clk_in: in std_logic;
	clk_out: out std_logic);
end Clock;

architecture behavior of Clock is
signal count:std_logic_vector (31 downto 0) := (others => '0');
signal tmp : std_logic := '0';
signal count_2 : std_logic_vector(3 downto 0) := (others => '0');

begin 
	process(clk_in)
	begin
		if(rising_edge(clk_in)) then
			if(unsigned(count) = to_unsigned(500000,32)) then
				tmp <= not tmp;
				count <= (others => '0');
			else
				count <= count + 1;
			end if;
		end if;
	end process;
	
		clk_out <= tmp;
end behavior;
