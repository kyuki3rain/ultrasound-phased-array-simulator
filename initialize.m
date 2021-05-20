
function Options = initialize()
    Options = containers.Map('KeyType','char','ValueType','double');

    order = 0.001; % 全体で用いる単位長さ(ここではmm)
    width = 100; % シミュレーション範囲の横の座標
    height = 1000; % シミュレーション範囲の縦の座標
    alpha = 0.54 * order; % 減衰係数
    x_length = 1; % 最小単位の横の大きさ（mm）
    y_length = 0.1; % 最小単位の縦の大きさ（mm）
    focus_x = 50; % 焦点の横軸の座標
    focus_y = 500; % 焦点の縦軸の座標
    a = 1; % 音波の初期振幅
    N = 50; % トランスデューサの個数
    N_length = 1; % トランスデューサの幅
    f = 5000000; % 周波数
    s = 340; % 音速(m)

    Options('order') = order;
    Options('width') = width;
    Options('height') = height;
    Options('alpha') = alpha;
    Options('x_length') = x_length;
    Options('y_length') = y_length;
    Options('focus_x') = focus_x;
    Options('focus_y') = focus_y;
    Options('a') = a;
    Options('N') = N;
    Options('N_length') = N_length;
    Options('f') = f;
    Options('s') = s;
end