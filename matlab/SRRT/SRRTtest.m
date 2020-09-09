clear all;
close all;

%读入地图
mapFile = '../map/maze.png';
I = imread(mapFile);
map = im2bw(I);

angleMax = deg2rad(60);
kmax = 0.1; %最大曲率
d = 1.226*sin(angleMax/2)/(kmax*cos(angleMax/2)^2)*2;

%计算参数d
angleMax = 0.4 * pi;
rmin = 10.0;
kmax = 1/rmin; %最大曲率
d = 1.226*sin(angleMax/2)/(kmax*(cos(angleMax/2))^2) * 2;

source=[60 60 0]; % source position in Y, X format
sDir = getPointFromAng(source(1:2), source(3), d);
goal=[475 490 pi/2]; % goal position in Y, X format
gDir = getPointFromAng(goal(1:2), goal(3), d);
display = true;
[yMax, xMax] = size(map);

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

%concentrateSample参数
% Lh Ld Psid
LAndPsi = [6*d 1.5*d pi];
counter = 0;
concentraPoint = [];

while falseCount < maxFalseCount
    %两阶段采样策略
    %goal biased
    foundPath = false;
    if isempty(concentraPoint)
        xRand = goalBiased(goal(1:2), xMax, yMax, 0.2);
    %集中采样
    else
        %保持20%的向外拓展的机率
        if rand(1) > 0.2
            xRand = concentrateSample(concentraPoint, goal(1:2), LAndPsi);
        else
            xRand = goalBiased(goal(1:2), xMax, yMax, 0.2);
        end
    end
    
    %最近邻
    [xNear, Id] = nodeSelection(RRTTree, xRand, angleMax);
    if(isempty(xNear))
        continue;
    end
    
    %节点扩展   
    xNew = nodeExpansion(xNear(1:2), xRand, 2*d);
    
    %生成局部贝塞尔曲线
    xNearParent = RRTTree(xNear(3),1:2);
    [x_,y_,isFeasible] = checkCurLine(xNearParent,xNear(1:2), xNew, map,d);
    if isFeasible
        RRTTree = [RRTTree;xNew Id];
        if norm(xNew - goal(1,1:2),2)>= LAndPsi(1)-0.5*d && norm(xNew - goal(1,1:2),2)<= LAndPsi(1)+0.5*d
            concentraPoint = [concentraPoint;xNew];
            plot(xNew(2), xNew(1), 'ro', 'MarkerSize',10);
        end
        plot([xNearParent(2) xNear(2) xNew(2)], [xNearParent(1) xNear(1) xNew(1)], 'go');
        plot([xNearParent(2) xNear(2) xNew(2)], [xNearParent(1) xNear(1) xNew(1)], 'g-');
        plot([x_(1) x_(end)],[y_(1) y_(end)],'go');
        plot(x_,y_,'b-');
        hold on
        counter=counter+1;
        M(counter)=getframe;
        if foundPath
            disp('found path!!!!!');
            break;
        end
    else
        falseCount = falseCount + 1;
        continue
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
for i=2:n-1
    [x_,y_,~] = checkCurLine(purePath(i-1,:),purePath(i,:), purePath(i+1,:), map,d);
    pureX = [pureX;x_];
    pureY = [pureY;y_];
end
plot(pureX,pureY,'r-','LineWidth',4);