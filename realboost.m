%Real boost
train_face_number = length(ht_face_values);
train_nonface_number = length(ht_nonface_values);
total_number = train_face_number+train_nonface_number;


B = 40;
T = 500;
%//initialization
    for i = 1:train_face_number
        D_face(1,i) = 1/total_number;
   end
    for i = 1:train_nonface_number
        D_nonface(1,i) = 1/total_number;
    end


for h = 1:T
    %for i = 1:length(integrated_face)
    %   face_values(i,h) = trygg(integrated_face{i},ht_one_points{h},ht_zero_points{h});
    %end
    %for i = 1:length(integrated_nonface)
    %   nonface_values(i,h) = trygg(integrated_nonface{i},ht_one_points{h},ht_zero_points{h});
    %end
    
    quarter_face = wprctile(ht_face_values(:,h),5,D_face);
    quarter_nonface = wprctile(ht_nonface_values(:,h),95,D_nonface);
    x = linspace(quarter_face,quarter_nonface,B);
    [bincount,binvalue(:,h)] = hist(vertcat(ht_face_values(:,h),ht_nonface_values(:,h)),x);
    one_bincount(:,h) = hist(face_values(:,h),binvalue(:,h));
    zero_bincount(:,h) =  hist(nonface_values(:,h),binvalue(:,h));
    
    for i = 1:length(ht_face_values)
        [min_val, face_index(i,h)] = min(abs(binvalue(:,h)-ht_face_values(i,h)));%bin find
    end
    for i = 1:length(ht_nonface_values)
        [min_val, nonface_index(i,h)] = min(abs(binvalue(:,h)-ht_nonface_values(i,h)));%bin find
    end
    for b = 1:B
        pt(b) =  D_face*(face_index(:,h)==b);
        qt(b) =  D_nonface*(nonface_index(:,h)==b);
        htb(b,h) = 1/2*log(pt(b)/qt(b));
    end
    Zt = 2*sum((pt.*qt).^0.5);
    for i = 1:length(ht_face_values)
        D_face(i) = D_face(i)*exp(-htb(face_index(i,h),h))/Zt;
    end
    for i = 1:length(ht_nonface_values)
        D_nonface(i) = D_nonface(i)*exp(htb(nonface_index(i,h),h))/Zt;
    end
end
save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\realboost_T500B40.mat');
save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\htb','htb')
save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\binvalue','binvalue')
save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\ht_one_points','ht_one_points')
save('C:\Users\Pei-Chun\Desktop\新增資料夾\STAT231\project2\ht_zero_points','ht_zero_points')