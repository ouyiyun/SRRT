% formula 8.2
function [isok,t,u,v] = LpSpRp(x,y,phi)
    [t1,u1] = cart2pol(x+sin(phi),y-1-cos(phi));
    if u1^2 >= 4
        u = sqrt(u1^2-4);
        theta = atan2(2,u);
        t = mod2pi(t1+theta);
        v = mod2pi(t-phi);
        if t >= 0 && v >= 0
            isok = true;
            return
        end
    end
    isok = false;
    t = 0;
    u = 0;
    v = 0;
end