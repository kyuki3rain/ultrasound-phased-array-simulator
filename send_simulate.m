function send_simulate(Options)
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
    t = 0.2;

    lambda = s / f; % 波の波長
    margin = (width * x_length - N * N_length) / 2; % シミュレーション範囲の左端からトランスデューサの左端までの余白

    Field = zeros(width, height); % シミュレーション範囲の初期化

    Waves = zeros(N, 1);
    for i = 1:N
        Waves(i, 1) = wave_initialize(focus_x * x_length, focus_y * y_length, i * N_length + margin, 0, lambda, a);
    end

    for x = 1:width
        for y = 1:height
            sum = 0;
            for i = 1:N
                % トランスデューサから出た音波を重ね合わせる
                sum = sum + calc_wave(x * x_length, y * y_length, i * N_length + margin, 0, Waves(i), lambda, alpha);
            end
            Field(x,y) = sum;
        end
    end

    Field = abs(Field).^2;
    mx = max(Field,[],'all');
    draw(Field, focus_x, focus_y, order);

    s_count = 1;
    r_count = 1;
    before_x = 0;
    before_y = 0;

    angle = atan(focus_y * y_length / abs(focus_x * x_length - width / 2 * x_length));
    for i = 1:N
        if Field(focus_x + round(i * sin(angle)), focus_y + round(i * cos(angle))) < mx * t
            break;
        else
            if round(i * sin(angle)) > before_x && round(i * cos(angle)) > before_y
                s_count = s_count + 1;
            end
            before_x = round(i * sin(angle));
            before_y = round(i * cos(angle));
        end
    end
    for i = 1:N
        if Field(focus_x - round(i * sin(angle)), focus_y - round(i * cos(angle))) < mx * t
            break;
        else
            if round(i * sin(angle)) > before_x || round(i * cos(angle)) > before_y
                s_count = s_count + 1;
            end
            before_x = round(i * sin(angle));
            before_y = round(i * cos(angle));
        end
    end
    for i = 1:N
        if Field(focus_x + round(i * cos(angle)), focus_y - round(i * sin(angle))) < mx * t
            break;
        else
            if round(i * cos(angle)) > before_x || round(i * sin(angle)) > before_y
                r_count = r_count + 1;
            end
            before_x = round(i * cos(angle));
            before_y = round(i * sin(angle));
        end
    end
    for i = 1:N
        if Field(focus_x - round(i * cos(angle)), focus_y + round(i * sin(angle))) < mx * t
            break;
        else
            if round(i * cos(angle)) > before_x || round(i * sin(angle)) > before_y
                r_count = r_count + 1;
            end
            before_x = round(i * cos(angle));
            before_y = round(i * sin(angle));
        end
    end

    disp(s_count);
    disp(r_count);
    disp(nnz(Field >= mx * t));
end