function point = getPointFromAng(A, theta, stepSize)
%已知一个点和夹角计算另一个点
A = [A(2) A(1)];
%单位向量
u = [cos(theta) sin(theta)];
point = A + stepSize .* u;
point = [point(2) point(1)];
end