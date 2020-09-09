function [pathX, pathY, pathDir, pathIsOk] = hasRSPath(startState, finalState, map, rmin)
pathX = [];
pathY = [];
pathDir = []; 
pathIsOk = false;
p = trans([startState(2) startState(1)], [finalState(2) finalState(1)], startState(3));
b = invTrans([startState(2) startState(1) startState(3)], p);
pTheta = finalState(3) - startState(3);
%获取所有的RS路径并且按路径从小到大的顺序排列
path = GetAllRSPath(p(1),p(2),pTheta,rmin);

%是否为空
if isempty(path)
    return; 
end
%此处加碰撞检测
for i = 1:size(path,1)
    [x,y,dir] = getPath(path(i),rmin);
    [x_,y_] = reductPath(x,y,[startState(2) startState(1) startState(3)]);
    isfree = true;
    for row = 1:size(x_,1)
        for col = 1:size(x_,2)
            if ~feasiblePoint(floor([x_(row,col) y_(row,col)]),map)
                isfree = false;
                break
            end
        end
        if col ~= size(x_,2)
            break
        end
    end
    
    if isfree
        pathX = x_;
        pathY = y_;
        pathDir = dir;
        pathIsOk = true;
        return 
    end  
end

pathX = [];
pathY = [];
pathDir = []; 
pathIsOk = false;

end

function [x,y] = reductPath(x1,y1,start)
    x = [];
    y = [];
    for i = 1:size(x1,1)
        x_seg = [];
        y_seg = [];
        for j = 1:size(x1,2)
            B = [x1(i,j) y1(i,j)];
            point = invTrans(start,B);
            x_seg = [x_seg point(1)];
            y_seg = [y_seg point(2)];
        end
        x = [x;x_seg];
        y = [y;y_seg];
    end
end

function p = trans(A, B, theta)
x = (B(1) - A(1))*cos(theta) + (B(2) - A(2))*sin(theta);
y = (B(2) - A(2))*cos(theta) - (B(1) - A(1))*sin(theta);
p = [x y];
end

function p = invTrans(A, B)
% A为坐标系原点 
% B为B在A坐标系下的坐标 B = [x y];

C = [cos(A(3)) sin(A(3));-sin(A(3)) cos(A(3))];
C = inv(C);
p = C * B';
p = [p(1)+A(1) p(2)+A(2)];
end