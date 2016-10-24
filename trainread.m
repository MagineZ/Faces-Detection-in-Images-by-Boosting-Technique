%face read and integral
Root = 'C:\Users\Pei-Chun\Desktop\STAT231\project2\';
train_face_subset_root = [Root 'train_face_subset\'];
train_nonface_subset_root = [Root 'train_nonface_subset\'];

train_face_subset = dir([train_face_subset_root]);
train_nonface_subset = dir([train_nonface_subset_root]);
%read train face
train_face_number = size(train_face_subset,1) -2;
train_nonface_number = size(train_nonface_subset,1) -2;
for num=1:train_face_number
    file_name=char(train_face_subset(num+2).name);
    faceFile=[train_face_subset_root file_name];
    data=imread(faceFile);
    data = im2double(data);
    integrated_face{num,1} = imageintegral(data(:,:,1));
end;
for num=1:train_nonface_number
    file_name=char(train_nonface_subset(num+2).name);
    faceFile=[train_nonface_subset_root file_name];
    data=imread(faceFile);
    data = im2double(data);
    integrated_nonface{num,1} = imageintegral(data(:,:,1));
end;
save([Root 'integrated_face.mat'],'integrated_face');
save([Root 'integrated_nonface.mat'],'integrated_nonface');