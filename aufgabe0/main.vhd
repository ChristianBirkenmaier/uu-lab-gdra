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
  -- bei vhdl ist alles von -- bis zeilenende Kommentar

  -- vorbereitete Signale sind p_in(1) bis p_in(16) und p_out(1) bis p_out(16),
  -- passend zur Beschriftung auf der Platine des Praktikums

  signal zustand: std_logic; -- so deklariert man ein eigenes signal
  -- signal my_signal_array: std_logic_vector (5 downto 3); -- oder gleich mehrere

  -- vorbereitetes Signal "clock":
  -- auch dann drin lassen, wenn man keinen clock braucht!
  constant speed : integer := 23; -- geschwindigkeit von "clock" hier waehlen
  -- (maximum:) 25 ==> 0.75 Hz, 24 ==> 1.5 Hz, 23 ==> 3 Hz, ..., 1 ==> 25 MHz
  -- Sinnvoll: 25 == 0.75 Hz == langsam zum mitschauen
  --           23 == 3 Hz == alles blinkt flott
  --           15 == 768 Hz == nicht schneller als das im Praktikum !

  -- die folgende Zeile, obwohl es kommentar ist, unbedingt drin lassen:
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

  p_out(3) <= p_in(3);     -- pin out3 folgt pin in3
  p_out(5) <= not p_in(6); -- pin out5 ist invertiert der eingangswert von in6
  p_out(6) <= not p_in(3) or p_in(6); -- out6 := /in3 or in6

  -- ein Beispiel, wie ein process aussehen kann:
  --   das Beispiel schaltet bei jedem "clock" den Ausgang p_out(7) um
  process (clock)                        -- immer so lassen
  begin                                  -- immer so lassen
    if rising_edge(clock) then           -- immer so lassen
      zustand<='0';
      if zustand='0' then	-- hier code schreiben
	zustand<='1';
      end if;
      -- zustand <= not zustand; -- alternative zum if-konstrukt darueber
    end if;                              -- immer so lassen
  end process;                           -- immer so lassen

  p_out(7) <= zustand;                   -- hier Ausgaben zuweisen

end;
