% 波の初期化（焦点との距離から位相を逆算）
function wave = wave_initialize(cx, cy, tx, ty, lambda, a)
    distance = calc_distance(cx, cy, tx, ty);
    angle = calc_angle(distance, lambda);
    wave = a * complex(cos(-angle), sin(-angle));
end