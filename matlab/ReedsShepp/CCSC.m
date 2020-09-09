function [isok,path] = CCSC(x,y,phi)
    Lmin = inf;
    type = repmat([RSPathElem.RS_NOP],[1,5]);
    path = RSPath(type,0,0,0,0,0);
    [isok,t,u,v] = LpRmSmLm(x,y,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(5,:),t,-pi/2,u,v,0);
        end
    end
    [isok,t,u,v] = LpRmSmLm(-x,y,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(5,:),-t,pi/2,-u,-v,0);
        end
    end
    [isok,t,u,v] = LpRmSmLm(x,-y,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(6,:),t,-pi/2,u,v,0);
        end
    end
    [isok,t,u,v] = LpRmSmLm(-x,-y,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(6,:),-t,pi/2,-u,-v,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(x,y,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(9,:),t,-pi/2,u,v,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(-x,y,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(9,:),-t,pi/2,-u,-v,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(x,-y,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(10,:),t,-pi/2,u,v,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(-x,-y,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(10,:),-t,pi/2,-u,-v,0);
        end
    end
    % backwards
    xb = x*cos(phi)+y*sin(phi);
    yb = x*sin(phi)-y*cos(phi);
    [isok,t,u,v] = LpRmSmLm(xb,yb,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(7,:),v,u,-pi/2,t,0);
        end
    end
    [isok,t,u,v] = LpRmSmLm(-xb,yb,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(7,:),-v,-u,pi/2,-t,0);
        end
    end
    [isok,t,u,v] = LpRmSmLm(xb,-yb,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(8,:),v,u,-pi/2,t,0);
        end
    end
    [isok,t,u,v] = LpRmSmLm(-xb,-yb,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(8,:),-v,-u,pi/2,-t,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(xb,yb,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(11,:),v,u,-pi/2,t,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(-xb,yb,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(11,:),-v,-u,pi/2,-t,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(xb,-yb,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(12,:),v,u,-pi/2,t,0);
        end
    end
    [isok,t,u,v] = LpRmSmRm(-xb,-yb,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(12,:),-v,-u,pi/2,-t,0);
        end
    end
    if Lmin == inf
        isok = false;
    else
        isok = true;
    end
end
