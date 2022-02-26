ecgbase = 'sub01_snr12dB_l1_c0_mecg'; %ecg .dat name
noise = 'sub01_snr12dB_l1_c3_noise1'; %ecg .dat name
% physionet WFDB toolbox for Matlab - functions rdsamp(), rdann() 
% read samples, firstSample and lastSample are optional parameters
[signalbase, fs1, tm1] = rdsamp(ecgbase,[]);
[noise, fs, tm] = rdsamp(noise,[]);

% Combine signal with noise
signal = signalbase(:,2);
noise = noise(:,2);
signoise = signal + noise;

% Denoising Part using Non-Local Means algorithm
% set parameters - see Tracey & Miller for a discussion
PatchHW=20;  % patch half-width; ~ size of smallest feature, in samples
P = 500;    % neighborhood search width; wider=more computation but more
             % channces to find a similar patch
% Find noise sigma with 12dB SNR
targetSNR_lin = lin10(12);
signalPower = var(signal);
targetNoiseSigma = sqrt(signalPower/targetSNR_lin);
% since we know sigma here, use that to set NLM bandwidth parameter
lambda=0.6*targetNoiseSigma;
% call non-local means function to denoised the signal
X = NLM_1dDarbon(signoise,lambda,P,PatchHW)
% change NaN value into zero
X(isnan(X))=0;

% assumed that the 3000 points are 6 seconds of data...?
Fs = 250; %  [samples/s] sampling frequency 
T  = 1/Fs;      % [s] sampling period       
N  = 75000;       % [samples] Length of signal
t  = (0:N-1)*T; % [s] Time vector
deltaF = Fs/N; % [1/s]) frequency intervalue of discrete signal
figure('color','white','position',[70 100 600 900]); 
subplot(3,1,1);
plot(1e3*t,X)
title({'Heartbeat data'})
xlabel('t (milliseconds)')
ylabel('X(t)')
% compute the fast fourier transform
Y = fft(X);
% manually shifting the FFT
Y = abs(Y/N);
Amp = [Y(ceil(end/2)+1:end)' Y(1) Y(2:ceil(end/2))']';
if (mod(N,2) == 0)
sampleIndex = -N/2:1:N/2-1; %raw index for FFT plot
else
sampleIndex = -(N-1)/2:1:(N-1)/2; %raw index for FFT plot
end
subplot(3,1,2);
plot(deltaF*sampleIndex, Amp);
hold on;
idx = find(Amp > 0.0035);
idx(sampleIndex(idx) < 0) = [];
plot(deltaF*sampleIndex(idx), Amp(idx), '+');
for k = 1:length(idx)
    if (idx(k) > (N-1)/2 && Amp(idx(k))>3.5)
        h = text(deltaF*sampleIndex(idx(k)), Amp(idx(k))+0.15,...
            ['f=' num2str(deltaF*sampleIndex(idx(k))) ' Hz']);
        set(h,'rotation',90)
    end
end
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title(['Heartbeat = ' num2str(deltaF*sampleIndex(idx(1))) ' Hz = ' num2str(60.0*(deltaF*sampleIndex(idx(1)))) ' BPM']);
xlim([0 max(deltaF*sampleIndex)/4]);
subplot(3,1,3);
half_f = deltaF*(0:(N/2));
plot(fftshift([half_f -fliplr(half_f(2:end+mod(N,2)-1))]),abs(fftshift(Y)/N));
xlabel('Frequency [Hz]');
ylabel('Amplitude');
title('Using fftshift');