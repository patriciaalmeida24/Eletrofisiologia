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

% canal 1 - mao esq
% canal 2 - braco esq
% canal 3 - mao dir
% canal 4 - braco dir

%% leitura do ficheiro

dados_p1 = readmatrix("Ct1_AB.txt");

%% todos os dados sobrepostos
%figure;
%plot(dados)

%% selecao dos dados canal 1 primeiros 2 minutos
i_end = 423970; % total amostras
ch1 = dados_p1(:, 2);
ch1_line = ch1';
fs = 1000;
s = 2*60;
N = fs*s; % numero de amostras a considerar
ch1_seconds = ch1(1:N);
t = 1/fs:1/fs:s;

%% canal 2
ch2 = dados(:, 3);
ch2_line = ch2';
ch2_seconds = ch2(1:N);

figure;
plot(t, ch1_seconds);
hold on
plot(t, ch2_seconds);
mean_ch2 = mean(ch2_seconds);
ch2_sub_mean = ch2_seconds - mean_ch2;

%% baseline
mean_ch1 = mean(ch1_seconds);
ch1_sub_mean = ch1_seconds - mean_ch1;


figure;
subplot(2,1,1);
plot(t, ch1_seconds)
title('with mean');
subplot(2,1,2);
plot(ch1_sub_mean)
title('baseline');

figure;


%% square
ch1_sq = (ch1_sub_mean).^2;
figure;
subplot(2, 1, 1);
plot(t, ch1_sub_mean)
title('baseline');
subplot(2, 1, 2)
plot(t, ch1_sq) 
title('square')

%% envelope
[yupper, ylower] = envelope(ch1_sq, 1000, 'rms'); % wl ?


figure('Name', 'Channel 1 - Ct1');
subplot(3, 1, 1);
plot(t, ch1_sub_mean)
title('baseline');
subplot(3, 1, 2)
plot(t, ch1_sq) 
title('square')
subplot(3, 1, 3)
plot(t,yupper)
title('envelope');

% graficos sobrepostos
figure;
plot(t, ch1_sq)
hold on
plot(t, yupper)


%% limiar
th = 50000;
indices = zeros(size(yupper));
for i= 1:length(yupper)
    if yupper(i) > th
        indices(i) = 1;
    end
end

figure;
plot(yupper)
hold on
plot(indices*100000)




