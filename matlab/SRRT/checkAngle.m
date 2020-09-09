function feasible = checkAngle(A, B, C, angle)
%A parent point
%B child point
%C xRand point
feasible = false;
BA = A - B;
BC = C - B;
angleB = acos(BA*BC'/(norm(BA,2)*norm(BC,2)));

if angleB >= pi-angle
    feasible = true;
end
end