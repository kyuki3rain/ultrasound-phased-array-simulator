Options = option_initialize();
Options('l') = 20;
Options('N') = 200;
Options('N_length') = 0.5;
Options('w') = 3;
Options('width') = 200;
Options('height') = 200;
Options('focus_x') = 100; % 焦点の横軸の座標
Options('focus_y') = 100; % 焦点の縦軸の座標
Options('x_length') = 0.5; % 最小単位の横の大きさ（mm）
Options('y_length') = 0.5; % 最小単位の縦の大きさ（mm）

receive_simulate(Options);