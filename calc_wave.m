% 各トランスデューサからでた音波に対し、位相と振幅の調整を行う関数
function adjusted_wave = calc_wave(x, y, i, wave, lambda, N_length, margin, alpha)
    distance = calc_distance(x, y, i, N_length, margin);
    angle = calc_angle(distance, lambda);
    m = exp(- alpha * distance);
    adjusted_wave = m * wave * complex(cos(angle), sin(angle));
end

