clc
clear all 
clear variables


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 1. 
% sY(s) + a_0 * Y(s) = b_0 * U(s)

%G = (0.1)/(exp(-6*s)*s + 0.1)

G = tf([0.1],[1,0.1],'InputDelay',6)
Gpade = pade(G,2)
bode(Gpade)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2. 

a = 0.6
B = 10000
y = 0.00001
Ku = 1 
Tu = 1
Kp = a*Ku
TD = B*Tu 
TI = y*Tu

%D = tf([0.1*Kp*TD, 0.1*Kp, 0.1*Kp/TI],[1, 0.1, 0])
%D = Kp*(1+(1/TI*s)+TD*s)
figure()
D = tf([Kp*TD, Kp, Kp/TI],[1 0]);
plant = G*D;
bode(plant)
figure()
rlocus(pade(plant))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 3. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 4a. 

a = 0.6
B = 0.5
y = 0.125

Ku = 3.4
Tu = 1/0.3
Kp = a*Ku
TD = B*Tu 
TI = y*Tu

figure()

D = tf([Kp*TD, Kp, Kp/TI],[1 0]);
bode(G*D)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 4ab. 


t = 0:0.1:6
temp_profile = zeros(size(t))
temp_initial = 20
temp_profile(t < 1) = temp_initial
temp_profile(1 <= t & t < 2) = 35
temp_profile(2 <= t & t < 5) = 42
temp_profile(5 <= t & t <= 6) = temp_initial
u = temp_profile
lsim(G * D, u, t)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 6a. 

Gz=tf(0.1,[1 0.1 0],'InputDelay',6);
c2d(Gz,2)

