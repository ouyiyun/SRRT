function [isok,path] = CSC(x,y,phi)
    Lmin = inf;
    type = repmat([RSPathElem.RS_NOP],[1,5]);
    path = RSPath(type,0,0,0,0,0);
    [isok,t,u,v] = LpSpLp(x,y,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(15,:),t,u,v,0,0);
        end
    end
    [isok,t,u,v] = LpSpLp(-x,y,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(15,:),-t,-u,-v,0,0);
        end
    end
    [isok,t,u,v] = LpSpLp(x,-y,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(16,:),t,u,v,0,0);
        end
    end
    [isok,t,u,v] = LpSpLp(-x,-y,phi); % timeflp + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(16,:),-t,-u,-v,0,0);
        end
    end
    [isok,t,u,v] = LpSpRp(x,y,phi);
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(13,:),t,u,v,0,0);
        end
    end
    [isok,t,u,v] = LpSpRp(-x,y,-phi); % timeflip
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(13,:),-t,-u,-v,0,0);
        end
    end
    [isok,t,u,v] = LpSpRp(x,-y,-phi); % reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(14,:),t,u,v,0,0);
        end
    end
    [isok,t,u,v] = LpSpRp(-x,-y,phi); % timeflip + reflect
    if isok
        L = abs(t)+abs(u)+abs(v);
        if Lmin > L
            Lmin = L;
            path = RSPath(RSPathElem.Type(14,:),-t,-u,-v,0,0);
        end
    end
    if Lmin == inf
        isok = false;
    else
        isok = true;
    end
end