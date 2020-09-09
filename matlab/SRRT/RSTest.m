clear all;
close all;

I = imread('C:\Users\hp\Desktop\optimalRRT+BSpline\map\maze.png');
map = im2bw(I);
source=[504 160 0]; % source position in Y, X format
%计算无用的点表明起始点的方向
sDir = getPointFromAng(source(1:2), source(3), 20);
goal=[507 358 pi/2]; % goal position in Y, X format
gDir = getPointFromAng(goal(1:2), goal(3), 20);
display = true;
[yMax, xMax] = size(map);
rmin = 8;

figure(1);
if ~feasiblePoint(source,map)
    error('source lies on an obstacle or outside map'); 
end

if ~feasiblePoint(goal,map)
    error('goal lies on an obstacle or outside map'); 
end
if display
    imshow(map);
    hold on
    plot(source(2),source(1),'r.','MarkerSize',20);
    plot(goal(2),goal(1),'b.','MarkerSize',20);
    %绘制起始方向箭头
    plot([source(2) sDir(2)], [source(1) sDir(1)], 'Color', [0 188 128]/255, 'LineWidth', 2);   
    plot([goal(2) gDir(2)], [goal(1) gDir(1)], 'Color', [128 0 128]/255, 'LineWidth', 2); 
    % 绘制地图边框
    rectangle('position',[1 1 xMax-1 yMax-1],'edgecolor','b'); 
end

[x_, y_, dir, isok] = hasRSPath(source,goal,map,rmin);
if ~isok
    disp('No path!!');
    return
end

for i=1:size(x_,1)
    if dir(i) > 0
        plot(x_(i,:),y_(i,:),'b','LineWidth', 2);
    else
        plot(x_(i,:),y_(i,:),'r','LineWidth', 2);
    end
    hold on
end

