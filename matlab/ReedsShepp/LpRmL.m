% formula 8.3/8.4
function [isok,t,u,v] = LpRmL(x,y,phi)
    xi = x-sin(phi);
    eta = y-1+cos(phi);
    [theta,u1] = cart2pol(xi,eta);
    if u1 <= 4
        u = -2*asin(u1/4);
        t = mod2pi(theta+u/2+pi);
        v = mod2pi(phi-t+u);
        if t >= 0 && u <= 0
            isok = true;
            return
        end
    end
    isok = false;
    t = 0;
    u = 0;
    v = 0;
end