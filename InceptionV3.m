clear all
clc
close all

%%
load('ECGData.mat');       %loading ECG database
%%
for jj=1:size(ECGData,2)
data = ECGData(jj).Data;    %getting database
data_3000(jj,:)=data(1:3000);
labels = ECGData(jj).labels_num;    %getting labels
labels_3000(jj,1)=labels;
end
[r1, c1]=find(labels_3000==1);
[r2, c2]=find(labels_3000==2);
[r3, c3]=find(labels_3000==3);
[r4, c4]=find(labels_3000==4);
[r5, c5]=find(labels_3000==5);
[r6, c6]=find(labels_3000==6);
[r7, c7]=find(labels_3000==7);


%%

NORMAL_tot = data_3000(r1,:);     %Taken all recordings label 1, 2 and 5, 6
AF_tot = data_3000(r2,:);
% IAVB_tot = data_3000(r3,:);
LBBB_tot = data_3000(r4,:);
RBBB_tot = data_3000(r5,:);
% PAC_tot = data_3000(r6,:);
% PVC_tot = data_3000(r7,:);


%%

NORMAL1=NORMAL_tot(1:200,:);%Taken first 200 recordings
NORMAL2 = normalize(NORMAL1);
[NORMAL, window]= smoothdata(NORMAL2,'gaussian');
AF1=AF_tot(1:200,:);
AF2 = normalize(AF1);
[AF, window2] = smoothdata(AF2,'gaussian');
% IAVB1=IAVB_tot(1:200,:);
% normalize(IAVB1);
% [IAVB, window1] = smoothdata(IAVB1,'gaussian');
LBBB1=LBBB_tot(1:200,:);
LBBB2 = normalize(LBBB1);
[LBBB, window3] = smoothdata(LBBB2,'gaussian');
RBBB1=RBBB_tot(1:200,:);
RBBB2 = normalize(RBBB1);
[RBBB, window4] = smoothdata(RBBB2,'gaussian');
% PAC1=PAC_tot(1:200,:);
% normalize(PAC1);
% [PAC, window5] = smoothdata(PAC1,'gaussian');
% PVC1=PVC_tot(1:200,:);
% normalize(PVC1);
% [PVC, window6] = smoothdata(PVC1,'gaussian');
%%
% for k=1:size(NORMAL1, 1)
%     NORMAL(k,:)=filtrare_baza(NORMAL1(k,:), size(NORMAL1,2));
% end
% 
% for k=1:size(AF1, 1)
%     AF(k,:)=filtrare_baza(AF1(k,:), size(AF1,2));
% end

% for k=1:size(IAVB1, 1)
%     IAVB(k,:)=filtrare_baza(IAVB1(k,:), size(IAVB1,2));
% end

% for k=1:size(LBBB1, 1)
%     LBBB(k,:)=filtrare_baza(LBBB1(k,:), size(LBBB1,2));
% end
% 
% for k=1:size(RBBB1, 1)
%     RBBB(k,:)=filtrare_baza(RBBB1(k,:), size(RBBB1,2));
% end

% for k=1:size(PAC1, 1)
%     PAC(k,:)=filtrare_baza(PAC1(k,:), size(PAC1,2));
% end
% 
% for k=1:size(PVC1, 1)
%     PVC(k,:)=filtrare_baza(PVC1(k,:), size(PVC1,2));
% end

%%

mkdir('InceptionV3Database');   %main folder
mkdir('InceptionV3Database\NORMAL'); %sub folder
mkdir('InceptionV3Database\AF');
% mkdir('InceptionV3Database\IAVB');
mkdir('InceptionV3Database\LBBB');
mkdir('InceptionV3Database\RBBB');
% mkdir('InceptionV3Database\PAC');
% mkdir('InceptionV3Database\PVC');


ecgtype = {'NORMAL', 'AF','LBBB', 'RBBB'};

%%

Fs = 500;
signalLength = 3000;
fb = cwtfilterbank('SignalLength',signalLength,'SamplingFrequency',Fs,'VoicesPerOctave',48);
for ii = 1:size(NORMAL,1)
    [wt, f] = fb.wt(NORMAL(ii, :));
    imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\NORMAL\';
    saveTimeFrequencyFigure(abs(wt), ii, 'NORMAL',imageRoot)
end

for ii = 1:size(AF,1)
    [wt, f] = fb.wt(AF(ii, :));
    imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\AF\';
    saveTimeFrequencyFigure(abs(wt), ii, 'AF',imageRoot)
end

% for ii = 1:size(IAVB,1)
%     [wt, f] = fb.wt(IAVB(ii, :));
%     imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\IAVB\';
%     saveTimeFrequencyFigure(abs(wt), ii, 'IAVB',imageRoot)
% end

for ii = 1:size(LBBB,1)
    [wt, f] = fb.wt(LBBB(ii, :));
    imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\LBBB\';
    saveTimeFrequencyFigure(abs(wt), ii, 'LBBB',imageRoot)
end

for ii = 1:size(RBBB,1)
    [wt, f] = fb.wt(RBBB(ii, :));
    imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\RBBB\';
    saveTimeFrequencyFigure(abs(wt), ii, 'RBBB',imageRoot)
end

% for ii = 1:size(PAC,1)
%     [wt, f] = fb.wt(PAC(ii, :));
%     imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\PAC\';
%     saveTimeFrequencyFigure(abs(wt), ii, 'PAC',imageRoot)
% end
% 
% for ii = 1:size(PVC,1)
%     [wt, f] = fb.wt(PVC(ii, :));
%     imageRoot = 'C:\Users\Tuf\Desktop\Dataset Licenta\InceptionV3Database\PVC\';
%     saveTimeFrequencyFigure(abs(wt), ii, 'PVC',imageRoot)
% end

%%
% readFcn = @(imagefilename)imresize(imread(imagefilename), [224 224]);
% filepath = "InceptionV3Database";
% Dataset = imageDatastore(filepath, "IncludeSubfolders", true, 'LabelSource','foldernames');
filepath1 = "Training";
Training_Dataset = imageDatastore(filepath1, "IncludeSubfolders", true, 'LabelSource', 'foldernames');
filepath2 = "Testing";
Testing_Dataset = imageDatastore(filepath2, "IncludeSubfolders", true, 'LabelSource', 'foldernames');
%% Initializing the pre-trained network

net = inceptionv3;
Input_Layer_Size = net.Layers(1).InputSize;
Resized_Training_Dataset = augmentedImageDatastore(Input_Layer_Size,Training_Dataset);
Resized_Testing_Dataset = augmentedImageDatastore(Input_Layer_Size, Testing_Dataset);

Feature_Learner = net.Layers(313).Name;
Output_Classifier = net.Layers(315).Name;

classes = ["AF" "LBBB" "NORMAL" "RBBB"];
New_Feature_Learner = fullyConnectedLayer(4, 'WeightLearnRateFactor',10, 'BiasLearnRateFactor',10 );
New_Classifier_Layer = classificationLayer("Name", "AF, LBBB, NORMAL, RBBB Classifier", 'Classes', classes);

% layers(143) = softmaxLayer();
% layers(144) = classificationLayer("Classes", {'AF','LBBB', 'NORMAL','RBBB'});

Network_Architecture = layerGraph(net);
% analyzeNetwork(Network_Architecture)
New_Network1 = replaceLayer(Network_Architecture,Feature_Learner,New_Feature_Learner);
New_Network2 = replaceLayer(New_Network1,Output_Classifier,New_Classifier_Layer);
% analyzeNetwork(New_Network)
% deepNetworkDesigner(New_Network2)


%% Training the Network
MiniBatchSize = 8;
Validation_Frequency = floor(numel(Resized_Testing_Dataset.Files)/MiniBatchSize);

opts = trainingOptions('sgdm', 'InitialLearnRate', 0.0001, ...
    'MaxEpochs', 12,'MiniBatchSize', MiniBatchSize, 'Plots','training-progress','ExecutionEnvironment',"gpu",'Shuffle','every-epoch','ValidationFrequency',Validation_Frequency, 'LearnRateSchedule', "piecewise", 'Verbose', false, "LearnRateDropFactor",0.2, "LearnRateDropPeriod",5);
ECGNet = trainNetwork(Resized_Training_Dataset, New_Network2, opts);

%% Evaluating the trained Model

[predictedLabels, Probability] = classify(ECGNet, Resized_Testing_Dataset);
accuracy = sum(predictedLabels == Testing_Dataset.Labels) / numel(predictedLabels);
[confmat, order] = confusionmat((Testing_Dataset.Labels), predictedLabels);
figure
heatmap(order, order, confmat);
title("Confusion Matrix InceptionV3, Accuracy " + round(accuracy*100,1) + "%");
xlabel("Predictie");
ylabel("Adevar");