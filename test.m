order = 0.001; % 全体で用いる単位長さ(ここではmm)
alpha = 0.54 * order; % 減衰係数
x_length = 1; % 最小単位の横の大きさ（mm）
y_length = 1; % 最小単位の縦の大きさ（mm）
width = 100; % シミュレーション範囲の横の座標
height = 1000; % シミュレーション範囲の縦の座標
focus_x = 50; % 焦点の横軸の座標
focus_y = 50; % 焦点の縦軸の座標
a = 1; % 音波の初期振幅
N = 50; % トランスデューサの個数
f = 40000; % 周波数
s = 340 / order; % 音速

w = width / N; % トランスデューサ同士の間隔もしくは幅
lambda = s / f; % 波の波長

Field = zeros(width, height); % シミュレーション範囲の初期化
Waves = initialize(N, focus_x, focus_y, lambda, w, a); % トランスデューサの初期化

for i = 1:N
    for x = 1:width
        for y = 1:height
            % トランスデューサから出た音波を重ね合わせる
            Field(x,y) = Field(x,y) + calc_wave(x * x_length, y * y_length, i, Waves(i), lambda, w, alpha);
        end
    end
end

I = mat2gray(transpose(abs(Field)));

figure
imshow(I)

figure
plot(abs(Field(:,focus_y)))

% トランスデューサとの距離を計算（セルの幅と位置を考慮）
function distance = calc_distance(x, y, i, w)
    distance = sqrt((x - i * w)^2 + y ^ 2);
end

% トランスデューサから出る波の初期化（焦点との距離から位相を逆算）
function Waves = initialize(N, width, height, lambda, w, a)
    Waves = zeros(N, 1);
    for i = 1:N
        distance = calc_distance(width, height, i, w);
        angle = calc_angle(distance, lambda);
        Waves(i) = a * complex(cos(-angle), sin(-angle));
    end
end

% 位相を求める（距離を波長で割ったあまりから計算）
function angle = calc_angle(distance, lambda)
    angle = rem(distance, lambda) / lambda * 2 * pi;
end

% 各トランスデューサからでた音波に対し、位相と振幅の調整を行う関数
function adjusted_wave = calc_wave(x, y, i, wave, lambda, w, alpha)
    distance = calc_distance(x, y, i, w);
    angle = calc_angle(distance, lambda);
    m = exp(-alpha * distance);
    adjusted_wave = m * wave * complex(cos(angle), sin(angle));
end