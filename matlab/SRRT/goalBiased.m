function randPoint = goalBiased(goal, xMax, yMax, goalPro)
%goal 目标点
%xMax yMax 地图边界
if rand(1) < goalPro
    randPoint = goal;
else
    randPoint = rand(1,2).*[yMax xMax];
end
end