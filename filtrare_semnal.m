% % clear all
% % clc
% % close all
% % 
% % %%  filtrare semnal conform 
% % %%%% "Automatic ECG Classification Using Continuous Wavelet Transform and
% % %%%% Convolutional Neural Network"Tao Wang 1,* , Changhua Lu 1 , Yining Sun 2, Mei Yang 3, Chun Liu 4 and Chunsheng 
% % 
% load ECGData.mat
%
for k=1:size(ECGData,2)
    eticheta(k) = ECGData(k).labels_num;
end  

[r c] = find(eticheta==1);
NORMAL = ECGData(r').Data;
plot(NORMAL(1,:));
nr=13;
semnal=ECGData(nr).Data;
figure; plot(semnal)
M200 = movmedian(semnal,200);
hold on
plot(M200,'--g')
M600 = movmedian(semnal,600);
hold on
plot(M600,'--k')
semnal_fin=semnal-M200-M600;
%
signalLength = 3000;
close all
figure
plot(semnal(1:signalLength), 'linewidth',1)
hold on
plot(semnal_fin(1:signalLength),'-r','linewidth',1)
grid on
semnal_nou=wdenoise(semnal_fin,3,"Wavelet","db4");
% semnal_smooth= smoothdata(semnal_nou,'gaussian');
hold on
plot(semnal_nou(1:signalLength),'--g','linewidth',1)
% hold on
% plot(semnal_smooth(1:signalLength),'-m','linewidth',1)
%  hold on
%  plot(semnal_smooth2(1:signalLength),'--k','linewidth',1)
legend('original', 'baseline wander', 'noise removal','smoothdata')
xlabel('nr puncte') % trebuie transfomat in timp cu ajutorul frecventei
ylabel('amplitudine [mV]')

% %
%  Fs = 500;
% signalLength = 3000;
% fb = cwtfilterbank('SignalLength',signalLength,'SamplingFrequency',Fs,'VoicesPerOctave',48);
% [wt, f] = fb.wt(semnal(1:signalLength));
% im = ind2rgb(im2uint8(rescale(abs(wt))), jet(128));
% Original=imresize(im, [224 224]);
% 
% [wt, f] = fb.wt(semnal_fin(1:signalLength));
% im = ind2rgb(im2uint8(rescale(abs(wt))), jet(128));
% Baseline=imresize(im, [224 224]);
% 
% [wt, f] = fb.wt(semnal_nou(1:signalLength));
% im = ind2rgb(im2uint8(rescale(abs(wt))), jet(128));
% Denoise=imresize(im, [224 224]);
% 
% [wt, f] = fb.wt(semnal_smooth(1:signalLength));
% im = ind2rgb(im2uint8(rescale(abs(wt))), jet(128));
% Smoothdata=imresize(im, [224 224]);
% 
% figure;
% subplot(1,4,1); imshow(Original);title ([ECGData(nr).labels_char ' Original'])
% subplot(1,4,2); imshow(Baseline);title ([ECGData(nr).labels_char ' BL'])
% subplot(1,4,3); imshow(Denoise);title ([ECGData(nr).labels_char  ' BL+DN'])
% subplot(1,4,4); imshow(Smoothdata);title ([ECGData(nr).labels_char  ' BL+DN+Smooth'])
