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