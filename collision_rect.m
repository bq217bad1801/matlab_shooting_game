function collision = collision_rect(rect1,rect2)
% 2つの四角が衝突しているかどうかを判断する関数

collision = false;

lower_left = [rect2.Position(1) rect2.Position(2)]; % 左下の座標
upper_left = [rect2.Position(1) rect2.Position(2)+rect2.Position(4)]; % 左上の座標
lower_right = [rect2.Position(1)+rect2.Position(3) rect2.Position(2)]; % 右下の座標
upper_right = [rect2.Position(1)+rect2.Position(3) rect2.Position(2)+rect2.Position(4)]; % 右上の座標

xrange = [rect1.Position(1) rect1.Position(1)+rect1.Position(3)]; % rect1の横の範囲
yrange = [rect1.Position(2) rect1.Position(2)+rect1.Position(4)]; % rect1の縦の範囲

% 左下の座標がもう一方の四角の中にあるとき
if lower_left(1) >= xrange(1) && lower_left(1) <= xrange(2)...
        && lower_left(2) >= yrange(1) && lower_left(2) <= yrange(2)
    collision = true;
end

% 左上の座標がもう一方の四角の中にあるとき
if upper_left(1) >= xrange(1) && upper_left(1) <= xrange(2)...
        && upper_left(2) >= yrange(1) && upper_left(2) <= yrange(2)
    collision = true;
end

% 右下の座標がもう一方の四角の中にあるとき
if lower_right(1) >= xrange(1) && lower_right(1) <= xrange(2)...
        && lower_right(2) >= yrange(1) && lower_right(2) <= yrange(2)
    collision = true;
end

% 右上の座標がもう一方の四角の中にあるとき
if upper_right(1) >= xrange(1) && upper_right(1) <= xrange(2)...
        && upper_right(2) >= yrange(1) && upper_right(2) <= yrange(2)
    collision = true;
end

end