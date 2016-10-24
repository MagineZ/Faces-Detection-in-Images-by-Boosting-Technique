function ii = imageintegral(X)
%intergral the image X
[m,n] = size(X);
    s(:,1) = zeros(m+1,1);
    ii(1,:) = zeros(1,n+1);
    for x = 2:m+1
        for y = 2:n+1
            s(x,y) = s(x,y-1)+X(x-1,y-1);
            ii(x,y) = ii(x-1,y)+s(x,y);
        end
    end    