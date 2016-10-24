%ada hist2
Root = 'C:\Users\Pei-Chun\Desktop\STAT231\project2\';
load([Root 'ht_face_values.mat']);
load([Root 'ht_nonface_values.mat']);
load([Root 'ht_one_points.mat']);
load([Root 'ht_zero_points.mat']);
load([Root 'alpha.mat']);
load([Root 'ht_threshold_t.mat']);

%Histgram
subplot(1,3,2);
face_class = sign(ht_face_values-ones(length(ht_face_values), 1) * ht_threshold_t)*alpha';
nonface_class = sign(ht_nonface_values-ones(length(ht_nonface_values), 1) * ht_threshold_t)*alpha';
[face_density,face_interval] = hist(face_class,50) ;
face_density = face_density/length(ht_face_values);
[nonface_density,nonface_interval] = hist(nonface_class,50);
nonface_density = nonface_density/length(ht_nonface_values);
bar(face_interval, face_density, 'r');
hold on;
bar(nonface_interval, nonface_density, 'g');
hold off;
legend('face','nonface');
title('T50  histogram');
line([0,0],[0,0.12]);

% ROC
subplot(1,3,3)
x = linspace(-3,3,100);
for i = 1:100
TP(i) = sum(face_class>x(i))/length(ht_face_values);;
FP(i) = sum(nonface_class>x(i))/length(ht_nonface_values);
end
plot(FP,TP);
xlabel('False alarm rate');
ylabel('Hit rate');
title 'Adaboost T50 ROC';

%Error of ewak classifiers in pool
subplot(1,3,1)
a = sort(error_h);
plot(a(1:1000));
xlabel('weak filter index');
ylabel('error');
axis([0 1000 0.3 0.5])
title('Increasing weak classifier errors');