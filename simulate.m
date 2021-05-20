function simulate(Options)
    order = Options('order');
    width = Options('width');
    height = Options('height');
    alpha = Options('alpha') * order;
    x_length = Options('x_length');
    y_length = Options('y_length');
    focus_x = Options('focus_x');
    focus_y = Options('focus_y');
    a = Options('a');
    N = Options('N');
    N_length = Options('N_length');
    f = Options('f');
    s = Options('s') * order;

    lambda = s / f; % 波の波長
    margin = (width * x_length - N * N_length) / 2; % シミュレーション範囲の左端からトランスデューサの左端までの余白

    Field = zeros(width, height); % シミュレーション範囲の初期化
    Waves = wave_initialize(N, focus_x * x_length, focus_y * y_length, lambda, N_length, margin, a);

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