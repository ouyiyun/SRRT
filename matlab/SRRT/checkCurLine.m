function [x,y,isFeasible] = checkCurLine(W1,W2,W3,map,d)
%W1 xNearParent
%W2 xNear
%W3 xNew
isFeasible = true;
x = [];
y = [];
c1 = 7.2364;
c2 = 0.4*(6^0.5-1);
c3 = (c2+4)/(c1+6);
c4 = (c2+4)^2/(54*c3);
u1 = (W1-W2)/norm(W1-W2,2);
u2 = (W3-W2)/norm(W3-W2,2);
angleW2 = pi - acos(u1*u2');
beta = angleW2 / 2;
he = c3*d;
hb = he;
gb = c2*c3*d;
ge = gb;
kb = 6*c3*cos(beta)*d/(c2+4);
ke = kb;

%计算八个控制点
B0 = W2 + d*u1;
B1 = B0 - gb*u1;
B2 = B1 - hb*u1;
E0 = W2 + d*u2;
E1 = E0 - ge*u2;
E2 = E1 - he*u2;
ud = (E2 - B2)/norm(E2-B2,2);
B3 = B2 + kb*ud;
E3 = E2 - ke*ud;

%检查E0到W3的直线段是否障碍物避免
% [~, ~, flag] = checkLine(E0,W3,map);
% if ~flag
%     isFeasible = false;
%     return
% end
%三阶贝塞尔方阵
M = [1 0 0 0;-3 3 0 0; 3 -6 3 0; -1 3 -3 1];
%第一段贝塞尔
x1 = [];
y1 = [];
for u=0:0.01:1
    x_ = [1 u u^2 u^3]*M*[B0(2) B1(2) B2(2) B3(2)]';
    y_ = [1 u u^2 u^3]*M*[B0(1) B1(1) B2(1) B3(1)]';
    if ~feasiblePoint(floor([y_ x_]),map)
        isFeasible = false;
        return
    end
    x1 = [x1;x_];
    y1 = [y1;y_];
end


%第二段贝塞尔
x3 = [];
y3 = [];
for u=0:0.01:1
    x_ = [1 u u^2 u^3]*M*[E0(2) E1(2) E2(2) E3(2)]';
    y_ = [1 u u^2 u^3]*M*[E0(1) E1(1) E2(1) E3(1)]';
    if ~feasiblePoint(floor([y_ x_]),map)
        isFeasible = false;
        return
    end
    x3 = [x3;x_];
    y3 = [y3;y_];
end

x = x1;
y = y1;
for i=size(x3,1):-1:1
    x = [x;x3(i)];
    y = [y;y3(i)];
end
end