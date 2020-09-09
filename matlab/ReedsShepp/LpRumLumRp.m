% formula 8.8
function [isok,t,u,v] = LpRumLumRp(x,y,phi)
    xi = x+sin(phi);
    eta = y-1-cos(phi);
    rho = (20-xi^2-eta^2)/16;
    if rho >= 0 && rho <= 1
        u = -acos(rho);
        if u >= -pi/2
            [t,v] = tauOmega(u,u,xi,eta,phi);
            if t >=0 && v >=0
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