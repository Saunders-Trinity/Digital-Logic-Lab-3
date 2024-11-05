library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity two_digit_split is
    Port ( data_in : in STD_LOGIC_VECTOR (6 downto 0);
				hex_1out : out std_logic_vector(6 downto 0);
			  hex_2out : out std_logic_vector(6 downto 0)
			  );
           
end two_digit_split;

architecture Behavioral of two_digit_split is

	signal hex1_s, hex2_s : std_logic_vector(3 downto 0);
	signal data_s : unsigned(6 downto 0);
	
	component bcd
	port(number_in: IN std_logic_vector(3 downto 0);
		number_out: OUT std_logic_vector(6 downto 0));
		end component;
	
	
begin

    U_HEX0 : bcd
        port map(
                number_in => hex1_s,
				number_out => hex_1out
            );

    U_HEX1 : bcd
        port map(
                number_in => hex2_s,
				number_out => hex_2out
            );

	--combinational logic for processing hex parts
	process(data_s) is
	   variable value1, value2 : integer := 0;
	begin
	   hex1_s <= (others => '0');
	   hex2_s <= (others => '0');
        
        --check to see if we are out of range
        if(data_s > 99) then
            hex1_s <= (others => 'U');
            hex2_s <= (others => 'U');
	
	--do math to split the 2 digit number into 2 separate digits
        else 
		  value1 := to_integer(data_s mod 10);
		  value2 := to_integer(data_s / 10);
		  hex1_s <= std_logic_vector(to_unsigned(value1,4));
		  hex2_s <= std_logic_vector(to_unsigned(value2,4));
        end if;

	end process;
		
	data_s <= unsigned(data_in);
end architecture;
