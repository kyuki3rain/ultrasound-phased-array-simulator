
function Options = option_initialize()
    Options = containers.Map('KeyType','char','ValueType','double');

    Options('order') = 0.001; % 全体で用いる単位長さ(ここではmm)
    Options('width') = 100; % シミュレーション範囲の横の座標
    Options('height') = 1000; % シミュレーション範囲の縦の座標
    Options('alpha') = 0.54; % 減衰係数
    Options('x_length') = 1; % 最小単位の横の大きさ（mm）
    Options('y_length') = 0.1; % 最小単位の縦の大きさ（mm）
    Options('focus_x') = 50; % 焦点の横軸の座標
    Options('focus_y') = 500; % 焦点の縦軸の座標
    Options('a') = 1; % 音波の初期振幅
    Options('N') = 100; % トランスデューサの個数
    Options('N_length') = 1; % トランスデューサの幅
    Options('f') = 5000000; % 周波数
    Options('s') = 340; % 音速(m)
end
