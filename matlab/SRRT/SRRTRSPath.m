clear all;
close all;

mapFile = '../map/maze.png';
rsFile = '../ReedsShepp';
addpath(rsFile);
I = imread(mapFile);
map = im2bw(I);

%计算参数d
angleMax = 0.4 * pi;
rmin = 10.0;
kmax = 1/rmin; %最大曲率
d = 1.226*sin(angleMax/2)/(kmax*(cos(angleMax/2))^2) * 2;

source=[504 160 0]; % source position in Y, X format
sDir = getPointFromAng(source(1:2), source(3), d);
goal=[583 596 pi/2]; % goal position in Y, X format
gDir = getPointFromAng(goal(1:2), goal(3), d);
display = true;
[yMax, xMax] = size(map);
% rmin = 8;

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

%初始化RRTTree
RRTTree = [source(1:2) -1; sDir 1];
falseCount = 0;
maxFalseCount = 10000;

counter = 0;

while falseCount < maxFalseCount
    xRand = goalBiased(goal(1:2), xMax, yMax, 0.2);
   
    %考虑初始转向角
    [xNear, Id] = nodeSelection(RRTTree, xRand, angleMax);
    if(isempty(xNear))
        continue;
    end
    %节点扩展
           
    xNew = nodeExpansion(xNear(1:2), xRand, 2*d);
    xNearParent = RRTTree(xNear(3),1:2);
    [x_,y_,isFeasible] = checkCurLine(xNearParent,xNear(1:2), xNew, map,d);
    if isFeasible
        RRTTree = [RRTTree;xNew Id];
        plot([xNearParent(2) xNear(2) xNew(2)], [xNearParent(1) xNear(1) xNew(1)], 'go');
        plot([xNearParent(2) xNear(2) xNew(2)], [xNearParent(1) xNear(1) xNew(1)], 'g-','LineWidth', 2);
        plot([x_(1) x_(end)],[y_(1) y_(end)],'ro');
        plot(x_,y_,'b-','LineWidth', 3);
        hold on
        counter=counter+1;
        M(counter)=getframe;
    else
        falseCount = falseCount + 1;
        continue
    end
    
    %若新生成的节点
    if norm([y_(end)-goal(1) x_(end)-goal(2)],2) > 5*rmin && norm([y_(end)-goal(1) x_(end)-goal(2)],2) < 10*rmin
        theta = atan2(xNew(1)-y_(end),xNew(2)-x_(end));
        if theta < 0
            theta = theta + 2*pi;
        end
        conState = [y_(end) x_(end) theta];
        [rsX, rsY, rsDir, rsIsOk] = hasRSPath(conState, goal, map, rmin);
        if rsIsOk
            for i=1:size(rsX,1)
                if rsDir(i) > 0
                    %棕色正行
                    plot(rsX(i,:),rsY(i,:),'Color', [165 42 42]/255,'LineWidth', 3);
                else
                    %亮蓝倒车
                    plot(rsX(i,:),rsY(i,:),'Color', [0 255 255]/255,'LineWidth', 3);
                end
                hold on
            end
            
            % 更新SRRT树
            RRTTree(end,:) = [y_(end) x_(end) Id];
            disp('found path!!!!!');
            break
        end
    end
end

if falseCount >= maxFalseCount
    disp('fail found path!!!!!');
    return
end

Id = RRTTree(end,3);
path = [RRTTree(end,1:2)];
while Id ~= -1
    path = [RRTTree(Id,1:2);path];
    Id = RRTTree(Id,3);
end

%未剪枝
n = size(path,1);
for i=2:n-1
    [x_,y_,~] = checkCurLine(path(i-1,:),path(i,:), path(i+1,:), map,d);
    plot(x_,y_,'g-','LineWidth',2);
    hold on
    counter=counter+1;
    M(counter)=getframe;
end
plot(path(:,2),path(:,1),'ro', 'MarkerSize',10);
%剪枝
purePath = extraneousNode(path,angleMax,d,map);
n = size(purePath,1);

plot(purePath(:,2),purePath(:,1),'b*', 'MarkerSize',10);
pureX = [];
pureY = [];
front = [];
back = [];
isFirst = true;
for i=1:n-2
    [x_,y_,~] = checkCurLine(purePath(i,:),purePath(i+1,:), purePath(i+2,:), map,d);
    if isFirst
        pureX = [pureX;x_];
        pureY = [pureY;y_];
        front = [x_(1), y_(1)];
        back = [x_(end),y_(end)];
        isFirst = false;
    else
        front = back;
        back = [x_(end), y_(end)];
        pureX = [pureX;front(1);x_];
        pureY = [pureY;front(2);y_];        
    end
end
plot(pureX,pureY,'r-','LineWidth',4);


