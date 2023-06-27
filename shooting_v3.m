function shooting_v3()
fig = figure("InnerPosition",[200 100 800 600]);
ax = axes;
ax.Color = 'k';
axis ij; % 軸反転

% 軸の最大値を設定
axmax = [800 600];
axis([0 axmax(1) 0 axmax(2)]);

% 四角の設定
rectSize_ship = 80; % 戦艦の大きさ
rec = rectangle('Position',[400 500 rectSize_ship rectSize_ship],FaceColor='W');
hold on
myimg = imread('images\myship4.png');
myimg = image(myimg,'XData',[400 400+rectSize_ship],'YData',[500 500+rectSize_ship]);

% 弾の設定
bulletrec = rectangle('Position',[400 -100 16 16],FaceColor='b');
bulletimg = imread('images\bullet2.png');
bulletimg = image(bulletimg,'XData',[400 416],'YData',[-100 -100+16]);
bullet_speed = 30;

% 敵の設定
rectSize_enemy = 50; % 敵の大きさ
enemyrec = rectangle('Position',[400 50 rectSize_enemy rectSize_enemy],FaceColor='b');
enemyimg = imread('images\myUFO.png');
enemyimg = image(enemyimg,'XData',[400 400+rectSize_enemy],'YData',[50 50+rectSize_enemy]);
enemy_vx = 20; % 敵のスピード

fig.WindowButtonMotionFcn = @cursorFnc; % マウスを動かしたときのコールバック
fig.WindowButtonDownFcn =  @clickFnc1;
fig.WindowKeyPressFcn =  @clickFnc2;

cnt = 0;
while(isgraphics(fig))

    pos = rec.Position;
    if bulletrec.Position(2) >= -10
        bulletrec.Position(2) = bulletrec.Position(2) -bullet_speed;
        % 画像の移動
        bulletimg.XData = [bulletrec.Position(1) bulletrec.Position(1)+16];
        bulletimg.YData = [bulletrec.Position(2) bulletrec.Position(2)+16];
    end

    % 敵の処理
    if enemyrec.Position(1)<=0
        enemy_vx = -enemy_vx;
    end
    if enemyrec.Position(1)+50 >= 800
        enemy_vx = -enemy_vx;
    end
    enemyrec.Position(1) = enemyrec.Position(1) + enemy_vx;
    enemyimg.XData = [enemyrec.Position(1) enemyrec.Position(1)+50];
    enemyimg.YData = [enemyrec.Position(2) enemyrec.Position(2)+50];

    % 弾と敵の衝突
    if collision_rect(enemyrec,bulletrec)
        enemyrec.Position(2) = -100; % 敵の位置の移動
        % 敵画像の移動
        enemyimg.XData = [enemyrec.Position(1) enemyrec.Position(1)+rectSize_enemy];
        enemyimg.YData = [enemyrec.Position(2) enemyrec.Position(2)+rectSize_enemy];

        bulletrec.Position(2) = -100; % 敵の位置の移動
        % 弾画像の移動
        bulletimg.XData = [bulletrec.Position(1) bulletrec.Position(1)+16];
        bulletimg.YData = [bulletrec.Position(2) bulletrec.Position(2)+16];
    end

    % 敵の再出現
    if enemyrec.Position(2) == -100
        cnt = cnt+1;
        if cnt > 30
            enemyrec.Position(2) = 50; % 敵の位置の移動
            % 敵画像の移動
            enemyimg.XData = [enemyrec.Position(1) enemyrec.Position(1)+rectSize_enemy];
            enemyimg.YData = [enemyrec.Position(2) enemyrec.Position(2)+rectSize_enemy];
            cnt = 0;
        end
    end
    pause(1/30);
end


    function cursorFnc(src,callbackdata)
        % カーソルの位置取得
        cp = ax.CurrentPoint;
        xMouse = cp(1,1); % x 座標
        yMouse = cp(1,2); % y 座標

        % 四角の移動
        rec.Position(1) = xMouse-rectSize_ship/2;

        % 画像の移動
        myimg.XData = [rec.Position(1) rec.Position(1)+rectSize_ship];
    end
    function clickFnc1(src,callbackdata)
        if bulletrec.Position(2) < 0
            bulletrec.Position(1) = pos(1)+rectSize_ship/2-8;
            bulletrec.Position(2) = pos(2);
        end
    end
    function clickFnc2(src,callbackdata)
        key = callbackdata.Character;
        if bulletrec.Position(2) < 0 && strcmp(key,' ')
            bulletrec.Position(1) = pos(1)+rectSize_ship/2-8;
            bulletrec.Position(2) = pos(2);
        end
    end
end