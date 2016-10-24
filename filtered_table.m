%project table
Root = 'C:\Users\Pei-Chun\Desktop\STAT231\project2\';
load([Root 'integrated_face.mat']);
load([Root 'integrated_nonface.mat']);
load([Root 'one_points.mat']);
load([Root 'zero_points.mat']);
train_face_number = length(integrated_face);
train_nonface_number = length(integrated_nonface);
total_number = train_face_number+train_nonface_number;
test_featurebank;

%//initialization
for i = 1:train_face_number
    D_face(1,i) = 1/total_number;
end
for i = 1:train_nonface_number
    D_nonface(1,i) = 1/total_number;
end
h = 1;
for jj =1:length(one_points)
    disp(['h=' num2str(h) ', jj = ' num2str(jj)]);
    for i = 1: length(integrated_face)
        face_values(i,h) = trygg(integrated_face{i},one_points{jj},zero_points{jj});
    end
    for i = 1: length(integrated_nonface)
        nonface_values(i,h) = trygg(integrated_nonface{i},one_points{jj},zero_points{jj});
    end
    mid_face_values = median(face_values(:,h),1);
    mid_nonface_values=median(nonface_values(:,h),1);
    threshold(h) =  (mid_face_values+mid_nonface_values)/2;
    A = sign(face_values(:,h)-threshold(h));
    B = sign(nonface_values(:,h)-threshold(h));
    error_h(h) = D_face*(A(:)==-1)+D_nonface*(B(:)==1);
    
    if (error_h(h) >1/2)
        error_h(h) = 1-error_h(h);
        pre_one_point =  one_points{jj};
        pre_zero_point  =  zero_points{jj};
        one_points{jj} = pre_zero_point;
        zero_points{jj}=pre_one_point;
        face_values(:,h) = -face_values(:,h);
        nonface_values(:,h) = -nonface_values(:,h);
        threshold(h)=-threshold(h);
    end
    %if (error_h(h)<=0.4)
        h=h+1;
        
    %else
       % face_values(:,h) = [];
        %nonface_values(:,h) = [];
        %threshold(h) = [];
        %error_h(h) = [];
        
    %end
end
save([Root 'face_values.mat'],'face_values');
save([Root 'nonface_values.mat'],'nonface_values');
save([Root 'error_h.mat'],'error_h');
save([Root 'threshold.mat'],'threshold');
save([Root 'D_face.mat'],'D_face');
save([Root 'D_nonface.mat'],'D_nonface');