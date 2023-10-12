function [Dz_semi Dz_strict] = JP_C2D_matched(Ds, h, omega_bar)

% The matched Z-transform method, also called the pole–zero mapping
% or pole–zero matching method is a technique for converting a 
% continuous-time filter design to a discrete-time filter design.

% INPUTS:  Ds = input s-domain transfer function as a symbolic fraction
%          h = sampling period (s)
%          omega_bar = critical frequency of interest whereby  z can be
%          defined by e^(i*omega_bar*h)
% OUTPUTS: Dz_semi = returns a semi-causal matched z-transformed function. The
% number of zeros is equal to the number of poles
%          Dz_strict = returns a strictly-causal matched z-transformed
%          function. The number of zeros is less than the number of poles. 
% TEST:    Ds=(s+1)/(s*(s+10)), h = 1/100, [Dz_semi Dz_strict] = JP_C2D_matched(Ds,h,omega_bar)
% Renaissance Robotics codebase, Appendix A, https://github.com/tbewley/RR


% Step 1: Map each pole/zero to the z-plane

[num den] = numden(Ds)
zeros = roots(sym2poly(num))
poles = roots(sym2poly(den))
z_zeros = exp(zeros * h);
z_poles = exp(poles * h);
Dz = 1; %initial matched Z-transform to apply poles and zeros to

% Add zeros at infinity if necessary
syms z p s
for i = 1:length(z_poles)
    Dz = (Dz)*1/(z-z_poles(i))
end 

for j = 1:length(z_zeros)
    Dz = Dz*(z-z_zeros(j))
end

%create strictly casual. zeros must be less than poles
Dz_strict = Dz
while length(z_poles) > length(z_zeros) + 1
    Dz_strict = [Dz_strict*(z+1)]
    [num den] = numden(Dz_strict)
    zeros = roots(sym2poly(num))
    poles = roots(sym2poly(den))
    z_zeros = exp(zeros * h)
    z_poles = exp(poles * h)


end 

% create semi causal. zeros equal to poles.
Dz_semi = Dz_strict
while length(z_poles) > length(z_zeros)
    Dz_semi = [Dz_semi*(z+1)]
    [num den] = numden(Dz_semi)
    zeros = roots(sym2poly(num))
    poles = roots(sym2poly(den))
    z_zeros = exp(zeros * h)
    z_poles = exp(poles * h)
end 

%Gain factor calculation. Using i*omega_bar and i*omega_bar*h for s and z
%respectively. 

z_gain = exp(i*omega_bar*h)
s_gain = i*omega_bar
strict_Gain = subs(Ds,s,s_gain)/subs(Dz_strict,z,z_gain)

semi_Gain = subs(Ds,s,s_gain)/subs(Dz_semi,z,z_gain)

Dz_strict = vpa(Dz_strict * strict_Gain)
Dz_semi = vpa(Dz_semi * semi_Gain)










