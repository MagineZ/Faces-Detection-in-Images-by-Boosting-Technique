function face_value = trygg(X,one_points,zero_points)
%FILTER BANK AND PROJECT VALUE
for i = 1:size(one_points,1)/4;
    positive(i) = X(one_points(i,2),one_points(i,1))...
        -X(one_points(i+1,2),one_points(i+1,1))...
        +X(one_points(i+2,2),one_points(i+2,1))...
        - X(one_points(i+3,2),one_points(i+3,1));
end
for i = 1:size(zero_points,1)/4;
    negative(i) = X(zero_points(i,2),zero_points(i,1))...
        -X(zero_points(i+1,2),zero_points(i+1,1))...
        +X(zero_points(i+2,2),zero_points(i+2,1))...
        - X(zero_points(i+3,2),zero_points(i+3,1));
end
    %one_points{fn} =  {positive_points};
    %zero_points{fn} =  {negative_points};
    face_value = sum(positive)-sum(negative);
    
end


