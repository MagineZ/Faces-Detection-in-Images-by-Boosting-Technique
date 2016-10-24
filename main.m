clc;
%Please change the Root inthe  following .m files first
%And put train faces and non faces to train_face_subset and
%train_nonface_subser

%-----------------------------------------------------------------------------------------
%read train image and integral
%save integrated images to 'integrated_face.mat' and 'non_integrated_face.mat'

trainread;

%------------------------------------------------------------------------------------------
%create feature bank and save to 'one_points.mat' & 'zero_points.mat'

featurebank;

%-------------------------------------------------------------------------------------------
%caculate the threshold  and error rate of each filter and save to
%'threshold.mat' and 'error_h.mat'
%filter each image and save to 'face_values.mat' and 'nonface_values.mat'
%save initial weight to D_face and D_nonface
filtered_table;

%--------------------------------------------------------------------------------------------
%Adaboost, adjust the T value in adaboost.m for iterationtime
%save 'alpha.mat', 'error_t.mat', and new weight to 'ht_D_face.mat' 'ht_D_nonface.mat'
%save selected filters to 'ht_one_points.mat', 'ht_zero_points.mat'
%save ada filtered images to 'ht_face_values.mat', 'ht_nonface_values.mat'
adaboost;

%---------------------------------------------------------------------------------------------
%Ada boost histogram and ROC
ada_plot;

%----------------------------------------------------------------------------------------------
%Real boost, adjust the T value in adaboost.m for iterationtime
%Save the bin points of each filter to 'binvalue.mat'
%Save the weight of each filter and bin to 'htb.mat'
realboost;

%------------------------------------------------------------------------------------------------
%Realboost plot;
realboost_plot;

%-------------------------------------------------------------------------------------------------
%Test 
photoread;