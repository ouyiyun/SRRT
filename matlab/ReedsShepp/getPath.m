function [x, y,dir]=getPath(path, rmin)
    type = path.type;
    x = [];
    y = [];
    dir = [];
    seg = [path.t,path.u,path.v,path.w,path.x];
    pvec = [0,0,0];
%     rmin = 5;
    for i = 1:5        
        if type(i) == RSPathElem.RS_STRAIGHT
            theta = pvec(3);
            dl = rmin*seg(i);
            dvec = [dl*cos(theta), dl*sin(theta), 0];
            dx = pvec(1)+linspace(0,dvec(1));
            dy = pvec(2)+linspace(0,dvec(2));
            x = [x;dx];
            y = [y;dy];
            pvec = pvec+dvec;
        elseif type(i) == RSPathElem.RS_LEFT
            theta = pvec(3);
            dtheta = seg(i);
            cenx = pvec(1)-rmin*sin(theta);
            ceny = pvec(2)+rmin*cos(theta);
            t = theta-pi/2+linspace(0,dtheta);
            dx = cenx+rmin*cos(t);
            dy = ceny+rmin*sin(t);
            x = [x;dx];
            y = [y;dy];
            theta = theta+dtheta;
            pvec = [dx(end),dy(end),theta];
            dl = dtheta;
        elseif type(i) == RSPathElem.RS_RIGHT
            theta = pvec(3);
            dtheta = -seg(i);
            cenx = pvec(1)+rmin*sin(theta);
            ceny = pvec(2)-rmin*cos(theta);
            t = theta+pi/2+linspace(0,dtheta);
            dx = cenx+rmin*cos(t);
            dy = ceny+rmin*sin(t);
            x = [x;dx];
            y = [y;dy];
            theta = theta+dtheta;
            pvec = [dx(end),dy(end),theta];
            dl = -dtheta;
        else
            % do nothing
        end
        
        
        if dl > 0
            dir = [dir;1];
        else
            dir = [dir;-1];
        end
    end
end