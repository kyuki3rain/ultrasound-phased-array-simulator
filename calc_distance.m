% トランスデューサとの距離を計算（セルの幅と位置を考慮）
function distance = calc_distance(x, y, i, N_length, margin)
    distance = sqrt((x - i * N_length - margin)^2 + y ^ 2);
end