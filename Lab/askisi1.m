% Askhsh 1

% 1a)
%name = audiorecorder();
%recordblocking(name,2);
%nameData = getaudiodata(name); % audio -> double
%audiowrite("name.wav",nameData,8000); %saving audio

% 1b)
t = linspace(0,2000,16000); % Xronos se ms
nameData = audioread("name.wav"); % Load audio info
figure(1); % Figure audio signal
plot(t,nameData);
title("Audio Signal");
xlabel("t(ms)");

signalStart = 8000*0.85; % 850ms = 0.85s
signalEnd = 8000*0.9; % 900ms = 0.9s


signal = nameData(signalStart:signalEnd);
sound(signal);
figure(2);
t_signal = linspace(0,50,401); % 50ms
plot(t_signal,signal);
title("Audio Signal Fragment");
xlabel("t(ms)");
%sound(signal);

% Apo to plot tou kommatiou:
% Peak1(14.125, 0.570312)
% Peak2(20.875, 0.640625)
%T = 20.875 - 14.125 = 6.75 ms
% To fonhma antistoixei sto proto "a"
% tou onomatos mou

% 1c)
signal_norm = normalize(nameData,'range',[-1 1]); % normalized signal
figure(3);

M = 200;
n = linspace(0,M,16000);
w = 0.54 - 0.46*cos(2*pi.*n/M); % Hamming

signal_conv = conv(nameData.^2,w); % Calculating Energy
signal_norm = normalize(signal_norm,'range',[min(signal_conv) max(signal_conv)]);
% Normalizing signal
plot(t,signal_norm);
hold on
plot(linspace(0,2000,length(signal_conv)),signal_conv);
hold off
xlabel("t(ms)");
title("Signal and Energy");
legend("Audio Signal","Signal Energy");

% 1d)
N = 1024;
DFT = fft(signal,N);
signal_f = linspace(0,8000,length(DFT));
figure(4);
plot(signal_f,abs(DFT));
xlabel("f(Hz)");
title("DFT linear scale");
figure(5);
plot(signal_f,20*log10(DFT));
xlabel("f(Hz)");
title("DFT logarithmic scale");

