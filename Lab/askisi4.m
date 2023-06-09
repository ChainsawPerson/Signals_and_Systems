% Askhsh 4

% 4a)
mixture = audioread("mixture.wav");
Fs = 16000;
%sound(mixture,Fs);
figure(1);
N = length(mixture);
mixture_DFT = fft(mixture,N);
f = linspace(-Fs/2,Fs/2,N);
plot(f,abs(fftshift(mixture_DFT)));
title('Spectrum of mixture');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% 4c)

% Note A -> f = 350Hz
y350 = 0;
Zeros = [-1; 1];

% f0 = 350Hz -> FN0 = 0.137445
Poles = [0.9896+0.1369*1i; 0.9896-0.1369*1i]; % 0.999<FN0
K = 0.0025;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y350 = y350 + y;

% f2 = 700Hz -> FN2 = 0.274889
Poles = [0.9576+0.2701*1i; 0.9576-0.2701*1i]; % 0.995<FN2
K = 0.0055;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y350 = y350 + y;

% f3 = 1050Hz -> FN3 = 0.412334
Poles = [0.9153+0.4003*1i; 0.9153-0.4003*1i]; % 0.999<FN3
K = 0.0015;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y350 = y350 + y;

% f4 = 1400Hz -> FN4 = 0.549779
Poles = [0.85255+0.52245*1i; 0.85255-0.52245*1i]; % 0.9999<FN4
K = 0.0025;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y350 = y350 + y;

% f5 = 1750Hz -> FN5 = 0.687223
Poles = [0.772972+0.634361*1i; 0.772972-0.634361*1i]; % 0.99995<FN5
K = 0.00005;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y350 = y350 + y;

% Note B -> f = 440Hz
y440 = 0;

% f0 = 440Hz -> FN0 = 0.172788
Poles = [0.982+0.171*1i; 0.982-0.171*1i]; % 0.997<FN0
K = 0.0032;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y440 = y440 + y;

% f2 = 880Hz -> FN2 = 0.345575
Poles = [0.9399+0.3384*1i;0.9399-0.3384*1i]; % 0.999<FN2
K = 0.0022;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y440 = y440 + y;

% f3 = 1320Hz -> FN3 = 0.518363
Poles = [0.86+0.49*1i; 0.86-0.49*1i]; % 0.99<FN3
K = 0.01;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y440 = y440 + y;

% f4 = 1760Hz -> FN4 = 0.69115
Poles = [0.7704+0.63736*1i; 0.7704-0.63736*1i]; % 0.9999<FN4
K = 0.0022;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y440 = y440 + y;

% f5 = 2200Hz -> FN5 = 0.863938
Poles = [0.6462+0.7566*1i; 0.6462-0.7566*1i]; % 0.995<FN5
K = 0.005;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture);
y440 = y440 + y;

% 4d)

reed = audioread("reed_acoustic_037-065-075.wav");
flute = audioread("flute_acoustic_002-069-025.wav");

% Reed and Note f0 = 350Hz
%sound(reed,Fs);
%sound(y350,Fs);

% Flute and Note f0 = 440Hz
%sound(flute,Fs);
%sound(y440,Fs);

seg_a = 64000*0.5;
seg_b = 64000*0.6;

%sound(reed(seg_a:seg_b),Fs);
%sound(y350(seg_a:seg_b),Fs);

%sound(flute(seg_a:seg_b),Fs);
%sound(y440(seg_a:seg_b),Fs);

figure(2);
plot(linspace(0,4,N),y350);
figure(3);
plot(linspace(0,4,N),reed);
figure(4);
plot(linspace(0,4,N),y440);
figure(5);
plot(linspace(0,4,N),flute);

% 4e)

mixture2 = audioread("mixture2.wav");
%sound(mixture2,Fs);

% Note A -> f = 220 Hz
Zeros = [-1; 1];
y220 = 0;

% f0 = 220Hz -> FN0 = 0.0863938
Poles = [0.99617+0.086278*1i; 0.99617-0.086278*1i]; % 0.9999<FN0
K = 0.0005;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y220 = y220 + y;

% f2 = 440Hz -> FN2 = 0.172788
Poles = [0.982+0.171*1i; 0.982-0.171*1i]; % 0.997<FN2
K = 0.03;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y220 = y220 + y;

% f3 = 660HZ -> FN3 = 0.259181
Poles = [0.96563+0.25603*1i; 0.96563-0.25603*1i]; % 0.999<FN3
K = 0.0018;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y220 = y220 + y;

% f4 = 880Hz -> FN4 = 0.345575
Poles = [0.9399+0.3384*1i;0.9399-0.3384*1i]; % 0.999<FN4
K = 0.002;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y220 = y220 + y;

% f5 = 1100Hz -> FN5 = 0.43196899
Poles = [0.907235+0.418241*1i; 0.907235-0.418241*1i];
K = 0.0026;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y220 = y220 + y;

% Note B -> f = 440Hz
y440 = 0;

% f0 = 440Hz -> FN0 = 0.172788
Poles = [0.982+0.171*1i; 0.982-0.171*1i]; % 0.997<FN0
K = 0.003;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y440 = y440 + y;

% f2 = 880Hz -> FN2 = 0.345575
Poles = [0.9399+0.3384*1i;0.9399-0.3384*1i]; % 0.999<FN2
K = 0.002;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y440 = y440 + y;

% f3 = 1320Hz -> FN3 = 0.518363
Poles = [0.86+0.49*1i; 0.86-0.49*1i]; % 0.99<FN3
K = 0.01;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y440 = y440 + y;

% f4 = 1760Hz -> FN4 = 0.69115
Poles = [0.7704+0.63736*1i; 0.7704-0.63736*1i]; % 0.9999<FN4
K = 0.0022;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y440 = y440 + y;


% f5 = 2200Hz -> FN5 = 0.863938
Poles = [0.6462+0.7566*1i; 0.6462-0.7566*1i]; % 0.995<FN5
K = 0.005;
[b,a] = zp2tf(Zeros,Poles,K);
y = filter(b,a,mixture2);
y440 = y440 + y;

reed2 = audioread("reed_acoustic_037-057-127.wav");

figure(6);
plot(linspace(0,4,N),y220);
figure(7);
plot(linspace(0,4,N),reed2);
figure(8);
plot(linspace(0,4,N),y440);
figure(9);
plot(linspace(0,4,N),flute);
