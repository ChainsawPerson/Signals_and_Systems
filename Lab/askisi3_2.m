% Askhsh 3.2

% 3.2a)
F_sampling = 44100;
viola = audioread("viola_series.wav");
t = linspace(0,length(viola)/F_sampling,length(viola));
f =linspace(-F_sampling/2,F_sampling/2,F_sampling);
%sound(viola,F_sampling);
figure(1);
plot(t,viola);

% 3.2b)
viola_DFT = fft(viola,F_sampling);
figure(2);
plot(f,fftshift(abs(viola_DFT)));
xlabel("f(Hz)");
title("DFT of 'Viola Series' in linear scale");

% 3.2c)
viola_note = audioread("viola_note.wav");
n = linspace(0,length(viola_note)/F_sampling,length(viola_note));
%sound(viola_note,F_sampling);
figure(3);
plot(n,viola_note);

viola_note_DFT = fft(viola_note,F_sampling);
figure(4);
plot(abs(viola_note_DFT));
xlabel("f(Hz)");
title("DFT of 'Viola Note' in linear scale");

% 3.2d)
viola_note_1st_harmonic = 323;
% 2h armonikh f = 646 Hz -> FN2 = 2*pi*f/Fs = 0.092039
Zeros = [1; -1];
Poles = [0.99527+0.09186*1i; 0.99527-0.09186*1i]; % 0.9995<FN2
K = 0.0005;
[b,a] = zp2tf(Zeros,Poles,K);
figure(5);
freqz(b,a);
y = filter(b,a,viola_note);
figure(6);
plot(f,fftshift(abs(fft(y,F_sampling))));
figure(7);
ya = 6000*0.15;
yb = 6000*0.25;
plot(y(ya:yb));

% 3h armonikh f = 969 Hz -> FN3 = 0.138059
Zeros = [1; -1];
Poles = [0.98999+0.13755*1i; 0.98999-0.13755*1i];
K = 0.003;
[b,a] = zp2tf(Zeros,Poles,K);
figure(8);
freqz(b,a);
y = filter(b,a,viola_note);
figure(9);
plot(f,fftshift(abs(fft(y,F_sampling))));
figure(10);
ya = 6000*0.15;
yb = 6000*0.25;
plot(y(ya:yb));