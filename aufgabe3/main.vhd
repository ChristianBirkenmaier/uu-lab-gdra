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

signal z0 : std_logic;
signal z1 : std_logic;
signal z2 : std_logic;

signal t0 : std_logic;
signal t1 : std_logic;
signal t2 : std_logic;
signal t3  : std_logic;

signal eins : std_logic;
signal zwei : std_logic;
signal drei : std_logic;
signal reset : std_logic;

signal s0 : std_logic;
signal s1 : std_logic;

signal geschlossen : std_logic;
signal laeuft : std_logic;
signal erster : std_logic;
signal zweiter : std_logic;
signal offen : std_logic;

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

t0 <= p_in(1);
t1 <= p_in(2);
t2 <= p_in(3);
t3 <= p_in(4);

eins <= not t3 and not t2 and not t1 and t0;
zwei <= not t3 and not t2 and t1 and not t0;
drei <= not t3 and t2 and not t1 and not t0;
reset <= t3 and not t2 and not t1 and not t0;

geschlossen <= not z2 and not z1 and not z0;
laeuft 	    <= not z2 and not z1 and	 z0;
erster 	    <= not z2 and     z1 and not z0;
zweiter     <= not z2 and     z1 and 	 z0; 
offen	    <= 	   z2 and     z1 and     z0;

process (clock)
begin
	if rising_edge(clock) then

		if(reset='1') then
			z2 <= '0';
		        z1 <= '0';
			z0 <= '1';

		        s0 <= '1';
		        s1 <= '0';

		elsif(eins='1' and laeuft='1') then
			z2 <= '0';
		        z1 <= '1';
		        z0 <= '0';

		elsif(eins='1' and erster='1') then
			z2 <= '0';
			z1 <= '1';
			z0 <= '1';

		elsif (drei='1' and zweiter='1') then
			z2 <= '1';
			z1 <= '0';
			z0 <= '0';

			s0 <= '1';
			s1 <= '1';

		elsif((zwei='1' and laeuft='1') or (zwei='1' and erster='1') or (zwei='1' and zweiter='1') or
		      (drei='1' and laeuft='1') or (drei='1' and erster='1') or 
		      (eins='1' and zweiter='1')) then
			      z2 <= '0';
			      z1 <= '0';
			      z0 <= '0';

			      s0 <= '0';
			      s1 <= '0';
		end if;
	end if;
end process;

p_out(1) <= s0;
p_out(2) <= s1;


end;
