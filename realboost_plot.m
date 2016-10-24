%real hist
Root = 'C:\Users\Pei-Chun\Desktop\STAT231\project2\';
load([Root 'ht_face_values.mat']);
load([Root 'ht_nonface_values.mat']);
load([Root 'ht_one_points.mat']);
load([Root 'ht_zero_points.mat']);
load([Root 'htb.mat']);
load([Root 'binvalue.mat']);

T =500;
for i = 1:length(face_index);
    face_class(i) = 0;
    for h = 1:T
        face_class(i) = face_class(i)+htb(face_index(i,h),h);
    end
end

for i = 1:length(nonface_index);
    nonface_class(i) = 0;
    for h = 1:T
        nonface_class(i) = nonface_class(i)+htb(nonface_index(i,h),h);
    end
end

subplot(1,3,2);
[face_density,face_interval] = hist(face_class,50) ;
face_density = face_density/length(ht_face_values);
[nonface_density,nonface_interval] = hist(nonface_class,50);
nonface_density = nonface_density/length(ht_nonface_values);
bar(face_interval, face_density, 'r');
hold on;
bar(nonface_interval, nonface_density, 'g');
hold off;
legend('face','nonface');
title('T100  histogram');
line([0,0],[0,0.12]);

subplot(1,3,3)
x = linspace(-3,3,100);
for i = 1:100
TP(i) = sum(face_class>x(i))/length(ht_face_values);;
FP(i) = sum(nonface_class>x(i))/length(ht_nonface_values);
end
plot(FP,TP);
xlabel('False alarm rate');
ylabel('Hit rate');
title 'Realboost T100 ROC';

subplot(1,3,1)
a = sort(error_h);
plot(a(1:1000));
xlabel('weak filter index');
ylabel('error');
axis([0 1000 0.3 0.5])
title('Increasing weak classifier errors');