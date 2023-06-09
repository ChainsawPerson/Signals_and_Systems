% Askhsh 1

% Παναγιώτης Σταματόπουλος
% Α.Μ. 03120096

% 1a)
%name = audiorecorder();
%recordblocking(name,2);
%nameData = getaudiodata(name); % audio -> double
%audiowrite("panagiotis.wav",nameData,8000); %saving audio

% 1b)
t = linspace(0,2000,16000); % Xronos se ms
nameData = audioread("panagiotis.wav"); % Load audio info
figure(1); % Figure audio signal
plot(t,nameData);
title("Audio Signal");
xlabel("t(ms)");

signalStart = 8000*0.85; % 850ms = 0.85s
signalEnd = 8000*0.9; % 900ms = 0.9s


signal = nameData(signalStart:signalEnd);
figure(2);
t_signal = linspace(0,50,401); % 50ms
plot(t_signal,signal);
title("Audio Signal Fragment");
xlabel("t(ms)");
%sound(signal);

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

% Figures 1~5

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% Askhsh 2

% 2a)
customIm = imread("leaf3.png"); % Import
figure(6);
imshow(customIm); % Show

% 2b)
[Xn,Yn] = find(customIm); % Load (x,y)
S_c = bwtraceboundary(customIm,[Xn(1) Yn(1)],"W"); % Trace (x,y)
Xtrace_c = S_c(:,1); % x[n]
Ytrace_c = S_c(:,2); % y[n]
figure(7);
plot(Xtrace_c); % Plot x
hold on;
plot(Ytrace_c); % Plot y
hold off;
title("Traces of Image x[n], y[n]");
legend("x[n]","y[n]");

% 2c)
Zn = Xtrace_c + 1i*Ytrace_c; % z[n]
Z_FFT_c = fft(Zn); % Fourier z[n] -> Z[k]
figure(8);
plot(abs(Z_FFT_c));
xlabel("k");
title("DFT z[n] = x[n] + jy[n]");

% 2d)
N_c = length(Z_FFT_c);
for j = 1:3
    if (j == 1)
        M = 10;
    elseif (j == 2)
        M = 50;
    else
        M = 200;
    end
    zM = zeros(N_c, 1);
    for n = 1:N_c
        zM(n) = Fr(N_c, M, n, Z_FFT_c);
    end
    figure(8+j);
    xMn = abs(round(real(zM)));
    yMn = abs(round(imag(zM)));
    I_M_c = reconstruct(xMn,yMn);
    imshow(I_M_c);
    
end

% 2e)
for j = 1:3
    if (j == 1)
        M = 10;
    elseif (j == 2)
        M = 50;
    else
        M = 200;
    end
    zM = zeros(N_c, 1);
    for n = 1:N_c
        zM(n) = Fr(N_c, M/2, n-1, Z_FFT_c) + FrK(N_c, M, n-1, Z_FFT_c);
    end
    figure(11+j);
    xMn = abs(round(real(zM)));
    yMn = abs(round(imag(zM)));
    I_M_c = reconstruct(xMn,yMn);
    imshow(I_M_c);
end

% 2f)
customIm = imread("customImage.bmp"); % Import
figure(15);
imshow(customIm); % Show

[Xn,Yn] = find(customIm); % Load (x,y)
S_c = bwtraceboundary(customIm,[Xn(1) Yn(1)],"W"); % Trace (x,y)
Xtrace_c = S_c(:,1); % x[n]
Ytrace_c = S_c(:,2); % y[n]
figure(16);
plot(Xtrace_c); % Plot x
hold on;
plot(Ytrace_c); % Plot y
hold off;
title("Traces of Image x[n], y[n]");
legend("x[n]","y[n]");

Zn = Xtrace_c + 1i*Ytrace_c; % z[n]
Z_FFT_c = fft(Zn); % Fourier z[n] -> Z[k]
figure(17);
plot(abs(Z_FFT_c));
xlabel("k");
title("DFT z[n] = x[n] + jy[n]");

N_c = length(Z_FFT_c);
for j = 1:3
    if (j == 1)
        M = 10;
    elseif (j == 2)
        M = 50;
    else
        M = 200;
    end
    zM = zeros(N_c, 1);
    for n = 1:N_c
        zM(n) = Fr(N_c, M, n, Z_FFT_c);
    end
    figure(17+j);
    xMn = abs(round(real(zM)));
    yMn = abs(round(imag(zM)));
    I_M_c = reconstruct(xMn,yMn);
    imshow(I_M_c);
    
end

% 2nd
for j = 1:3
    if (j == 1)
        M = 10;
    elseif (j == 2)
        M = 50;
    else
        M = 200;
    end
    zM = zeros(N_c, 1);
    for n = 1:N_c
        zM(n) = Fr(N_c, M/2, n-1, Z_FFT_c) + FrK(N_c, M, n-1, Z_FFT_c);
    end
    figure(20+j);
    xMn = abs(round(real(zM)));
    yMn = abs(round(imag(zM)));
    I_M_c = reconstruct(xMn,yMn);
    imshow(I_M_c);
end


% Figures 6~23

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% Askhsh 3


% Askhsh 3.1

% 3.1a)
filterPoles = [0.51+0.68*1i; 0.51-0.68*1i];
filterZeros = [0.8; -1];
K = 0.15;
figure(24);
zplane(filterZeros,filterPoles);
[b,a] = zp2tf(filterZeros,filterPoles,K);

% 3.1b)
figure(25);
freqz(b,a);

% 3.1c)
figure(26);
impz(b,a);
figure(27);
stepz(b,a);

% 3.1d)
for k = 1:3
    PolesReal = 0.54 + 0.03*k; % Real part of the new poles
    PolesImag = 0.72 + 0.04*k; % Imaginary part of the new poles
    Poles = [PolesReal+PolesImag*1i; PolesReal-PolesImag*1i]; % New poles
    figure(27+k);
    zplane(filterZeros,Poles);
    [B,A] = zp2tf(filterZeros,Poles,K);
    figure(30+k);
    stepz(B,A);
    if k == 1
        figure(34);
        freqz(B,A);
    elseif k == 2
        figure(35);
        freqz(B,A);
    end
end

% 3.1e)
x1 = gensig('sin',20/3,100,1); % Signal part 1
x2 = gensig('sin',20/7,100,1); % Signal part 2
x = x1 + x2; % Input Signal
y = filter(b,a,x); % Output Signal
figure(36);
plot(x); % Plot Input signal
hold on
plot(y); % Plot Output Signal
hold off
legend("Input Signal x[n]","Output Signal y[n]");

% 3.1f)
Poles = [0.68+0.51*1i; 0.68+0.51*1i; 0.68-0.51*1i; 0.68-0.51*1i];
figure(37);
zplane(filterZeros,Poles);
[b,a] = zp2tf(filterZeros,Poles,K);
figure(38);
freqz(b,a);


% Askhsh 3.2

% 3.2a)
F_sampling = 44100;
viola = audioread("viola_series.wav");
t = linspace(0,length(viola)/F_sampling,length(viola));
f =linspace(-F_sampling/2,F_sampling/2,F_sampling);
%sound(viola,F_sampling);
figure(39);
xlabel("t(s)");
title("Viola Series");
plot(t,viola);

% 3.2b)
viola_DFT = fft(viola,F_sampling);
figure(40);
plot(f,fftshift(abs(viola_DFT)));
xlabel("f(Hz)");
title("DFT of 'Viola Series' in linear scale");

% 3.2c)
viola_note = audioread("viola_note.wav");
n = linspace(0,length(viola_note)/F_sampling,length(viola_note));
%sound(viola_note,F_sampling);
figure(41);
title("Viola Note");
xlabel("t(s)");
plot(n,viola_note);

viola_note_DFT = fft(viola_note,F_sampling);
figure(42);
plot(f,fftshift(abs(viola_note_DFT)));
xlabel("f(Hz)");
title("DFT of 'Viola Note' in linear scale");

% 3.2d)
viola_note_1st_harmonic = 323;
% 2h armonikh f = 646 Hz -> FN2 = 2*pi*f/Fs = 0.092039
Zeros = [1; -1];
Poles = [0.99527+0.09186*1i; 0.99527-0.09186*1i]; % 0.9995<FN2
K = 0.0005;
[b,a] = zp2tf(Zeros,Poles,K);
figure(43);
freqz(b,a);
y = filter(b,a,viola_note);
figure(44);
title("Spectrum of filtered signal (f = 646Hz)");
xlabel("f(Hz)");
plot(f,fftshift(abs(fft(y,F_sampling))));
figure(45);
ya = 6000*0.15;
yb = 6000*0.25;
title("Segment of filtered signal (f = 646Hz)");
xlabel("100ms")
plot(y(ya:yb));

% 3h armonikh f = 969 Hz -> FN3 = 0.138059
Zeros = [1; -1];
Poles = [0.98999+0.13755*1i; 0.98999-0.13755*1i];
K = 0.003;
[b,a] = zp2tf(Zeros,Poles,K);
figure(46);
freqz(b,a);
y = filter(b,a,viola_note);
figure(47);
title("Spectrum of filtered signal (f = 969Hz)");
xlabel("f(Hz)");
plot(f,fftshift(abs(fft(y,F_sampling))));
figure(48);
ya = 6000*0.15;
yb = 6000*0.25;
title("Segment of filtered signal (f = 969Hz)");
xlabel("100ms")
plot(y(ya:yb));

%Figures 24~48

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% Askhsh 4

% 4a)
mixture = audioread("mixture.wav");
Fs = 16000;
%sound(mixture,Fs);
figure(49);
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

figure(50);
title("Filtered signal (f = 350Hz)");
xlabel("t(s)");
plot(linspace(0,4,N),y350);

figure(51);
title("Reed");
xlabel("t(s)");
plot(linspace(0,4,N),reed);

figure(52);
title("Filtered signal (f = 440Hz)");
xlabel("t(s)");
plot(linspace(0,4,N),y440);

figure(53);
title("Flute");
xlabel("t(s)");
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

figure(54);
title("Filtered signal (f = 220Hz)");
xlabel("t(s)");
plot(linspace(0,4,N),y220);

figure(55);
title("Reed");
xlabel("t(s)");
plot(linspace(0,4,N),reed2);

figure(56);
title("Filtered signal (f = 440Hz)");
xlabel("t(s)");
plot(linspace(0,4,N),y440);

figure(57);
title("Flute");
xlabel("t(s)");
plot(linspace(0,4,N),flute);

% Figures 49~57

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% Functions

function z_M = Fr(N, M, n, z_k)
% Calculate Fourier 
    z_M = 0;
    for k = 1:M+1 
        z_M = z_M + (z_k(k)*exp(1i*2*pi*(k-1)*n/N));
    end
    z_M = z_M./N;
end

function z_MK = FrK(N, M, n, z_k)
% Calculate Fourier 
    z_MK = 0;
    K = N - M/2;
    for k = K:(N-1)
        z_MK = z_MK + (z_k(k+1)*exp(1i*2*pi*k*n/N));
    end
    z_MK = z_MK./N;
end

function ImageRec = reconstruct(x, y)
    for i = 1:length(x)
            d = x(i);
            e = y(i);
            ImageRec(d+1, e+1) = 1;
    end 
end
