clc
clear variables

syms s
b = RR_poly([1,0,-29,0,100]);
a = RR_poly([1,0,-46,0,369,0,-324]);
f= RR_poly([1,20,154,576,1089,972,324]);

RR_diophantine(a,b,f)