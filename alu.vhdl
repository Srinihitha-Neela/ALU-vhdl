-- ARITHEMATIC LOGIC UNIT
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   

entity alu is
    port (
        a     : in  std_logic_vector(3 downto 0);
        b     : in  std_logic_vector(3 downto 0);
        sel   : in  std_logic_vector(2 downto 0); 
        result: out std_logic_vector(3 downto 0);
        carry : out std_logic;
        zero  : out std_logic
    );
end entity alu;

architecture behavioral of alu is
    signal temp : unsigned(4 downto 0); 
begin
    process(a, b, sel)
    begin
        case sel is
            when "000" => -- ADD
                temp   <= unsigned(a) + unsigned(b);
                result <= std_logic_vector(temp(3 downto 0));
                carry  <= temp(4);

            when "001" => -- SUBTRACT
                temp   <= unsigned(a) - unsigned(b);
                result <= std_logic_vector(temp(3 downto 0));
                carry  <= temp(4);

            when "010" => -- AND
                result <= a and b;
                carry  <= '0';

            when "011" => -- OR
                result <= a or b;
                carry  <= '0';

            when "100" => -- XOR
                result <= a xor b;
                carry  <= '0';

            when "101" => -- NOT A
                result <= not a;
                carry  <= '0';

            when "110" => -- Shift Left A
                result <= a(2 downto 0) & '0';
                carry  <= a(3);

            when "111" => -- Shift Right A
                result <= '0' & a(3 downto 1);
                carry  <= a(0);

            when others =>
                result <= (others => '0');
                carry  <= '0';
        end case;

        -- Zero flag
        if result = "0000" then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;
end architecture behavioral;
