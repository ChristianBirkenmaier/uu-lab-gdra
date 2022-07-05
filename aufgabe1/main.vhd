library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity main is
  port(
    clock_50:in std_logic;
    signal key:in std_logic_vector (1 downto 0);
    signal p_in:in std_logic_vector (1 to 16);
    signal p_out:inout std_logic_vector (1 to 16);
    signal led:inout std_logic_vector (7 downto 0)
  );
end;


architecture dummy of main is
  -- user defines go here
constant speed : integer := 23;
signal a : std_logic;
signal b : std_logic;
signal c : std_logic;
signal d : std_logic;
signal S : std_logic;

-- end declarations
  signal clock:std_logic;
  signal d_in:std_logic_vector (1 to 16);
  signal d_out:std_logic_vector (1 to 16);
begin
  process(clock_50)
    variable div:std_logic_vector(25 downto 0):=(others=>'0');
  begin
    if rising_edge(clock_50) then
      if div=(div'range => '0') then
        div:=(div'range => '1');
      else
        div:=div-1;
      end if;
      clock <= div(speed);
    end if;
  end process;

  process(clock)
  begin
    if rising_edge(clock) then
      d_out <= d_in;
    end if;
  end process;

  led(0) <= clock;  -- debug
  led(1) <= key(0); -- suppress "unused pin led(x)" messages
  led(2) <= key(0);
  led(3) <= key(0);
  led(4) <= not key(1);
  led(5) <= not key(1);
  led(6) <= not key(1);
  led(7) <= not key(1);

-- user defined vhdl goes here

a <= p_in(4);
b <= p_in(3);
c <= p_in(2);
d <= p_in(1);

S <= (not d and not c and not b and not a)
   or(not d and not c and not b and a)
   or(not d and not c and b and a)
   or(not d and c and not b and not a)
   or(not d and c and not b and a)
   or(not d and c and b and not a)
   or(not d and c and b and a)
   or(d and not c and not b and not a)
   or(d and not c and not b and a)
   or(d and not c and b and not a)
   or(d and not c and b and a)
   or(d and c and not b and a);

p_out(1) <= S;

end;
