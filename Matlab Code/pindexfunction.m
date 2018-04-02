function [P_index]=pindexfunction(test_signal)




% figure(1); plot(test_signal);
% determining the sample rate : 1 sample every 60 minutes
Fs=1/(60*60);
% this vector assigns time stamps to each data in terms of seconds
t = (0:length(test_signal)-1)/Fs;

% finding the number of data points
NFFT = length(test_signal);

% performing Discrete Fourier transform.
fft_signal=fft(test_signal,NFFT);

% assigning cut_off point
cutoff=length(test_signal)/12;       % cut_off at hour 12
% cutoff=length(test_signal)/24;       % cut_off at hour 24

% creating a low frequency filter
LF_filter(1:NFFT,1)=0;
% cutoff frequency
LF_filter(1:cutoff,1)=1;
LF_filter((NFFT-cutoff):NFFT,1)=1;

% creating a low frequency filter
HF_filter(1:NFFT,1)=1;
% cutoff frequency
HF_filter(1:cutoff,1)=0;
HF_filter((NFFT-cutoff):NFFT,1)=0;


% remove the DC component for better visualization
% fft_signal(1)=0;                       

FV=((-NFFT/2:NFFT/2-1)/NFFT)*Fs;

% fftshift command: Shift zero-frequency component to center of spectrum.
% subplot(1,3,1); plot(FV,abs(fftshift(fft_signal)));
% subplot(1,3,2); plot(FV,fft_signal,'r');
% subplot(1,3,3); plot(FV,abs(fft_signal),'m');

test_signal_inversed= ifft(fft_signal,NFFT,'symmetric');
% figure(2); plot(test_signal_inversed);

% separating the high and low frequency components
HF_signal=fft_signal.*HF_filter;
LF_signal=fft_signal.*LF_filter;

% turning signal to the load
HF_load=real(ifft(HF_signal));
LF_load=real(ifft(LF_signal));
% figure(1);
% subplot(2,1,1); plot(HF_load);
% subplot(2,1,2); plot(LF_load,'r');


% testing whether the code works fine
% K=HF_load+LF_load;
% figure(2); 
% subplot(2,1,1);plot(K,'r'); 
% subplot(2,1,2);plot(test_signal,'black')


% calculating the predictability test
% note 1: sum(HF_load) is zero, but sum(abs(HF_load) is not zero and it's a
% big value, and it is the only index we need for the purpose of this study
P_index=1-[sum(abs(HF_load))/sum(test_signal)];
