 function [x, y, isFeasible] = checkLine(A, B, map)
%A xNear
%B xNew
x = [];
y = [];
isFeasible = true;
ABDis = norm(B-A, 2);
ABStepSize = linspace(0,ABDis);
u = (B - A)/ABDis;
for i=1:100
    point = A + u * ABStepSize(i);
    if feasiblePoint(ceil(point), map)
        x = [x;point(2)];
        y = [y;point(1)];
    else
        isFeasible = false;
        break;
    end
end
end