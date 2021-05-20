
% 位相を求める（距離を波長で割ったあまりから計算）
function angle = calc_angle(distance, lambda)
    angle = rem(distance, lambda) / lambda * 2 * pi;
end