function shot = isInRange(pt,goal)
shot = false;
rd = randi(10);

dx = abs(pt(2) - goal(2));
dy = abs(pt(1) - goal(1));

if dx*dx + dy*dy < 200
    shot = true;
end
end