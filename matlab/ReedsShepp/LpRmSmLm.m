% formula 8.9
function [isok,t,u,v] = LpRmSmLm(x,y,phi)
    xi = x-sin(phi);
    eta = y-1+cos(phi);
    [theta,rho] = cart2pol(xi,eta);
    if rho >= 2
        r = sqrt(rho^2-4);
        u = 2-r;
        t = mod2pi(theta+atan2(r,-2));
        v = mod2pi(phi-pi/2-t);
        if t >= 0 && u <= 0 && v <= 0
            isok = true;
            return
        end
    end
    isok = false;
    t = 0;
    u = 0;
    v = 0;
end