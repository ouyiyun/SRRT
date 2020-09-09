% formula 8.11
function [isok,t,u,v] = LpRmSLmRp(x,y,phi)
    xi = x+sin(phi);
    eta = y-1-cos(phi);
    [~,rho] = cart2pol(xi,eta);
    if rho >= 2
        u = 4-sqrt(rho^2-4);
        if u <= 0
            t = mod2pi(atan2((4-u)*xi-2*eta,-2*xi+(u-4)*eta));
            v = mod2pi(t-phi);
            if t >= 0 && v >= 0
                isok = true;
                return
            end
        end
    end
    isok = false;
    t = 0;
    u = 0;
    v = 0;
end