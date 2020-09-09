classdef RSPath
    properties
        type = repmat([RSPathElem.RS_NOP],[1,5]);
        t = 0;
        u = 0;
        v = 0;
        w = 0;
        x = 0;
        totalLength = 0;
    end
    methods
        function obj = RSPath(type,t,u,v,w,x)
            obj.type = type;
            obj.t = t;
            obj.u = u;
            obj.v = v;
            obj.w = w;
            obj.x = x;
            obj.totalLength = sum(abs([t,u,v,w,x]));
        end
    end
end