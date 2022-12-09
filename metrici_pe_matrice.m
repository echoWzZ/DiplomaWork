 
% clc
% clear all
% close all

for jj=1:size(Testing_Dataset.Files,1)
nr = cell2mat(strfind(Testing_Dataset.Files(jj), '\'));
pos1=nr(end);
nr2=cell2mat(strfind(Testing_Dataset.Files(jj), '_'));
pos2=nr2(end);
nume=cell2mat(extractBetween(Testing_Dataset.Files(jj),pos1+1,pos2-1));
etichete_adev(jj,1)=categorical(string(nume));
end

n_clase=unique(etichete_adev);
for k=1:size(n_clase,1)
    clasa_curenta=string(n_clase(k));
    for ii=1:size(etichete_adev,1)
     if(strcmp(string(etichete_adev(ii)),clasa_curenta))
        actual(ii,k)=1;
     else
         actual(ii,k)=0;
     end
    end
end


% % % n_clase=unique(predictedLabels);
for k=1:size(n_clase,1)
    clasa_curenta=string(n_clase(k));
    for ii=1:size(predictedLabels,1)
     if(strcmp(string(predictedLabels(ii)),clasa_curenta))
        predict(ii,k)=1;
     else
         predict(ii,k)=0;
     end
    end
end


colorstring = 'rbgky';
figure
for k=1:size(n_clase,1)
    [X,Y,T,AUC] = perfcurve(actual(:,k),predict(:,k),1);
    plot(X,Y,'Color', colorstring(k),'LineWidth',2)
    hold on
    AUC_fin(k)=AUC;
    leg(k)=strcat(string(n_clase(k)), ' AUC= ', num2str(round(AUC,2)));
end
grid on
xlabel('1-Specificitate')
ylabel('Sensibilitate')
legend(leg)
title("ResNet ADAM - 3 clase")
%% Get Calculation using confusion matrix
% * Developer Er.Abbas Manthiri S 
% * Date  25-12-2016
% * Mail Id: abbasmanthiribe@gmail.com
% * Reference
% * <http://www.dataschool.io/simple-guide-to-confusion-matrix-terminology/ Dataschool>
% * <https://en.wikipedia.org/wiki/Confusion_matrix Wikipedia>
%
disp('____________Get Calculation using confusion matrix________________')
% n=5;
confmat = [99 21; 5 115];
c_matrix=confmat;
disp('confusion matrix generated')
disp(c_matrix)
disp('Running Calcualtion...')
[Result,RefereceResult]=confusion.getValues(c_matrix);
disp(Result)
disp(RefereceResult)


