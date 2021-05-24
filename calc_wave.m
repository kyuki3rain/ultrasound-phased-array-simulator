% 各トランスデューサからでた音波に対し、位相と振幅の調整を行う関数
function adjusted_wave = calc_wave(cx, cy, tx, ty, wave, lambda, alpha)
    distance = calc_distance(cx, cy, tx, ty);
    angle = calc_angle(distance, lambda);
    m = exp(- alpha * distance);
    adjusted_wave = m * wave * complex(cos(angle), sin(angle));
end