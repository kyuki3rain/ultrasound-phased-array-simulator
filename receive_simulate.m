function receive_simulate(Options)
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
    s = Options('s') / order;
    w = Options('w');
    l = Options('l');
    t = 0.5;

    lambda = s / f; % 波の波長
    margin = (width * x_length - N * N_length) / 2; % シミュレーション範囲の左端からトランスデューサの左端までの余白

    Transducers = zeros(N, 1); % シミュレーション範囲の初期化
    Field = zeros(width, height);

    Model = zeros(width, height);
    for x = (focus_x - l / 2):(focus_x + l / 2)
        distance = calc_distance(x * x_length, focus_y * y_length, width / 2 * x_length, 0);
        angle = calc_angle(distance, lambda);
        m = exp(-alpha * distance);
        Model(x, focus_y) = complex(1, 0) * complex(cos(angle), sin(angle)) * m;
    end

    for i = 1:N
        wave = 0;
        for x = 1:width
            for y = 1:height
                if (Model(x, y) == 0)
                    continue;
                end
                distance = calc_distance(x * x_length, y * y_length, i * N_length + margin, 0);
                angle = calc_angle(distance, lambda);
                m = exp(-alpha * distance);
                adjusted_wave = m * Model(x, y) * complex(cos(angle), sin(angle));
                if w == 0
                    wave = wave + adjusted_wave;
                else
                    wave = wave + complex(quantizenumeric(real(adjusted_wave),1,w,w - 1,'round'), quantizenumeric(imag(adjusted_wave),1,w,w - 1,'round'));
                end
            end
        end
        Transducers(i, 1) = wave;
    end

    % figure
    % plot(real(Transducers))
    % figure
    % plot(imag(Transducers))

    for x = 1:width
        for y = 1:height
            av = 0;
            for i = 1:N
                distance = calc_distance(x * x_length, y * y_length, i * N_length + margin, 0);
                angle = calc_angle(distance, lambda);
                m = exp(-alpha * distance);
                av = av + Transducers(i, 1) * complex(cos(-angle), sin(-angle)) / m;
            end
            Field(x, y) = av;
        end
    end

    Field = abs(Field).^2;
    draw(Field >= max(Field, [], 'all') * t, focus_x, focus_y, order);
end