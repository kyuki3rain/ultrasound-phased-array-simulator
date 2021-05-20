function simulate(Options)
    order = Options('order');
    width = Options('width');
    height = Options('height');
    alpha = Options('alpha');
    x_length = Options('x_length');
    y_length = Options('y_length');
    focus_x = Options('focus_x');
    focus_y = Options('focus_y');
    a = Options('a');
    N = Options('N');
    N_length = Options('N_length');
    f = Options('f');
    s = Options('s');

    lambda = s / order / f; % 波の波長
    margin = (width * x_length - N * N_length) / 2; % シミュレーション範囲の左端からトランスデューサの左端までの余白

    Field = zeros(width, height); % シミュレーション範囲の初期化
    Waves = wave_initialize(N, focus_x * x_length, focus_y * y_length, lambda, N_length, margin, a); % トランスデューサの初期化

    for x = 1:width
        for y = 1:height
            sum = 0;
            for i = 1:N
                % トランスデューサから出た音波を重ね合わせる
                sum = sum + calc_wave(x * x_length, y * y_length, i, Waves(i), lambda, N_length, margin, alpha);
            end
            Field(x,y) = sum;
        end
    end

    draw(Field, focus_x, focus_y, order)
end

function draw(Field, focus_x, focus_y, order)
    I = mat2gray(transpose(abs(Field)));
    figure
    imshow(I)

    figure
    plot(abs(Field(:,focus_y)))
    title("焦点を横に切断した断面図")
    xlabel("水平方向の位置( x " + order + "m)")
    ylabel("振幅")

    figure
    plot(abs(Field(focus_x, :)))
    title("焦点を縦に切断した断面図")
    xlabel("奥行き方向の位置( x " + order + "m)")
    ylabel("振幅")
end

% トランスデューサとの距離を計算（セルの幅と位置を考慮）
function distance = calc_distance(x, y, i, N_length, margin)
    distance = sqrt((x - i * N_length - margin)^2 + y ^ 2);
end

% トランスデューサから出る波の初期化（焦点との距離から位相を逆算）
function Waves = wave_initialize(N, width, height, lambda, N_length, margin, a)
    Waves = zeros(N, 1);
    for i = 1:N
        distance = calc_distance(width, height, i, N_length, margin);
        angle = calc_angle(distance, lambda);
        Waves(i) = a * complex(cos(-angle), sin(-angle));
    end
end

% 位相を求める（距離を波長で割ったあまりから計算）
function angle = calc_angle(distance, lambda)
    angle = rem(distance, lambda) / lambda * 2 * pi;
end

% 各トランスデューサからでた音波に対し、位相と振幅の調整を行う関数
function adjusted_wave = calc_wave(x, y, i, wave, lambda, N_length, margin, alpha)
    distance = calc_distance(x, y, i, N_length, margin);
    angle = calc_angle(distance, lambda);
    m = exp(-alpha * distance);
    adjusted_wave = m * wave * complex(cos(angle), sin(angle));
end