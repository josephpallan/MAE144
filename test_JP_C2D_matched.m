clc
clear all
clear variable

h = 1/100
omega_bar = 1 
syms s %z1 p1
Ds = (s+1)/(s*(s+10))

[Dz_semi Dz_strict] = JP_C2D_matched(Ds,h,omega_bar)