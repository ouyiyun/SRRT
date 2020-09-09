% formula 8.7
function [isok,t,u,v] = LpRupLumRm(x,y,phi)
    xi = x+sin(phi);
    eta = y-1-cos(phi);
    rho = (2+sqrt(xi^2+eta^2))/4;
    if rho <= 1
        u = acos(rho);
        [t,v] = tauOmega(u,-u,xi,eta,phi);
        if t >= 0 && v <= 0
            isok = true;
            return
        end
    end
    isok = false;
    t = 0;
    u = 0;
    v = 0;
end