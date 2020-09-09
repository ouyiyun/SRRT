function pointC = nodeExpansion(pointA, pointB,stepSize)
%算AB的单位向量

unitVector = (pointB-pointA)/norm(pointB-pointA,2);

pointC = pointA + stepSize*unitVector;
end