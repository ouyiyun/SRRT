function randPoint = concentrateSample(allPc, goal, designVar)
%allPc 所有满足触发集中采样的点
%designVar 人为参数 Lh Ld Psid

%从allPc中随机取一个点
n = size(allPc,1);
m = randi([1 n],1);
Pc = allPc(m,:);
Psi0 = atan((goal(2) - Pc(2))/(goal(1) - Pc(1)));
Ld = designVar(1);
Lh = designVar(2);
Psid = designVar(3);
KsiPsi = -1 + 2 * rand(1);
Ksih = -1 + 2 * rand(1);
A = (Lh+Ld)*cos(Psi0+Psid*KsiPsi)*abs(Ksih);
B = (Lh+Ld)*sin(Psi0+Psid*KsiPsi)*abs(Ksih);
randPoint = goal' + [-1 0; 0 -1]*[A;B];
randPoint = [randPoint(2) randPoint(1)];
end