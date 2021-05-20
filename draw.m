function draw(Field, focus_x, focus_y, order)
    I = mat2gray(transpose(abs(Field)));
    figure
    imshow(I)

    figure
    plot(abs(Field(:,focus_y)))
    title("焦点を横に切断した断面図")
    xlabel("水平方向の位置( x " + order + "m)")
    ylabel("振幅")

    figure
    plot(abs(Field(focus_x, :)))
    title("焦点を縦に切断した断面図")
    xlabel("奥行き方向の位置( x " + order + "m)")
    ylabel("振幅")
end