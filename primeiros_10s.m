% bioPlux Text File Format
% Version: 513
% StartDateTime: 2014-6-4 14:19:59
% SamplingFrequency: 1000
% SampledChannels: 1 2 3 4 5 6
% SamplingResolution: 12
% AcquiringDevice: 00:07:80:4C:28:6A
% EndOfHeader

% A expressão para transformar os dados fornecidos em mV é:
% EMG(mV) = ((x/2^n - 0,5)*Vcc)/1000
% Onde x é o valor em bruto; n o número de bits = 12 e Vcc = 5.

dados = readmatrix("Ct1_AB.txt");

%% todos os dados sobrepostos
figure;
plot(dados)

%% canal 1 minuto
i_end = 423970; % total amostras
ch1 = dados(:, 2);
ch1_line = ch1';
fs = 1000;
s = 2*60;
N = fs*s;
ch1_seconds = ch1(1:N);
t = 1/fs:1/fs:s;
figure;
plot(t, ch1_seconds);

%% baseline

mean_ch1 = mean(ch1_seconds);
ch1_sub_mean = ch1_seconds - mean_ch1;

figure;
plot(ch1_sub_mean)


%% absoluto
ch1_abs = abs(ch1_sub_mean);
figure;
subplot(2, 1, 1);
plot(t, ch1_sub_mean)
title('sub mean');
subplot(2, 1, 2)
plot(t, ch1_abs) 
title('abs')

%% envelope
[yupper, ylower] = envelope(ch1_abs, 1000, 'rms'); % wl ?

figure('Name', 'Patient 1');
subplot(3, 1, 1);
plot(t, ch1_sub_mean)
title('sub mean');
subplot(3, 1, 2)
plot(t, ch1_abs) 
title('abs')
subplot(3, 1, 3)
plot(t,yupper)
title('envelope');

%%
