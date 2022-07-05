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
signal z0:      std_logic;
signal z1:      std_logic;
signal z2:      std_logic;
signal e0:      std_logic;
signal e1:      std_logic;
signal e2:      std_logic;
signal r:       std_logic;
signal z2new:   std_logic;
signal z1new:   std_logic;
signal z0new:   std_logic;
signal muenze:  std_logic;
signal f    :   std_logic;
signal m50ct :   std_logic;
signal m1euro:   std_logic;
signal m2euro:   std_logic;
signal fnew :   std_logic;

constant speed: integer := 20;

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

z0 <= d_out(1);
z1 <= d_out(2);
z2 <= d_out(3);
f  <= d_out(4);

e0 <= p_in(1);
e1 <= p_in(2);
e2 <= p_in(3);
r  <= p_in(4);


muenze  <=      e2 or      e1 or  e0 ;
m50ct    <= (not e2 and not e1 and e0);
m1euro   <= (not e2 and e1 and not e0);
m2euro   <= (e2 and not e1 and not e0);


--F'
fnew <= (not f and not z2 and not z1 and not z0 and not r and (m2euro or m1euro or m50ct)) or -- Zustand 0€    (normal)    und es wird eine Münze eingeworfen
        (    f and not z2 and not z1 and     z0 and not r and                   muenze) or -- Zustand 0,5€  (zwischen)  und die Taste ist gedrückt
        (not f and not z2 and not z1 and     z0 and not r and (m2euro or m1euro or m50ct)) or -- Zustand 0,5€  (normal)    und es wird eine Münze eingeworfen
        (    f and not z2 and     z1 and not z0 and not r and                   muenze) or -- Zustand 1€    (zwischen)  und die Taste ist gedrückt
        (not f and not z2 and     z1 and not z0 and not r and (m2euro or m1euro or m50ct)) or -- Zustand 1€    (normal)    und es wird eine Münze eingeworfen
        (    f and not z2 and     z1 and     z0 and not r and                   muenze) or -- Zustand 1,5€  (zwischen)  und die Taste bleibt gedrückt
        (not f and not z2 and     z1 and     z0 and not r and (m2euro or m1euro or m50ct)) or -- Zustand 1,5€  (normal)    und die es wird eine Münze eingeworfen
        (    f and     z2 and not z1 and not z0 and not r and                   muenze) ;  -- Zustand 2€    (zwischen)  und die Taste bleibt gedrückt

--Z'2
z2new <= (not f and not z2 and not z1 and not z0 and not r and m2euro)                    or -- Zustand 0€,   2€                   eingeworfen
         (not f and not z2 and not z1 and     z0 and not r and m2euro)                    or -- Zustand 0,5€, 2€                   eingeworfen
         (not f and not z2 and     z1 and not z0 and not r and (m2euro or m1euro))         or -- Zustand 1€,   2€ oder 1€           eingeworfen
         (not f and not z2 and     z1 and     z0 and not r and                 muenze)   or -- Zustand 1,5€, 2€ oder 1€ oder 0,5€ eingeworfen
         (    f and     z2 and not z1 and not z0 and not r and     muenze)               or -- Zustand 2€,   Taste       gedrückt
         (    f and     z2 and not z1 and not z0 and not r and not muenze)               or -- Zustand 2€,   Taste nicht gedrückt
         (not f and     z2 and not z1 and not z0 and not r)                              ;

--Z'1
z1new <= (not f and not z2 and not z1 and not z0 and not r and                  m1euro)                or -- Zustand 0€   (normal),   1€           eingeworfen
         (not f and not z2 and not z1 and     z0 and not r and                 (m1euro      or  m50ct)) or -- Zustand 0,5€ (normal)    1€ oder 0,5€ eingeworfen
         (    f and not z2 and     z1 and not z0 and not r and     muenze)                            or -- Zustand 1€   (zwischen), Münze        gedrückt
         (    f and not z2 and     z1 and not z0 and not r and not muenze)                            or -- Zustand 1€   (zwischen), Münze  nicht gedrückt
         (not f and not z2 and     z1 and not z0 and not r and not m2euro and not m1euro and not m50ct)  or -- Zustand 1€   (normal),   ausgangszustand
         (not f and not z2 and     z1 and not z0 and not r and                                 m50ct)  or -- Zustand 1€   (normal),   0,5€         eingeworfen
         (    f and not z2 and     z1 and     z0 and not r and     muenze)                            or -- Zustand 1,5€ (zwischen)  Münze        gedrückt
         (    f and not z2 and     z1 and     z0 and not r and not muenze)                            or -- Zustand 1,5€ (zwischen)  Münze  nicht gedrückt
         (not f and not z2 and     z1 and     z0 and not r and not m2euro and not m1euro and not m50ct)  ; 

--Z'0
z0new <= (not f and not z2 and not z1 and not z0 and not r and                                 m50ct)  or -- Zustand 0€,              0,5€         eingeworfen
         (    f and not z2 and not z1 and     z0 and not r and     muenze)                            or -- Zustand 0,5€ (zwischen), Taste        gedrückt
         (    f and not z2 and not z1 and     z0 and not r and not muenze)                            or -- Zustand 0,5€ (zwischen), Taste  nicht gedrückt
         (not f and not z2 and not z1 and     z0 and not r and not m2euro and not m1euro and not m50ct)  or -- Zustand 0,5€ (normal),   ausgangszustand
         (not f and not z2 and not z1 and     z0 and not r and                   m1euro)               or -- Zustand 0,5€ (normal),   1€           eingeworfen
         (not f and not z2 and     z1 and not z0 and not r and                                 m50ct)  or -- Zustand 1€ (normal),     0,5€         eigeworfen
         (    f and not z2 and     z1 and     z0 and not r and     muenze)                            or -- Zustand 1,5€,            Münze        gedrückt
         (    f and not z2 and     z1 and     z0 and not r and not muenze)                            or -- Zustand 1,5€             Münze  nicht gedrückt
         (not f and not z2 and     z1 and     z0 and not r and not m2euro and not m1euro and not m50ct)  ;


d_in(1) <= z0new;
d_in(2) <= z1new;
d_in(3) <= z2new;
d_in(4) <= fnew;

p_out(1) <= d_in(1);
p_out(2) <= d_in(2);
p_out(3) <= d_in(3);
p_out(4) <= d_in(4);
end;
