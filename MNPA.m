clear;

Cap = 0.25;
L = 0.2;

G = [
    1.0000   -1.0000         0         0         0         0         0    1.0000    ;
   -1.0000    1.5000         0         0         0    1.0000         0         0    ;
         0         0    0.1000         0         0   -1.0000         0         0    ;
         0         0         0   10.0000  -10.0000         0    1.0000         0    ;
         0         0         0  -10.0000   10.0010         0         0         0    ;
         0    1.0000   -1.0000         0         0         0         0         0    ;
         0         0  -10.0000    1.0000         0         0         0         0    ;
    1.0000         0         0         0         0         0         0         0    ;
    ];
    
C = [
       Cap      -Cap         0         0         0         0         0         0    ;
      -Cap       Cap         0         0         0         0         0         0    ;
         0         0         0         0         0         0         0         0    ;
         0         0         0         0         0         0         0         0    ;
         0         0         0         0         0         0         0         0    ;
         0         0         0         0         0        -L         0         0    ;
         0         0         0         0         0         0         0         0    ;
         0         0         0         0         0         0         0         0    ;
    ];

F = [
    0   ;
    0   ;
    0   ;
    0   ;
    0   ;
    0   ;
    0   ;
    1   ;
    ];


%%%%% DC Sweep %%%%%
fig_dc = figure;
hold on;
V3 = [];
V5 = [];
for Vin=-10:0.1:10
    F(8) = Vin; % Set DC voltage
    % Solve for DC
    e = G\F;
    V3 = [V3 e(3)];
    V5 = [V5 e(5)];
end
title('DC Sweep');
xlabel('Vin (V)');
ylabel('Node Voltage (V)');
plot(-10:0.1:10, V3);
plot(-10:0.1:10, V5);
legend('V3', 'VO');

%%%%% AC Sweep %%%%%
fig_ac = figure;
V5 = [];
F(8) = 1; % dc
for w=1E0:1:1E4
    e = (G+2*pi*w*1j*C)\F;
    V5 = [V5 20*log10(abs(e(5)/F(8)))];
end
semilogx(1E0:1:1E4, V5); % log -> db
hold on;
title('AC Sweep');
xlabel('f');
ylabel('Gain');

figure(8);
plot(1E0:1:1E4, V5);
title('AC  Sweep');
xlabel('w');
ylabel('Vo');
    
%%%%% Capacitor Sweep %%%%%
fig_cap = figure;
hold on;
V5 = [];
