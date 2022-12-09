clear all
clc
close all

%% 
cale_sem='C:\Users\Tuf\Desktop\Dataset Licenta\TrainingSetFull\';
cale_eticheta='C:\Users\Tuf\Desktop\Dataset Licenta\';

%%
T=readtable([cale_eticheta 'REFERENCE.csv']);
%%% Recording nume semnal
%%% First_label categorie

%%
listing = dir(cale_sem);

% nume_fis=listing(jj).name;
% Iorig=imread([cale nume_fis]);
for jj=3:size(listing,1)
    sig=load([cale_sem listing(jj).name]);
    ECGData(jj-2).Data=sig(1,:);
% % %     ECGData(jj-2).Data2=sig(2,:); pt lead 2
    ECGData(jj-2).Data=sig.ECG.data(1,:);
ECGData(jj-2).signal=sig;
nume=listing(jj).name;
ECGData(jj-2).name=nume;
nume_scurt=extractBefore(nume,".");
id=find(strcmp(T.Recording, nume_scurt));
clasa=T.First_label(id);
if(clasa==1)
    clasaNume='NORMAL';
elseif(clasa==2)
    clasaNume='AF';
elseif(clasa==3)
    clasaNume='IAVB';
elseif(clasa==4)
    clasaNume='LBBB';
    elseif(clasa==5)
    clasaNume='RBBB';
    elseif(clasa==6)
    clasaNume='PAC';
    elseif(clasa==7)
    clasaNume='PVC';
    elseif(clasa==8)
    clasaNume='STD';
    elseif(clasa==9)
    clasaNume='STE';
end
ECGData(jj-2).labels_num=clasa;
ECGData(jj-2).labels_char=clasaNume;
end
%%
