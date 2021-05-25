Options = option_initialize();

Options('a') = 1;
Options('f') = 40000;
Options('N') = 10;
Options('N_length') = 5;
Options('focus_x') = 50;

receive_simulate(Options);