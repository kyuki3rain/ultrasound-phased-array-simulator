% トランスデューサとの距離を計算（セルの幅と位置を考慮）
function distance = calc_distance(cx, cy, tx, ty)
    distance = sqrt((cx - tx) ^ 2 + (cy - ty) ^ 2);
end