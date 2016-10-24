%Adaboost
%/////////////////read train image and integral
%trainread;
%////////////////compute all image's filter value

Root = 'C:\Users\Pei-Chun\Desktop\STAT231\project2\';
load([Root 'error_h.mat']);
load([Root 'threshold.mat']);
load([Root 'face_values.mat']);
load([Root 'nonface_values.mat']);
load([Root 'D_face.mat']);
load([Root 'D_nonface.mat']);

train_face_number = length(face_values);
train_nonface_number = length(nonface_values);
total_number = train_face_number+train_nonface_number;

T = 100;
for t =1:T
    [error_t(t),ada_feature] = min(error_h);
    disp(['t=' num2str(t) ', error_t = ' num2str(error_t(t))]);
    alpha(t) =  1/2*log((1-error_t(t))/error_t(t));
    
    if (t==1)
        threshold_t = threshold;
    end

    A = sign(face_values(:,ada_feature)-threshold_t(ada_feature));
    B = sign(nonface_values(:,ada_feature)-threshold_t(ada_feature));
    D_face = D_face.*exp(-alpha(t)* A)';
    D_nonface =  D_nonface.*exp(alpha(t)*B)';
    Zt = 2*(error_t(t)*(1-error_t(t)))^0.5;
    D_face = D_face/Zt;
    D_nonface=D_nonface/Zt;
    ht_one_points{t} = one_points{ada_feature};
    ht_zero_points{t} = zero_points{ada_feature};
    ht_threshold_t(t) = threshold_t(ada_feature);
    ht_face_values(:,t) = face_values(:,ada_feature);
    ht_nonface_values(:,t) = nonface_values(:,ada_feature);
    one_points(:,ada_feature)=[];
    zero_points(:,ada_feature)=[];
    face_values(:,ada_feature)=[];
    nonface_values(:,ada_feature)=[];
    threshold_t=[];
    error_h = [];
    mid_face = wprctile(face_values,50,D_face);
    mid_nonface = wprctile(nonface_values,50,D_nonface);
    threshold_t = (mid_face+mid_nonface)/2;
    for h = 1:length(face_values(1,:))
        error_h(h) = D_face*(sign(face_values(:,h)-threshold_t(h))==-1)+D_nonface*(sign(nonface_values(:,h)-threshold_t(h))==1);
        if (error_h(h) >1/2)
            error_h(h) = 1-error_h(h);
            pre_one_point =  one_points{h};
            pre_zero_point  =  zero_points{h};
            one_points{h} = pre_zero_point;
            zero_points{h}=pre_one_point;
            face_values(:,h)= -face_values(:,h);
            nonface_values(:,h)= -nonface_values(:,h);
            threshold_t(h) =   -threshold_t(h);
        end
    end
end
save([Root 'ht_face_values.mat'],'ht_face_values');
save([Root 'ht_nonface_values.mat'],'ht_nonface_values');
save([Root 'ht_one_points.mat'],'ht_one_points');
save([Root 'ht_zero_points.mat'],'ht_zero_points');
save([Root 'error_t.mat'],'error_t');
save([Root 'ht_threshold_t.mat'],'ht_threshold_t');
save([Root 'ada_D_face.mat'],'D_face');
save([Root 'ada_D_nonface.mat'],'D_nonface');