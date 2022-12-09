function F = filtrare_baza(semnal, signalLength)
% load ECGData.mat
%%
nr=13;
semnal=normalize(semnal);
% figure; plot(semnal)
M200 = movmedian(semnal,200);
% hold on
% plot(M200,'--g')
M600 = movmedian(semnal,600);
% hold on
% plot(M600,'--k')
semnal_fin=semnal-M200-M600;
%%
% signalLength = 3000;
close all
figure
plot(semnal(1:signalLength), 'linewidth',1)
hold on
plot(semnal_fin(1:signalLength),'-r','linewidth',1)
grid on
semnal_nou=wdenoise(semnal_fin,3,"Wavelet","db4");
 hold on
plot(semnal_nou(1:signalLength),'--g','linewidth',1)
 legend('original', 'baseline wandering','noise removal')
 xlabel('nr puncte') % trebuie transfomat in timp cu ajutorul frecventei
 ylabel('amplitudine [mV]')
% semnal_smooth= smoothdata(semnal_nou,'gaussian');
% F = semnal_smooth;