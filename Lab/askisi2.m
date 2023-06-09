% Askhsh 2

% 2a)
customIm = imread("leaf3.png"); % Import
figure(1);
imshow(customIm); % Show

% 2b)
[Xn,Yn] = find(customIm); % Load (x,y)
S_c = bwtraceboundary(customIm,[Xn(1) Yn(1)],"W"); % Trace (x,y)
Xtrace_c = S_c(:,1); % x[n]
Ytrace_c = S_c(:,2); % y[n]
figure(2);
plot(Xtrace_c); % Plot x
hold on;
plot(Ytrace_c); % Plot y
hold off;
title("Traces of Image x[n], y[n]");
legend("x[n]","y[n]");

% 2c)
Zn = Xtrace_c + 1i*Ytrace_c; % z[n]
Z_FFT_c = fft(Zn); % Fourier z[n] -> Z[k]
figure(3);
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
    zM_n = zeros(N_c, 1);
    for n = 1:N_c
        zM_n(n) = Fr(N_c, M, n, Z_FFT_c);
    end
    zM = zM_n/N_c;
    figure(3+j);
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
    zM_n = zeros(N_c, 1);
    for n = 1:N_c
        zM_n(n) = Fr(N_c, M/2, n-1, Z_FFT_c) + FrK(N_c, M, n-1, Z_FFT_c);
    end
    zM = zM_n/N_c;
    figure(6+j);
    xMn = abs(round(real(zM)));
    yMn = abs(round(imag(zM)));
    I_M_c = reconstruct(xMn,yMn);
    imshow(I_M_c);
end

% 2f)
customIm = imread("customImage.bmp"); % Import
figure(10);
imshow(customIm); % Show

[Xn,Yn] = find(customIm); % Load (x,y)
S_c = bwtraceboundary(customIm,[Xn(1) Yn(1)],"W"); % Trace (x,y)
Xtrace_c = S_c(:,1); % x[n]
Ytrace_c = S_c(:,2); % y[n]
figure(11);
plot(Xtrace_c); % Plot x
hold on;
plot(Ytrace_c); % Plot y
hold off;
title("Traces of Image x[n], y[n]");
legend("x[n]","y[n]");

Zn = Xtrace_c + 1i*Ytrace_c; % z[n]
Z_FFT_c = fft(Zn); % Fourier z[n] -> Z[k]
figure(12);
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
    zM_n = zeros(N_c, 1);
    for n = 1:N_c
        zM_n(n) = Fr(N_c, M, n, Z_FFT_c);
    end
    zM = zM_n/N_c;
    figure(12+j);
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
    zM_n = zeros(N_c, 1);
    for n = 1:N_c
        zM_n(n) = Fr(N_c, M/2, n-1, Z_FFT_c) + FrK(N_c, M, n-1, Z_FFT_c);
    end
    zM = zM_n/N_c;
    figure(15+j);
    xMn = abs(round(real(zM)));
    yMn = abs(round(imag(zM)));
    I_M_c = reconstruct(xMn,yMn);
    imshow(I_M_c);
end

function z_M = Fr(N, M, n, z_k)
% Calculate Fourier 
% Usage: z_M = Fr(N,M,n,z_k)
    z_M = 0;
    for k = 1:M+1 
        z_M = z_M + (z_k(k)*exp(1i*2*pi*(k-1)*n/N));
    end
end

function z_MK = FrK(N, M, n, z_k)
% Calculate Fourier
% Usage: z_M = FrK(N,M,n,z_k)
    z_MK = 0;
    K = N - M/2;
    for k = K:(N-1)
        z_MK = z_MK + (z_k(k+1)*exp(1i*2*pi*k*n/N));
    end
end

function I_r = reconstruct(x, y)
    for i = 1:length(x)
            d = x(i);
            e = y(i);
            I_r(d+1, e+1) = 1;
    end 
end