alpha = 0.54 / 1000;
width = 100;
focus_x = 50;
height = 1000;
focus_y = 500;
N = 50;
f = 1000;
s = 340*1000;

w = width / N;
lambda = s / f;

Field = zeros(width, height);
Waves = initialize(N, focus_x, focus_y, lambda, w);

for i = 1:N
    for x = 1:width
        for y = 1:height           
             for ys = 1:10
                 Field(x,y) = Field(x,y) + calc_wave(x, y + ys, i, Waves(i), lambda, alpha, w);
             end
        end
    end
end

I = mat2gray(abs(Field));

figure
imshow(I)

figure
plot(abs(Field(:,500)))

function distance = calc_distance(x, y, i, w)
    distance = sqrt((x - i * w)^2 + y ^ 2);
end

function Waves = initialize(N, width, height, lambda, w)
    Waves = zeros(N);
    for i = 1:N
        distance = calc_distance(width, height, i, w);
        angle = calc_angle(distance, lambda);
        Waves(i) = complex(cos(-angle), sin(-angle));
    end
end

function angle = calc_angle(distance, lambda)
    angle = rem(distance, lambda) * 2 * pi;
end

function adjusted_wave = calc_wave(x, y, i, wave, lambda, alpha, w)
    distance = calc_distance(x, y, i, w);
    angle = calc_angle(distance, lambda);
    m = 1 - alpha * distance;
    adjusted_wave = m * wave * complex(cos(angle), sin(angle));
end