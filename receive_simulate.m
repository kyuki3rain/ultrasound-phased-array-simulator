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

    lambda = s / f; % 波の波長
    margin = (width * x_length - N * N_length) / 2; % シミュレーション範囲の左端からトランスデューサの左端までの余白

    Transducers = zeros(N, 1); % シミュレーション範囲の初期化
    Field = zeros(width, height);

    for i = 1:N
        distance = calc_distance(focus_x * x_length, focus_y * y_length, i * N_length + margin, 0);
        p = -1;
        if i > 50
            p = 1;
        end
        angle = calc_angle(distance, lambda) + 0.05 * pi * 2 * randi([-1 1]);
        m = exp(-alpha * distance);
        adjusted_wave = m * complex(1, 0) * complex(cos(angle), sin(angle));
        Transducers(i, 1) = adjusted_wave;
%        Transducers(i, 1) = complex(quantizenumeric(real(adjusted_wave),1,4,3,'ceil'), quantizenumeric(imag(adjusted_wave),1,4,3,'ceil'));
    end

    figure
    plot(Transducers);
    
    figure
    plot(real(Transducers));
    
    figure
    plot(imag(Transducers));

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

    draw(Field, focus_x, focus_y, order);
end