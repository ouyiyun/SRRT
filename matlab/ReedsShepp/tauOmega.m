function [tau,omega] = tauOmega(u,v,xi,eta,phi)
    delta = mod2pi(u-v);
    A = sin(u)-sin(delta);
    B = cos(u)-cos(delta)-1;
    t1 = atan2(eta*A-xi*B,xi*A+eta*B);
    t2 = 2*(cos(delta)-cos(v)-cos(u))+3;
    if t2 < 0
        tau = mod2pi(t1+pi);
    else
        tau = mod2pi(t1);
    end
    omega = mod2pi(tau-u+v-phi);
end
