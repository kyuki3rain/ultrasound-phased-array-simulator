alpha = 0.54 / 1000;
width = 100;
focus_x = 50;
height = 1000;
focus_y = 500;
N = 50;
w = width / N;
f = 1000;
s = 340*1000;
lambda = s / f;

Field = zeros(width, height);
Waves = initialize(N);

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

function distance = calc_distance(x, y, i, w)
    distance = sqrt((x - i * w)^2 + y ^ 2);
end

function Waves = initialize(N)
    Waves = zeros(N);
    for i = 1:N
        Waves(i) = 1 + 0i;
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