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

