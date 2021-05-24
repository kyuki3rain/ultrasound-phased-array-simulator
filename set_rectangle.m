function Phantom = set_rectangle(x, y, width, height)
    for i = 1:width
        for j = 1:width
            Phantom(x + i, y + j) = 1
        end
    end
end