% Askhsh 3.1

% 3.1a)
filterPoles = [0.51+0.68*1i; 0.51-0.68*1i];
filterZeros = [0.8; -1];
K = 0.15;
figure(1);
zplane(filterZeros,filterPoles);
[b,a] = zp2tf(filterZeros,filterPoles,K);

% 3.1b)
figure(2);
freqz(b,a);

% 3.1c)
figure(3);
impz(b,a);
figure(4);
stepz(b,a);

% 3.1d)
for k = 1:3
    PolesReal = 0.54 + 0.03*k; % Real part of the new poles
    PolesImag = 0.72 + 0.04*k; % Imaginary part of the new poles
    Poles = [PolesReal+PolesImag*1i; PolesReal-PolesImag*1i]; % New poles
    figure(4+k);
    zplane(filterZeros,Poles);
    [B,A] = zp2tf(filterZeros,Poles,K);
    figure(7+k);
    stepz(B,A);
    if k == 1
        figure(11);
        freqz(B,A);
    elseif k == 2
        figure(12);
        freqz(B,A);
    end
end

% 3.1e)
x1 = gensig('sin',20/3,100,1); % Signal part 1
x2 = gensig('sin',20/7,100,1); % Signal part 2
x = x1 + x2; % Input Signal
y = filter(b,a,x); % Output Signal
figure(13);
plot(x); % Plot Input signal
hold on
plot(y); % Plot Output Signal
hold off
legend("Input Signal x[n]","Output Signal y[n]");

% 3.1f)
Poles = [0.68+0.51*1i; 0.68+0.51*1i; 0.68-0.51*1i; 0.68-0.51*1i];
figure(14);
zplane(filterZeros,Poles);
[b,a] = zp2tf(filterZeros,Poles,K);
figure(15);
freqz(b,a);