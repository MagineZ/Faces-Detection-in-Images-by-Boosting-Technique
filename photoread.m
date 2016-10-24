Root = 'C:\Users\Pei-Chun\Desktop\STAT231\project2\';
load([Root 'ht_one_points.mat']);
load([Root 'ht_zero_points.mat']);
load([Root 'htb.mat']);
load([Root 'binvalue.mat']);
T =100;
O_A = imread([Root '\test_picture\class_photo_2015.jpg']);
O_A = O_A(:,:,1);
O_A = im2double(O_A);
pixel = 24;
imshow(O_A);
hold on

for scale = 1./pow2(1/2:1/2:3)
    A =O_A;
    A = imresize(A,scale);
    n = length(A);
    m = length(A(:,1));
    s = pixel;
    for i = 1:s:m
        for j = 1:s:n
            if ((i+pixel<m) && (j +pixel<n))
                integrated_A = imageintegral( A(i:i+pixel-1,j:j+pixel-1));
                face_class(i,j) = 0;
                for h = 1:T
                    filted_A(:,h) = trygg(integrated_A, ht_one_points{h},ht_zero_points{h});
                    [min_val, A_index(h)] = min(abs(binvalue(:,h)-filted_A(:,h)));
                    face_class(i,j) = face_class(i,j)+htb(A_index(h),h);
                    if(i>1&&j>1)
                        if ((face_class(i,j)>0.1)&&(sign(face_class(i-s,j))~=1)&&(sign(face_class(i,j-s))~=1)&&(sign(face_class(i-s,j-s))~=1))
                            rectangle('Position',[ 1/scale*(j-1)+1,1/scale*(i-1)+1, pixel/scale, pixel/scale],'EdgeColor','y');
                            hold on
                        end
                        
                    end
                end
            end
        end
    end
end
hold off;