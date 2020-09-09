function paths = GetAllRSPath(x,y,phi,rmin)
%获取所有的RS路径并且按路径从小到大的顺序排列
    x = x/rmin;
    y = y/rmin;
    [isok1,path1] = CSC(x,y,phi);
    [isok2,path2] = CCC(x,y,phi);
    [isok3,path3] = CCCC(x,y,phi);
    [isok4,path4] = CCSC(x,y,phi);
    [isok5,path5] = CCSCC(x,y,phi);
    isoks = [isok1, isok2, isok3, isok4, isok5];
    paths1 = {path1, path2, path3, path4, path5};
    Lmin = inf;
    paths2 = [];
    allLength = [];
    for i = 1:5
        if isoks(i) == true
            elem = paths1{i};
            paths2 = [paths2;elem];
            lt = elem.totalLength;
            allLength = [allLength;lt];
        end
    end
    [~,A] = sortrows(allLength);
    paths = [];
    for i=1:size(A)
        paths = [paths;paths2(A(i))];
    end
%     m = size(paths2,2);
%     for i= 1:size(paths2)
%         
%     end
end