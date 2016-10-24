tx=24;
ty=24;
m=24;
n=24;
x = floor(n/tx);
y = floor(m/ty);
%1x1 rectangles
fn = 1;
sq = 12;

for size = 4:2:sq
    rec = 1;
    for i = 1:tx-size+1
        for j = 1:ty-size+1
            rectangle_points(:,:,rec) = [[i-1,j-1];[i-1,j+size-1];[i+size-1,j+size-1];[i+size-1,j-1]];
            rec = rec+1;
        end
    end
    rec_n = rec-1;
    %filter type1 [1,-1]
    for i = 1:rec_n-size
        positive_points = horzcat(rectangle_points(:,1,i)*y+1,rectangle_points(:,2,i)*x+1);
        negative_points = horzcat(rectangle_points(:,1,i+size)*y+1,rectangle_points(:,2,i+size)*x+1);
        one_points{fn} =  positive_points;
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
    %filter type1 [1,-1,1]
    for i = 1:rec_n-2*size
        positive_points_1 = horzcat(rectangle_points(:,1,i)*y+1,rectangle_points(:,2,i)*x+1);
        positive_points_2 = horzcat(rectangle_points(:,1,i+2*size)*y+1,rectangle_points(:,2,i+2*size)*x+1);
        negative_points = horzcat(rectangle_points(:,1,i+size)*y+1,rectangle_points(:,2,i+size)*x+1);
        one_points{fn} =  vertcat(positive_points_1,positive_points_2);
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
    %filter type1 [1,1;-1,-1]
    for i = 1:rec_n-size*(tx-size+2)
        positive_points = vertcat(horzcat(rectangle_points(1:2,1,i)*y+1,rectangle_points(1:2,2,i)*x+1),horzcat(rectangle_points(3:4,1,i+size)*y+1,rectangle_points(3:4,2,i+size)*x+1));
        negative_points = vertcat(horzcat(rectangle_points(1:2,1,i+size*(tx-size+1))*y+1,rectangle_points(1:2,2,i+size*(tx-size+1))*x+1),horzcat(rectangle_points(3:4,1,i+size*(tx-size+2))*y+1,rectangle_points(3:4,2,i+size*(tx-size+2))*x+1));
        one_points{fn} =  positive_points;
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
    
    clear  rectangle_points;
end
for size = 4:2:sq
    rec = 1;
    for j = 1:ty-size+1
        for i = 1:tx-size+1
            rectangle_points(:,:,rec) = [[i-1,j-1];[i-1,j+size-1];[i+size-1,j+size-1];[i+size-1,j-1]];
            rec = rec+1;
        end
    end
    rec_n = rec-1;
    
    
    for i = 1:rec_n-size
        positive_points = horzcat(rectangle_points(:,1,i)*y+1,rectangle_points(:,2,i)*x+1);
        negative_points = horzcat(rectangle_points(:,1,i+size)*y+1,rectangle_points(:,2,i+size)*x+1);
        one_points{fn} =  positive_points;
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
    
    %filter type1 [1,-1,1]
    for i = 1:rec_n-2*size
        positive_points_1 = horzcat(rectangle_points(:,1,i)*y+1,rectangle_points(:,2,i)*x+1);
        positive_points_2 = horzcat(rectangle_points(:,1,i+2*size)*y+1,rectangle_points(:,2,i+2*size)*x+1);
        negative_points = horzcat(rectangle_points(:,1,i+size)*y+1,rectangle_points(:,2,i+size)*x+1);
        one_points{fn} =  vertcat(positive_points_1,positive_points_2);
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
    for i = 1:rec_n-size*(tx-size+2)
        positive_points = vertcat(horzcat(rectangle_points(1:2,1,i)*y+1,rectangle_points(1:2,2,i)*x+1),horzcat(rectangle_points(3:4,1,i+size)*y+1,rectangle_points(3:4,2,i+size)*x+1));
        negative_points = vertcat(horzcat(rectangle_points(1:2,1,i+size*(tx-size+1))*y+1,rectangle_points(1:2,2,i+size*(tx-size+1))*x+1),horzcat(rectangle_points(3:4,1,i+size*(tx-size+2))*y+1,rectangle_points(3:4,2,i+size*(tx-size+2))*x+1));
        one_points{fn} =  positive_points;
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
    % filter type [1,-1;1,-1]
    for i = 1:rec_n-size*(tx-size+2)
        positive_points = vertcat(horzcat(rectangle_points(:,1,i)*y+1,rectangle_points(:,2,i)*x+1),horzcat(rectangle_points(:,1,i+size*(tx-size+2))*y+1,rectangle_points(:,2,i+size*(tx-size+2))*x+1));
        negative_points = vertcat(horzcat(rectangle_points(:,1,i+size*(tx-size+1))*y+1,rectangle_points(:,2,i+size*(tx-size+1))*x+1),horzcat(rectangle_points(:,1,i+size)*y+1,rectangle_points(:,2,i+size)*x+1));
        one_points{fn} =  positive_points;
        zero_points{fn} =  negative_points;
        fn = fn+1;
    end
        clear  rectangle_points;
end
%save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\test_one_points.mat','one_points');
%save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\test_zero_points.mat','zero_points');