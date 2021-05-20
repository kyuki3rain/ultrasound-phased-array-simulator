% トランスデューサから出る波の初期化（焦点との距離から位相を逆算）
function Waves = wave_initialize(N, width, height, lambda, N_length, margin, a)
    Waves = zeros(N, 1);
    for i = 1:N
        distance = calc_distance(width, height, i, N_length, margin);
        angle = calc_angle(distance, lambda);
        Waves(i) = a * complex(cos(-angle), sin(-angle));
    end
end