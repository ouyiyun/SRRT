function [isok,path] = CCC(x,y,phi)
    Lmin = inf;
    type = repmat([RSPathElem.RS_NOP],[1,5]);
    path = RSPath(type,0,0,0,0,0);
    [isok,t,u,v] = LpRmL(x,y,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(1,:),t,u,v,0,0);
        end
    end
    [isok,t,u,v] = LpRmL(-x,y,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(1,:),-t,-u,-v,0,0);
        end
    end
    [isok,t,u,v] = LpRmL(x,-y,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(2,:),t,u,v,0,0);
        end
    end
    [isok,t,u,v] = LpRmL(-x,-y,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(2,:),-t,-u,-v,0,0);
        end
    end
    % backwards
    xb = x*cos(phi)+y*sin(phi);
    yb = x*sin(phi)-y*cos(phi);
    [isok,t,u,v] = LpRmL(xb,yb,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(1,:),v,u,t,0,0);
        end
    end
    [isok,t,u,v] = LpRmL(-xb,yb,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(1,:),-v,-u,-t,0,0);
        end
    end
    [isok,t,u,v] = LpRmL(xb,-yb,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(2,:),v,u,t,0,0);
        end
    end
    [isok,t,u,v] = LpRmL(-xb,-yb,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(2,:),-v,-u,-t,0,0);
        end
    end
    if Lmin == inf
        isok = false;
    else
        isok = true;
    end
end