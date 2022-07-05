JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);
	P ActionCode(Cfg)
		Device PartName(EP4CE22F17) Path("output_files/") File("main.sof") MfrSpec(OpMask(1));
ChainEnd;
AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
