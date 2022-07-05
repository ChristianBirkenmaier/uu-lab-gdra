constant speed : integer := 23;
signal a : std_logic;
signal b : std_logic;
signal c : std_logic;
signal d : std_logic;
signal S : std_logic;

-- end declarations

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
